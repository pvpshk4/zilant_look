import 'package:flutter/material.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(child: Container(color: Colors.grey[300])),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(height: 16, width: 100, color: Colors.grey[300]),
          ),
        ],
      ),
    );
  }
}
