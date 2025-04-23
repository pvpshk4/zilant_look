import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zilant_look/common/domain/entities/clothing_item_entity.dart';
import '../bloc/wardrobe_bloc.dart';
import '../bloc/wardrobe_event.dart';
import '../bloc/wardrobe_state.dart';
import '../widgets/wardrobe_products_filter_widget.dart';
import '../widgets/wardrobe_products_grid_widget.dart';
import '../widgets/wardrobe_search_widget.dart';

class ProductsPage extends StatefulWidget {
  final String category;
  final String subcategory;
  final Map<String, dynamic>? extra;

  const ProductsPage({
    super.key,
    required this.category,
    required this.subcategory,
    this.extra,
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ScrollController _scrollController = ScrollController();
  String _selectedSubSubcategory = '';
  final Map<String, GlobalKey> _sectionKeys = {};
  bool _shouldScrollToSubSubcategory = false;
  String? _previousRoute;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<WardrobeBloc>().add(
      LoadSubSubcategoriesEvent(widget.category, widget.subcategory),
    );

    if (widget.extra != null) {
      _selectedSubSubcategory = widget.extra!['subSubcategory'] ?? '';
      _shouldScrollToSubSubcategory =
          widget.extra!['scrollToSubSubcategory'] ?? false;
      _previousRoute = widget.extra!['previousRoute'];
      if (_selectedSubSubcategory.isNotEmpty) {
        _loadWardrobeItems();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= maxScroll * 0.9) {
      context.read<WardrobeBloc>().add(
        LoadMoreWardrobeItemsEvent(
          username: 'default_user',
          category: widget.category,
          subcategory: widget.subcategory,
          subSubcategory: _selectedSubSubcategory,
          page: 0,
          limit: 0,
        ),
      );
    }
  }

  void _loadWardrobeItems() {
    context.read<WardrobeBloc>().add(
      LoadWardrobeEvent(
        username: 'default_user',
        category: widget.category,
        subcategory: widget.subcategory,
        subSubcategory: _selectedSubSubcategory,
      ),
    );
  }

  void _scrollToSection(String subSubcategory) {
    setState(() {
      _selectedSubSubcategory = subSubcategory;
    });

    final key = _sectionKeys[subSubcategory];
    if (key != null && key.currentContext != null) {
      final RenderBox renderBox =
          key.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero).dy;
      const double offsetAdjustment = 154;
      _scrollController.animateTo(
        _scrollController.offset + position - offsetAdjustment,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Гардероб',
          style: TextStyle(fontSize: 20, fontFamily: 'SFPro-Medium'),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_previousRoute != null &&
                _previousRoute!.contains('subcategories')) {
              context.go('/wardrobe/subcategories/${widget.category}');
            } else {
              context.go('/wardrobe');
            }
          },
        ),
      ),
      body: BlocConsumer<WardrobeBloc, WardrobeState>(
        listenWhen: (previous, current) {
          return current is WardrobeLoadedState &&
              _shouldScrollToSubSubcategory;
        },
        listener: (context, state) {
          if (state is WardrobeLoadedState && _shouldScrollToSubSubcategory) {
            if (_selectedSubSubcategory.isNotEmpty) {
              _scrollToSection(_selectedSubSubcategory);
              _shouldScrollToSubSubcategory = false;
            }
          }
        },
        buildWhen: (previous, current) {
          return current is WardrobeLoadingState ||
              current is SubSubcategoriesLoadedState ||
              current is WardrobeLoadedState ||
              current is WardrobeLoadingMoreState;
        },
        builder: (context, state) {
          if (state is WardrobeLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          List<String> subSubcategories = state.subSubcategories;
          if (state is SubSubcategoriesLoadedState) {
            if (_selectedSubSubcategory.isEmpty &&
                subSubcategories.isNotEmpty) {
              _selectedSubSubcategory = subSubcategories.first;
              _loadWardrobeItems();
            }
            for (final subSubcategory in subSubcategories) {
              _sectionKeys[subSubcategory] = GlobalKey();
            }
          }

          Map<String, List<ClothingItemEntity>> groupedItems = {};
          bool isLoadingMore = false;
          if (state is WardrobeLoadedState) {
            groupedItems = state.groupedItems;
          } else if (state is WardrobeLoadingMoreState) {
            groupedItems = state.groupedItems;
            isLoadingMore = true;
          }

          return Column(
            children: [
              WardrobeSearchWidget(
                basePath:
                    '/wardrobe/products/${widget.category}/${widget.subcategory}',
                onScrollToSubSubcategory: _scrollToSection,
              ),
              if (subSubcategories.isNotEmpty)
                WardrobeProductsFilterWidget(
                  subSubcategories: subSubcategories,
                  selectedSubSubcategory: _selectedSubSubcategory,
                  onSubSubcategorySelected: (subSubcategory) {
                    _scrollToSection(subSubcategory);
                  },
                ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: groupedItems.keys.length + (isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == groupedItems.keys.length && isLoadingMore) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final subSubcategory = groupedItems.keys.elementAt(index);
                    final items = groupedItems[subSubcategory] ?? [];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          key: _sectionKeys[subSubcategory],
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                            left: 20,
                          ),
                          child: Text(
                            subSubcategory.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 17,
                              fontFamily: 'SFPro-Semibold',
                            ),
                          ),
                        ),
                        WardrobeProductsGridWidget(
                          items: items,
                          scrollController: ScrollController(),
                          isLoadingMore: false,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
