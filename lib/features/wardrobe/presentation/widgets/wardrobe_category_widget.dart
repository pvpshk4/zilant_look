// wardrobe_category_widget.dart
import 'package:flutter/material.dart';

class WardrobeCategoryWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const WardrobeCategoryWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 17, fontFamily: 'SFPro-Bold'),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
