import 'package:go_router/go_router.dart';
import 'package:zilant_look/common/photo_upload/presentation/pages/camera_page.dart';
import 'package:zilant_look/common/photo_upload/presentation/pages/clothes_category_selection_page.dart';
import 'package:zilant_look/common/photo_upload/presentation/pages/human_photo_preview_page.dart';
import 'package:zilant_look/common/presentation/layouts/main_layout.dart';
import 'package:zilant_look/features/catalog/presentation/pages/catalog_page.dart';
import 'package:zilant_look/features/home/presentation/pages/home_page.dart';
import 'package:zilant_look/features/profile/presentation/pages/profile_page.dart';
import 'package:zilant_look/features/wardrobe/presentation/pages/wardrobe_page.dart';
import 'package:zilant_look/features/wardrobe/presentation/pages/subcategories_page.dart';
import 'package:zilant_look/features/wardrobe/presentation/pages/products_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        final isUploadPage = state.uri.path.contains('upload-');
        final showBottomNavBar =
            state.uri.path == '/upload-clothes-photo/category-selection' ||
            !state.uri.path.startsWith('/upload-');
        return MainLayout(
          navigationShell: navigationShell,
          showFloatingButton: !isUploadPage,
          showBottomNavBar: showBottomNavBar,
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [GoRoute(path: '/', builder: (_, __) => const HomePage())],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/catalog', builder: (_, __) => const CatalogPage()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/wardrobe',
              builder: (_, __) => const WardrobePage(),
              routes: [
                GoRoute(
                  path: 'subcategories/:category',
                  builder: (context, state) {
                    final category = state.pathParameters['category']!;
                    return SubcategoriesPage(category: category);
                  },
                ),
                GoRoute(
                  path: 'products/:category/:subcategory',
                  builder: (context, state) {
                    final category = state.pathParameters['category']!;
                    final subcategory = state.pathParameters['subcategory']!;
                    return ProductsPage(
                      category: category,
                      subcategory: subcategory,
                      extra: state.extra as Map<String, dynamic>?,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/profile', builder: (_, __) => ProfilePage()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/upload-human-photo',
              builder: (_, __) => CameraPage(isClothesUpload: false),
              routes: [
                GoRoute(
                  path: 'preview',
                  builder:
                      (_, state) => HumanPhotoPreviewPage(
                        imagePath: state.extra as String,
                      ),
                ),
              ],
            ),
            GoRoute(
              path: '/upload-clothes-photo',
              builder: (_, __) => CameraPage(isClothesUpload: true),
              routes: [
                GoRoute(
                  path: 'category-selection',
                  builder:
                      (_, state) => ClothesCategorySelectionPage(
                        imagePath: state.extra as String,
                      ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
