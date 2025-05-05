import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zilant_look/common/AppData/data/models/deleted_photo_model.dart';
import 'package:zilant_look/common/AppData/data/models/photo_model_adapter.dart';
import 'package:zilant_look/common/photo_upload/data/data_sources/remote/photo_remote_data_source.dart';
import 'package:zilant_look/common/photo_upload/presentation/bloc/photo_upload_bloc.dart';
import 'package:zilant_look/features/home/data/repositories/home_repository_impl.dart';
import 'package:zilant_look/features/home/domain/repositories/home_repository.dart';
import 'package:zilant_look/features/home/presentation/bloc/home_bloc.dart';
import 'package:zilant_look/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:zilant_look/features/wardrobe/data/data_sources/remote/wardrobe_remote_data_source.dart';
import 'package:zilant_look/features/wardrobe/data/repositories/wardrobe_repository_impl.dart';
import 'package:zilant_look/features/wardrobe/domain/repositories/wardrobe_repository.dart';
import 'package:zilant_look/features/wardrobe/presentation/bloc/wardrobe_bloc.dart';
import 'package:zilant_look/common/AppData/data/data_sources/remote/app_data_api_service.dart';
import 'package:zilant_look/common/AppData/data/data_sources/remote/mock_app_data_api_service.dart';
import 'package:zilant_look/common/AppData/domain/repositories/app_data_repository.dart';
import 'package:zilant_look/common/AppData/presentation/bloc/app_data_bloc.dart';
import 'package:zilant_look/common/AppData/data/models/photo_model.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //============================================================================
  // External Dependencies
  //============================================================================
  sl.registerSingleton<http.Client>(http.Client());
  sl.registerSingleton<Dio>(Dio());

  await Hive.initFlutter();
  Hive.registerAdapter(PhotoModelAdapter());
  Hive.registerAdapter(DeletedPhotoModelAdapter());
  final humanPhotoBox = await Hive.openBox<String>('humanPhotos');
  final catalogItemsBox = await Hive.openBox<PhotoModel>('catalogItems');
  final wardrobeItemsBox = await Hive.openBox<PhotoModel>('wardrobeItems');
  final deletedPhotosBox = await Hive.openBox<DeletedPhotoModel>(
    'deletedPhotos',
  );
  sl.registerSingleton<Box<String>>(humanPhotoBox);
  sl.registerSingleton<Box<PhotoModel>>(
    catalogItemsBox,
    instanceName: 'catalogItemsBox',
  );
  sl.registerSingleton<Box<PhotoModel>>(
    wardrobeItemsBox,
    instanceName: 'wardrobeItemsBox',
  );
  sl.registerSingleton<Box<DeletedPhotoModel>>(
    deletedPhotosBox,
    instanceName: 'deletedPhotosBox',
  );

  final prefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(prefs);

  //============================================================================
  // API Services
  //============================================================================
  sl.registerSingleton<AppDataApiService>(
    MockAppDataApiService(
      sl<Box<String>>(),
      sl<Box<PhotoModel>>(instanceName: 'catalogItemsBox'),
      sl<Box<PhotoModel>>(instanceName: 'wardrobeItemsBox'),
      sl<Box<DeletedPhotoModel>>(instanceName: 'deletedPhotosBox'),
    ),
  );

  //============================================================================
  // RemoteDataSources
  //============================================================================
  sl.registerSingleton<PhotoRemoteDataSource>(
    PhotoRemoteDataSourceImpl(apiService: sl<AppDataApiService>()),
  );
  sl.registerSingleton<WardrobeRemoteDataSource>(
    WardrobeRemoteDataSourceImpl(sl<AppDataApiService>()),
  );

  //============================================================================
  // Repositories
  //============================================================================
  sl.registerSingleton<AppDataRepository>(
    AppDataRepository(sl<AppDataApiService>()),
  );
  sl.registerSingleton<WardrobeRepository>(
    WardrobeRepositoryImpl(remoteDataSource: sl<WardrobeRemoteDataSource>()),
  );
  sl.registerSingleton<HomeRepository>(HomeRepositoryImpl());

  //============================================================================
  // Bloc
  //============================================================================
  sl.registerSingleton<AppDataBloc>(
    AppDataBloc(sl<AppDataRepository>(), sl<SharedPreferences>()),
  );
  sl.registerSingleton<PhotoUploadBloc>(PhotoUploadBloc(sl<AppDataBloc>()));
  sl.registerSingleton<WardrobeBloc>(
    WardrobeBloc(remoteDataSource: sl<WardrobeRemoteDataSource>()),
  );
  sl.registerSingleton<HomeBloc>(HomeBloc(sl<AppDataBloc>()));
  sl.registerSingleton<ProfileBloc>(ProfileBloc(sl()));
}
