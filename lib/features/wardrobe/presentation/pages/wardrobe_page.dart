import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/wardrobe_category_widget.dart';

class WardrobePage extends StatelessWidget {
  const WardrobePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Гардероб', style: TextStyle(fontSize: 20)),
        centerTitle: true,
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
            child: ListView(
              children: [
                WardrobeCategoryWidget(
                  title: 'Женское',
                  onTap: () => context.go('/wardrobe/subcategories/female'),
                ),
                WardrobeCategoryWidget(
                  title: 'Мужское',
                  onTap: () => context.go('/wardrobe/subcategories/male'),
                ),
                WardrobeCategoryWidget(
                  title: 'Детское',
                  onTap: () => context.go('/wardrobe/subcategories/kids'),
                ),
                WardrobeCategoryWidget(
                  title: 'Аксессуары',
                  onTap:
                      () => context.go('/wardrobe/subcategories/accessories'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
