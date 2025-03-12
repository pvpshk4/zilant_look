import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:zilant_look/features/home/data/repositories/home_repository_impl.dart';
import 'package:zilant_look/features/home/domain/usecases/get_home_content.dart';
import 'package:zilant_look/features/home/presentation/bloc/home_bloc.dart';
import 'package:zilant_look/features/inventory/data/repositories/inventory_repository_impl.dart';
import 'package:zilant_look/features/inventory/domain/usecases/add_clothing_item.dart';
import 'package:zilant_look/features/inventory/domain/usecases/delete_clothing_item.dart';
import 'package:zilant_look/features/inventory/domain/usecases/filter_inventory_by_category.dart';
import 'package:zilant_look/features/inventory/domain/usecases/get_inventory_items.dart';
import 'package:zilant_look/features/inventory/domain/usecases/update_clothing_item.dart';
import 'package:zilant_look/features/inventory/presentation/bloc/inventory_bloc.dart';

import 'features/home/domain/repositories/home_repository.dart';
import 'features/inventory/domain/repositories/inventory_repository.dart';
import 'common/photo_upload/data/data_sources/remote/photo_remote_data_source.dart';
import 'common/photo_upload/data/repositories/photo_repository_impl.dart';
import 'common/photo_upload/domain/repositories/photo_repository.dart';
import 'common/photo_upload/domain/usecases/photo_upload.dart';
import 'common/photo_upload/presentation/bloc/photo_upload_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton(() => http.Client());

  //============================================================================
  //RemoteDataSource
  //============================================================================
  sl.registerLazySingleton<PhotoRemoteDataSource>(
    () => PhotoRemoteDataSourceImpl(client: sl()),
  );

  //============================================================================
  //Repositories
  //============================================================================
  sl.registerSingleton<PhotoRepository>(
    PhotoRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerSingleton<InventoryRepository>(
    InventoryRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerSingleton<HomeRepository>(HomeRepositoryImpl());

  //============================================================================
  //UseCases
  //============================================================================
  sl.registerSingleton(() => UploadPhotoUseCase(repository: sl()));
  sl.registerSingleton(() => AddClothingItemUseCase(repository: sl()));
  sl.registerSingleton(() => DeleteClothingItemUseCase(repository: sl()));
  sl.registerSingleton(
    () => FilterInventoryByCategoryUseCase(repository: sl()),
  );
  sl.registerSingleton(() => GetInventoryItemsUseCase(repository: sl()));
  sl.registerSingleton(() => UpdateClothingItemUseCase(repository: sl()));
  sl.registerSingleton(() => GetHomeContent(repository: sl()));

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
