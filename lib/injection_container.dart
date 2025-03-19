import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:zilant_look/features/home/data/repositories/home_repository_impl.dart';
import 'package:zilant_look/features/home/domain/usecases/get_home_content.dart';
import 'package:zilant_look/features/home/presentation/bloc/home_bloc.dart';
import 'package:zilant_look/features/inventory/data/data_sources/remote/inventory_remote_data_source.dart';
import 'package:zilant_look/features/inventory/data/repositories/inventory_repository_impl.dart';
import 'package:zilant_look/features/inventory/domain/usecases/add_clothing_item.dart';
import 'package:zilant_look/features/inventory/domain/usecases/delete_clothing_item.dart';
import 'package:zilant_look/features/inventory/domain/usecases/filter_inventory_by_category.dart';
import 'package:zilant_look/features/inventory/domain/usecases/get_inventory_items.dart';
import 'package:zilant_look/features/inventory/domain/usecases/update_clothing_item.dart';
import 'package:zilant_look/features/inventory/presentation/bloc/inventory_bloc.dart';

import 'common/photo_upload/data/data_sources/remote/photo_remote_data_source.dart';
import 'common/photo_upload/data/repositories/photo_repository_impl.dart';
import 'common/photo_upload/domain/usecases/photo_upload.dart';
import 'common/photo_upload/presentation/bloc/photo_upload_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies(
  GlobalKey<NavigatorState> rootNavigatorKey,
) async {
  sl.registerSingleton<http.Client>(http.Client());
  //============================================================================
  //DIO
  //============================================================================
  sl.registerSingleton<Dio>(Dio());
  //============================================================================
  //RemoteDataSource
  //============================================================================
  sl.registerSingleton<PhotoRemoteDataSourceImpl>(
    PhotoRemoteDataSourceImpl(dio: sl<Dio>()),
  );
  sl.registerSingleton<InventoryRemoteDataSourceImpl>(
    InventoryRemoteDataSourceImpl(sl()),
  );

  //============================================================================
  //Repositories
  //============================================================================
  sl.registerSingleton<PhotoRepositoryImpl>(PhotoRepositoryImpl(sl()));
  sl.registerSingleton<InventoryRepositoryImpl>(InventoryRepositoryImpl(sl()));
  sl.registerSingleton<HomeRepositoryImpl>(HomeRepositoryImpl());

  //============================================================================
  //UseCases
  //============================================================================
  sl.registerSingleton(UploadPhotoUseCase(sl()));
  sl.registerSingleton(AddClothingItemUseCase(sl()));
  sl.registerSingleton(DeleteClothingItemUseCase(sl()));
  sl.registerSingleton(FilterInventoryByCategoryUseCase(sl()));
  sl.registerSingleton(GetInventoryItemsUseCase(sl()));
  sl.registerSingleton(UpdateClothingItemUseCase(sl()));
  sl.registerSingleton(GetHomeContentUseCase(sl()));

  //============================================================================
  //Bloc
  //============================================================================
  sl.registerFactory(() => PhotoUploadBloc(uploadPhoto: sl()));
  sl.registerFactory(
    () => InventoryBloc(
      getInventoryItems: sl(),
      filterInventoryByCategory: sl(),
      addClothingItem: sl(),
      deleteClothingItem: sl(),
      updateClothingItem: sl(),
    ),
  );
  sl.registerFactory(() => HomeBloc(getHomeContent: sl()));
}
