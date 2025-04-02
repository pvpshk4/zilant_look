import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Главная')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Переход на экран загрузки своего фото (uploadHumanPhoto)
                context.push('/upload-human-photo');
              },
              child: const Text('Загрузить свое фото'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Переход на экран добавления одежды (uploadClothesPhoto)
                context.push('/upload-clothes-photo');
              },
              child: const Text('Добавить одежду'),
            ),
          ],
        ),
      ),
    );
  }
}
