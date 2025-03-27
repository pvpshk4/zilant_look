// app_router.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zilant_look/common/presentation/layouts/main_layout.dart';
import 'package:zilant_look/common/photo_upload/presentation/pages/photo_upload_page.dart';
import 'package:zilant_look/features/home/presentation/pages/home_page.dart';
import 'package:zilant_look/features/catalog/presentation/pages/catalog_page.dart';
import 'package:zilant_look/features/wardrobe/presentation/pages/wardrobe_page.dart';
import 'package:zilant_look/features/wardrobe/presentation/pages/subcategories_page.dart';
import 'package:zilant_look/features/wardrobe/presentation/pages/products_page.dart';
import 'package:zilant_look/features/wardrobe/presentation/bloc/wardrobe_bloc.dart';
import 'package:zilant_look/injection_container.dart';

// app_router.dart
final GoRouter appRouter = GoRouter(
  routes: [
    ShellRoute(
      builder:
          (context, state, child) => MainLayout(
            currentIndex: _getCurrentIndex(state.uri.toString()),
            routes: ['/', '/catalog', '/wardrobe', '/profile'],
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
          builder:
              (context, state) => BlocProvider(
                create: (context) => sl<WardrobeBloc>(),
                child: const WardrobePage(),
              ),
        ),
        GoRoute(
          path: '/wardrobe/subcategories/:category',
          builder: (context, state) {
            final category = state.pathParameters['category']!;
            return SubcategoriesPage(category: category);
          },
        ),
        GoRoute(
          path: '/wardrobe/products/:category/:subcategory',
          builder: (context, state) {
            final category = state.pathParameters['category']!;
            final subcategory = state.pathParameters['subcategory']!;
            return BlocProvider(
              create: (_) => sl<WardrobeBloc>(),
              child: ProductsPage(category: category, subcategory: subcategory),
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/photo_upload',
      builder: (context, state) => const PhotoUploadPage(),
    ),
  ],
);

int _getCurrentIndex(String location) {
  if (location.startsWith('/catalog')) return 1;
  if (location.startsWith('/wardrobe')) return 2;
  if (location.startsWith('/profile')) return 3;
  return 0; // Default to Home
}
