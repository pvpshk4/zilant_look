import 'package:flutter/material.dart';
import 'package:zilant_look/injection_container.dart';

import 'config/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: ThemeData(fontFamily: 'SFPro-Medium'),
      debugShowCheckedModeBanner: false,
    );
  }
}
