import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zilant_look/common/photo_upload/presentation/pages/photo_upload_page.dart';
import 'package:zilant_look/features/catalog/presentation/pages/catalog_page.dart';
import 'package:zilant_look/features/home/presentation/pages/home_page.dart';
import 'package:zilant_look/features/wardrobe/presentation/pages/wardrobe_page.dart';
import 'package:zilant_look/common/presentation/layouts/main_layout.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder:
          (context, state, child) => MainLayout(
            currentIndex: _getCurrentIndex(state.uri.toString()),
            routes: const ['/', '/catalog', '/wardrobe', '/profile'],
            child: child,
          ),
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(
          path: '/catalog',
          builder: (context, state) => const CatalogPage(),
        ),
        GoRoute(
          path: '/wardrobe',
          builder: (context, state) => const WardrobePage(),
        ),
      ],
    ),

    // Маршруты загрузки фото (вне ShellRoute)
    GoRoute(
      path: '/upload-human-photo',
      pageBuilder:
          (context, state) => MaterialPage(
            child: PhotoUploadPage(uploadType: UploadType.human),
          ),
    ),
    GoRoute(
      path: '/upload-clothes-photo',
      pageBuilder:
          (context, state) => MaterialPage(
            child: PhotoUploadPage(uploadType: UploadType.clothes),
          ),
    ),
  ],
);

int _getCurrentIndex(String location) {
  if (location.startsWith('/catalog')) return 1;
  if (location.startsWith('/wardrobe')) return 2;
  if (location.startsWith('/profile')) return 3;
  return 0;
}
