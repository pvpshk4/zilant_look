import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/photo_upload_bloc.dart';
import '../bloc/photo_upload_event.dart';
import '../bloc/photo_upload_state.dart';

class CategoryButtonWidget extends StatelessWidget {
  final String label;

  const CategoryButtonWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.black),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () => _showCategoryDialog(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(label), const Icon(Icons.arrow_drop_down)],
        ),
      ),
    );
  }

  void _showCategoryDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => BlocProvider.value(
            value: BlocProvider.of<PhotoUploadBloc>(context),
            child: const _CategorySelectionDialog(),
          ),
    );
  }
}

class _CategorySelectionDialog extends StatelessWidget {
  const _CategorySelectionDialog();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCategoryRow(context, 'Основная категория', [
            'Верхняя одежда',
            'Обувь',
          ]),
          _buildCategoryRow(context, 'Подкатегория', ['Куртки', 'Пальто']),
          _buildCategoryRow(context, 'Тип', ['Демисезонные', 'Зимние']),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(
    BuildContext context,
    String title,
    List<String> items,
  ) {
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
                        onSelected:
                            (_) => _handleSelection(context, title, item),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }

  void _handleSelection(
    BuildContext context,
    String categoryType,
    String value,
  ) {
    final bloc = context.read<PhotoUploadBloc>();
    final currentState = bloc.state;

    if (currentState is! CategorySelectionState) return;

    if (categoryType == 'Основная категория') {
      bloc.add(
        SelectCategoryEvent(
          category: value,
          subcategory: '',
          subSubcategory: '',
        ),
      );
    } else if (categoryType == 'Подкатегория') {
      bloc.add(
        SelectCategoryEvent(
          category: currentState.category,
          subcategory: value,
          subSubcategory: '',
        ),
      );
    } else {
      bloc.add(
        SelectCategoryEvent(
          category: currentState.category,
          subcategory: currentState.subcategory,
          subSubcategory: value,
        ),
      );
    }
  }
}
