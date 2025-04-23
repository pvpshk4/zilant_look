import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zilant_look/common/photo_upload/presentation/bloc/photo_upload_bloc.dart';
import 'package:zilant_look/common/AppData/presentation/bloc/app_data_bloc.dart';
import 'package:zilant_look/features/wardrobe/presentation/bloc/wardrobe_bloc.dart';
import 'package:zilant_look/injection_container.dart' as di;
import 'config/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppDataBloc>(create: (context) => di.sl<AppDataBloc>()),
        BlocProvider<PhotoUploadBloc>(
          create: (context) => di.sl<PhotoUploadBloc>(),
        ),
        BlocProvider<WardrobeBloc>(create: (context) => di.sl<WardrobeBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Zilant Look',
        routerConfig: appRouter,
        theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
      ),
    );
  }
}
