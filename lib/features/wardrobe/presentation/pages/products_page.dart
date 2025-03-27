import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zilant_look/features/wardrobe/presentation/widgets/wardrobe_product_filter_widget.dart';
import 'package:zilant_look/features/wardrobe/presentation/widgets/wardrobe_item_widget.dart';

import '../bloc/wardrobe_bloc.dart';
import '../bloc/wardrobe_event.dart';
import '../bloc/wardrobe_state.dart';

class ProductsPage extends StatefulWidget {
  final String category;
  final String subcategory;

  const ProductsPage({
    super.key,
    required this.category,
    required this.subcategory,
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final ScrollController _scrollController = ScrollController();
  String _selectedFilter = '';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<WardrobeBloc>().add(LoadWardrobeEvent());
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
        LoadMoreWardrobeItemsEvent(limit: 10, offset: 1),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Гардероб', style: TextStyle(fontSize: 20)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:
              () => context.go('/wardrobe/subcategories/${widget.category}'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Поиск',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          WardrobeProductFilterWidget(
            filters: ['Фильтр 1', 'Фильтр 2', 'Фильтр 3'],
            selectedFilter: _selectedFilter,
            onFilterSelected: (filter) {
              setState(() {
                _selectedFilter = filter;
              });
              context.read<WardrobeBloc>().add(
                FilterWardrobeByCategoryEvent(
                  category: widget.category,
                  subcategory: widget.subcategory,
                  filter: filter,
                ),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<WardrobeBloc, WardrobeState>(
              builder: (context, state) {
                if (state is WardrobeLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WardrobeLoadedState) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount:
                        state.items.length + 1, // +1 для индикатора загрузки
                    itemBuilder: (context, index) {
                      if (index < state.items.length) {
                        final item = state.items[index];
                        return WardrobeItemWidget(
                          title: item.name,
                          subtitle:
                              '${widget.category} > ${widget.subcategory}',
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  );
                } else if (state is WardrobeErrorState) {
                  return Center(child: Text(state.message));
                } else {
                  return const Center(child: Text('Неизвестное состояние'));
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/photo_upload'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
