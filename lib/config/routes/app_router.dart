import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zilant_look/common/presentation/layouts/main_layout.dart';
import 'package:zilant_look/common/photo_upload/presentation/pages/photo_upload_page.dart';

import '../../features/catalog/presentation/pages/catalog_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/wardrobe/presentation/pages/wardrobe_page.dart';
// ... другие импорты

final GoRouter appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        final currentIndex = _getCurrentIndex(state.uri.toString());

        final isUploadPage = state.uri.path.contains('upload-');

        return MainLayout(
          currentIndex: currentIndex,
          routes: const ['/', '/catalog', '/wardrobe', '/profile'],
          showFloatingButton: !isUploadPage,
          child: child,
        );
      },
      routes: [
        // Основные маршруты
        GoRoute(path: '/', builder: (_, __) => const HomePage()),
        GoRoute(path: '/catalog', builder: (_, __) => const CatalogPage()),
        GoRoute(path: '/wardrobe', builder: (_, __) => const WardrobePage()),

        // Маршруты загрузки (остаются внутри ShellRoute)
        GoRoute(
          path: '/upload-human-photo',
          pageBuilder:
              (_, __) => MaterialPage(
                child: PhotoUploadPage(uploadType: UploadType.human),
              ),
        ),
        GoRoute(
          path: '/upload-clothes-photo',
          pageBuilder:
              (_, __) => MaterialPage(
                child: PhotoUploadPage(uploadType: UploadType.clothes),
              ),
        ),
      ],
    ),
  ],
);

int _getCurrentIndex(String path) {
  if (path.startsWith('/catalog')) return 1;
  if (path.startsWith('/wardrobe')) return 2;
  if (path.startsWith('/profile')) return 3;
  return 0; // Главная по умолчанию
}
