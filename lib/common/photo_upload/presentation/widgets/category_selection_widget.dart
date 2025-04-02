import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/photo_upload_bloc.dart';

class CategorySelectionWidget extends StatelessWidget {
  const CategorySelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<PhotoUploadBloc>(context),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryRow('Основная категория', [
              'Верхняя одежда',
              'Обувь',
            ]),
            _buildCategoryRow('Подкатегория', ['Куртки', 'Пальто']),
            _buildCategoryRow('Тип', ['Демисезонные', 'Зимние']),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryRow(String title, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8,
            children:
                items
                    .map(
                      (item) => FilterChip(
                        label: Text(item),
                        onSelected: (_) => _handleSelection(title, item),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }

  void _handleSelection(String category, String value) {
    // Логика обработки выбора категории
  }
}
