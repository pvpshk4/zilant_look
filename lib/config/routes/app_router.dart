import 'package:go_router/go_router.dart';
import 'package:zilant_look/common/photo_upload/presentation/pages/photo_upload_page.dart';
import 'package:zilant_look/features/home/presentation/pages/home_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => HomePage()),
    GoRoute(
      path: '/photo_upload',
      builder: (context, state) => PhotoUploadPage(),
    ),
  ],
);
