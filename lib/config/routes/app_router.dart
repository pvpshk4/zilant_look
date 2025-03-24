import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zilant_look/common/presentation/layouts/main_layout.dart';
import 'package:zilant_look/common/photo_upload/presentation/pages/photo_upload_page.dart';
import 'package:zilant_look/features/home/presentation/pages/home_page.dart';
import 'package:zilant_look/features/catalog/presentation/pages/catalog_page.dart';
import 'package:zilant_look/features/wardrobe/presentation/pages/wardrobe_page.dart';
import 'package:zilant_look/features/wardrobe/presentation/bloc/wardrobe_bloc.dart';
import 'package:zilant_look/injection_container.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder:
          (context, state) =>
              const MainLayout(currentIndex: 0, child: HomePage()),
    ),
    GoRoute(
      path: '/catalog',
      builder:
          (context, state) =>
              const MainLayout(currentIndex: 1, child: CatalogPage()),
    ),
    GoRoute(
      path: '/wardrobe',
      builder:
          (context, state) => MainLayout(
            currentIndex: 2,
            child: BlocProvider(
              create: (context) => sl<WardrobeBloc>(),
              child: const WardrobePage(),
            ),
          ),
    ),

    // GoRoute(
    //   path: '/profile',
    //   builder: (context, state) => const MainLayout(
    //     currentIndex: 3,
    //     child: ProfilePage(),
    //   ),
    // ),
    GoRoute(
      path: '/photo_upload',
      builder: (context, state) => const PhotoUploadPage(),
    ),
  ],
);
