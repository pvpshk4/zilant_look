import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная')),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          GoRouter.of(context).go('/photo_upload');
        },
        child: const Text('Upload Photo'),
      ),
    );
  }
}
