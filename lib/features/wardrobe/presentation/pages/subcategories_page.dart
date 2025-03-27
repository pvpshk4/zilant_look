import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/wardrobe_subcategory_widget.dart';

class SubcategoriesPage extends StatelessWidget {
  final String category;

  const SubcategoriesPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final subcategories = _getSubcategoriesForCategory(category);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Гардероб', style: TextStyle(fontSize: 20)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/wardrobe'),
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
          Expanded(
            child: ListView.builder(
              itemCount: subcategories.length,
              itemBuilder: (context, index) {
                final subcategory = subcategories[index];
                return WardrobeSubcategoryWidget(
                  title: subcategory,
                  onTap:
                      () => context.go(
                        '/wardrobe/products/$category/$subcategory',
                      ),
                );
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

  List<String> _getSubcategoriesForCategory(String category) {
    switch (category) {
      case 'female':
        return ['Платья', 'Юбки', 'Блузки'];
      case 'male':
        return ['Рубашки', 'Брюки', 'Костюмы'];
      case 'kids':
        return ['Школьная форма', 'Игровая одежда'];
      case 'accessories':
        return ['Часы', 'Очки', 'Шляпы'];
      default:
        return [];
    }
  }
}
