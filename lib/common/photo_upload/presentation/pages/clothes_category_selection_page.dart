import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zilant_look/common/photo_upload/presentation/bloc/photo_upload_event.dart';
import '../bloc/photo_upload_bloc.dart';
import '../bloc/photo_upload_state.dart';
import '../widgets/photo_container.dart';
import '../widgets/category_selector.dart';
import '../widgets/apply_checkbox.dart';
import '../widgets/action_buttons.dart';

class ClothesCategorySelectionPage extends StatefulWidget {
  final String imagePath;

  const ClothesCategorySelectionPage({super.key, required this.imagePath});

  @override
  State<ClothesCategorySelectionPage> createState() =>
      _ClothesCategorySelectionPageState();
}

class _ClothesCategorySelectionPageState
    extends State<ClothesCategorySelectionPage> {
  String? _category;
  String? _subcategory;
  String? _subSubcategory;
  bool _applyImmediately = false;
  bool _isExpanded = false;
  final Map<String, bool> _expandedCategories = {};
  final Map<String, bool> _expandedSubcategories = {};

  // Тестовые данные для категорий
  final Map<String, Map<String, List<String>>> _categories = {
    'Женское': {
      'Платья': ['Вечерние', 'Повседневные', 'Коктейльные'],
      'Верхняя одежда': ['Куртки', 'Пальто', 'Жилеты'],
      'Аксессуары': ['Часы', 'Ремни', 'Шарфы'],
    },
    'Мужское': {
      'Куртки': ['Парки', 'Бомберы', 'Ветровки'],
      'Брюки': ['Джинсы', 'Шорты', 'Леггинсы'],
      'Аксессуары': ['Часы', 'Ремни', 'Шарфы'],
    },
    'Детское': {
      'Куртки': ['Зимние', 'Демисезонные', 'Лёгкие'],
      'Штаны': ['Комбинезоны', 'Шорты', 'Леггинсы'],
      'Аксессуары': ['Шапки', 'Перчатки', 'Шарфы'],
    },
  };

  @override
  void initState() {
    super.initState();
    // Инициализируем состояния раскрытия категорий и подкатегорий
    for (var category in _categories.keys) {
      _expandedCategories[category] = false;
      for (var subcategory in _categories[category]!.keys) {
        _expandedSubcategories['$category-$subcategory'] = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhotoUploadBloc, PhotoUploadState>(
      listener: (context, state) {
        if (state is PhotoUploadSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Фото успешно загружено'),
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.of(context).popUntil((route) => route.isFirst);
        } else if (state is PhotoUploadFailureState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Фото
                    PhotoContainer(imagePath: widget.imagePath),
                    const SizedBox(height: 24.0),
                    // Селектор категорий
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: CategorySelector(
                        categories: _categories,
                        isExpanded: _isExpanded,
                        expandedCategories: _expandedCategories,
                        expandedSubcategories: _expandedSubcategories,
                        onCategorySelected: (
                          category,
                          subcategory,
                          subSubcategory,
                        ) {
                          setState(() {
                            _category = category;
                            _subcategory = subcategory;
                            _subSubcategory = subSubcategory;
                          });
                        },
                        onExpandChanged: (isExpanded) {
                          setState(() {
                            _isExpanded = isExpanded;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Чекбокс и кнопки
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Column(
              children: [
                ApplyCheckbox(
                  value: _applyImmediately,
                  onChanged: (value) {
                    setState(() {
                      _applyImmediately = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 8.0),
                ActionButtons(
                  subSubcategory: _subSubcategory,
                  onCancel: () {
                    context.read<PhotoUploadBloc>().add(
                      CancelPhotoUploadEvent(),
                    );
                    Navigator.of(context).pop();
                  },
                  onSave: () {
                    context.read<PhotoUploadBloc>().add(
                      SelectCategoryEvent(
                        category: _category!,
                        subcategory: _subcategory!,
                        subSubcategory: _subSubcategory!,
                      ),
                    );
                    context.read<PhotoUploadBloc>().add(
                      SavePhotoEvent(context),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
