import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/photo_upload_bloc.dart';
import '../bloc/photo_upload_event.dart';
import '../bloc/photo_upload_state.dart';

enum UploadType { human, clothes }

class PhotoUploadPage extends StatelessWidget {
  final UploadType uploadType;

  const PhotoUploadPage({super.key, required this.uploadType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PhotoUploadBloc>(),
      child: _PhotoUploadContent(uploadType: uploadType),
    );
  }
}

class _PhotoUploadContent extends StatelessWidget {
  final UploadType uploadType;

  const _PhotoUploadContent({required this.uploadType});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoUploadBloc, PhotoUploadState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Блок для фото
                  _buildPhotoContainer(context, state),

                  // Кнопка выбора категории
                  if (state is PhotoUploadImageSelectedState)
                    _buildCategoryButton(context),

                  // Кнопки выбора фото
                  if (state is! PhotoUploadImageSelectedState)
                    _buildPhotoSelectionButtons(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhotoContainer(BuildContext context, PhotoUploadState state) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: _getPhotoContent(state),
    );
  }

  Widget _getPhotoContent(PhotoUploadState state) {
    if (state is PhotoUploadImageSelectedState) {
      return Image.file(File(state.imagePath), fit: BoxFit.fitHeight);
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.camera_alt, size: 50, color: Colors.grey),
        const SizedBox(height: 16),
        Text(
          uploadType == UploadType.human ? 'Фото человека' : 'Фото одежды',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildPhotoSelectionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.camera_alt),
            label: const Text('Камера'),
            onPressed:
                () => context.read<PhotoUploadBloc>().add(
                  TakePhotoFromCameraEvent(),
                ),
          ),
          const SizedBox(width: 20),
          ElevatedButton.icon(
            icon: const Icon(Icons.photo_library),
            label: const Text('Галерея'),
            onPressed:
                () => context.read<PhotoUploadBloc>().add(
                  ChoosePhotoFromGalleryEvent(),
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.black),
          minimumSize: const Size(double.infinity, 50),
        ),
        onPressed: () => _showCategorySelection(context),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text('Выберите категорию'), Icon(Icons.arrow_drop_down)],
        ),
      ),
    );
  }

  void _showCategorySelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => _CategorySelectionWidget(
            onCategorySelected: (category, subcategory, subSubcategory) {
              // Обработка выбранных категорий
              context.read<PhotoUploadBloc>().add(
                SelectCategoryEvent(
                  category: category,
                  subcategory: subcategory,
                  subSubcategory: subSubcategory,
                ),
              );
            },
          ),
    );
  }
}

class _CategorySelectionWidget extends StatefulWidget {
  final Function(String, String, String) onCategorySelected;

  const _CategorySelectionWidget({required this.onCategorySelected});

  @override
  State<_CategorySelectionWidget> createState() =>
      _CategorySelectionWidgetState();
}

class _CategorySelectionWidgetState extends State<_CategorySelectionWidget> {
  String? _selectedMainCategory;
  String? _selectedSubCategory;

  final Map<String, List<String>> _categories = {
    'Верхняя одежда': ['Куртки', 'Пальто', 'Парки'],
    'Обувь': ['Кроссовки', 'Туфли', 'Ботинки'],
    'Аксессуары': ['Шарфы', 'Шапки', 'Перчатки'],
  };

  final Map<String, List<String>> _subCategories = {
    'Куртки': ['Демисезонные', 'Зимние', 'Дождевики'],
    'Пальто': ['Шерстяные', 'Тренч', 'Пуховые'],
    'Парки': ['Зимние', 'Демисезонные'],
    'Кроссовки': ['Спортивные', 'Повседневные'],
    'Туфли': ['Офисные', 'Вечерние'],
    'Ботинки': ['Зимние', 'Осенние'],
    'Шарфы': ['Шерстяные', 'Шелковые'],
    'Шапки': ['Вязаные', 'Меховые'],
    'Перчатки': ['Кожаные', 'Вязаные'],
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Основные категории
          if (_selectedMainCategory == null) ...[
            ..._categories.keys.map(
              (category) => ListTile(
                key: ValueKey('main_category_$category'),
                contentPadding: const EdgeInsets.only(
                  left: 16,
                ), // Отступ для первого уровня
                title: Text(category),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () => setState(() => _selectedMainCategory = category),
              ),
            ),
          ] else if (_selectedSubCategory == null) ...[
            // Подкатегории
            ListTile(
              key: const ValueKey('back_button_main'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => setState(() => _selectedMainCategory = null),
              ),
              title: Text(
                _selectedMainCategory!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ..._categories[_selectedMainCategory]!.map(
              (subCategory) => ListTile(
                key: ValueKey('sub_category_$subCategory'),
                contentPadding: const EdgeInsets.only(
                  left: 32,
                ), // Увеличенный отступ для второго уровня
                title: Text(subCategory),
                trailing:
                    _subCategories.containsKey(subCategory)
                        ? const Icon(Icons.arrow_forward)
                        : null,
                onTap: () {
                  if (_subCategories.containsKey(subCategory)) {
                    setState(() => _selectedSubCategory = subCategory);
                  } else {
                    _finishSelection(
                      context,
                      _selectedMainCategory!,
                      subCategory,
                      '',
                    );
                  }
                },
              ),
            ),
          ] else ...[
            // Конечные категории
            ListTile(
              key: const ValueKey('back_button_sub'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => setState(() => _selectedSubCategory = null),
              ),
              title: Text(
                _selectedSubCategory!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ..._subCategories[_selectedSubCategory]!.map(
              (finalCategory) => ListTile(
                key: ValueKey('final_category_$finalCategory'),
                contentPadding: const EdgeInsets.only(
                  left: 48,
                ), // Еще больше отступ для третьего уровня
                title: Text(finalCategory),
                onTap:
                    () => _finishSelection(
                      context,
                      _selectedMainCategory!,
                      _selectedSubCategory!,
                      finalCategory,
                    ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _finishSelection(
    BuildContext context,
    String category,
    String subcategory,
    String subSubcategory,
  ) {
    widget.onCategorySelected(category, subcategory, subSubcategory);
    Navigator.pop(context);
  }
}
