import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:zilant_look/features/home/data/repositories/home_repository_impl.dart';
import 'package:zilant_look/features/home/domain/usecases/get_home_content.dart';
import 'package:zilant_look/features/home/presentation/bloc/home_bloc.dart';
import 'package:zilant_look/features/wardrobe/data/data_sources/remote/wardrobe_remote_data_source.dart';
import 'package:zilant_look/features/wardrobe/data/repositories/wardrobe_repository_impl.dart';
import 'package:zilant_look/features/wardrobe/domain/usecases/add_clothing_item.dart';
import 'package:zilant_look/features/wardrobe/domain/usecases/delete_clothing_item.dart';
import 'package:zilant_look/features/wardrobe/domain/usecases/filter_wardrobe_by_category.dart';
import 'package:zilant_look/features/wardrobe/domain/usecases/get_wardrobe_items.dart';
import 'package:zilant_look/features/wardrobe/domain/usecases/update_clothing_item.dart';
import 'package:zilant_look/features/wardrobe/presentation/bloc/wardrobe_bloc.dart';
import 'common/photo_upload/data/data_sources/remote/photo_remote_data_source.dart';
import 'common/photo_upload/data/repositories/photo_repository_impl.dart';
import 'common/photo_upload/domain/usecases/photo_upload_usecase.dart';
import 'common/photo_upload/presentation/bloc/photo_upload_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies(
  GlobalKey<NavigatorState> rootNavigatorKey,
) async {
  //============================================================================
  // External Dependencies
  //============================================================================
  sl.registerSingleton<http.Client>(http.Client());
  sl.registerSingleton<Dio>(Dio());

  //============================================================================
  // RemoteDataSource
  //============================================================================
  sl.registerSingleton<PhotoRemoteDataSourceImpl>(
    PhotoRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerSingleton<WardrobeRemoteDataSourceImpl>(
    WardrobeRemoteDataSourceImpl(sl()),
  );

  //============================================================================
  // Repositories
  //============================================================================
  sl.registerSingleton<PhotoRepositoryImpl>(PhotoRepositoryImpl(sl()));
  sl.registerSingleton<WardrobeRepositoryImpl>(WardrobeRepositoryImpl(sl()));
  sl.registerSingleton<HomeRepositoryImpl>(HomeRepositoryImpl());

  //============================================================================
  // UseCases
  //============================================================================
  sl.registerSingleton(UploadPhotoUseCase(sl()));
  sl.registerSingleton(AddClothingItemUseCase(sl()));
  sl.registerSingleton(DeleteClothingItemUseCase(sl()));
  sl.registerSingleton(FilterWardrobeByCategoryUseCase(sl()));
  sl.registerSingleton(GetWardrobeItemsUseCase(sl()));
  sl.registerSingleton(UpdateClothingItemUseCase(sl()));
  sl.registerSingleton(GetHomeContentUseCase(sl()));

  //============================================================================
  // Bloc
  //============================================================================
  sl.registerFactory(() => PhotoUploadBloc(uploadPhoto: sl()));
  sl.registerFactory(
    () => WardrobeBloc(
      getWardrobeItems: sl(),
      filterWardrobeByCategory: sl(),
      addClothingItem: sl(),
      deleteClothingItem: sl(),
      updateClothingItem: sl(),
    ),
  );
  sl.registerFactory(() => HomeBloc(getHomeContent: sl()));
}
