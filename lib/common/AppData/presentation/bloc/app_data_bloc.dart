import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zilant_look/common/AppData/domain/repositories/app_data_repository.dart';
import 'package:zilant_look/common/AppData/presentation/bloc/app_data_event.dart';
import 'package:zilant_look/common/AppData/presentation/bloc/app_data_state.dart';

class AppDataBloc extends Bloc<AppDataEvent, AppDataState> {
  final AppDataRepository _repository;

  AppDataBloc(this._repository) : super(const AppDataState()) {
    on<LoadAppDataEvent>(_onLoadAppData);
    on<AddHumanPhotoEvent>(_onAddHumanPhoto);
    on<AddClothingItemEvent>(_onAddClothingItem);

    add(LoadAppDataEvent());
  }

  Future<void> _onLoadAppData(
    LoadAppDataEvent event,
    Emitter<AppDataState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final humanPhotos = await _repository.getHumanPhotos();
      final clothingItems = await _repository.getClothingItems();
      emit(
        state.copyWith(
          humanPhotos: humanPhotos,
          clothingItems: clothingItems,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          error: 'Не удалось загрузить данные: $e',
        ),
      );
    }
  }

  Future<void> _onAddHumanPhoto(
    AddHumanPhotoEvent event,
    Emitter<AppDataState> emit,
  ) async {
    await _repository.addHumanPhoto(event.photoBase64, event.userName);
    final updatedPhotos = await _repository.getHumanPhotos();
    emit(state.copyWith(humanPhotos: updatedPhotos));
  }

  Future<void> _onAddClothingItem(
    AddClothingItemEvent event,
    Emitter<AppDataState> emit,
  ) async {
    await _repository.addClothingItem(
      event.fileBase64,
      event.userName,
      event.category,
      event.subcategory,
      event.subSubcategory,
    );
    final updatedItems = await _repository.getClothingItems();
    emit(state.copyWith(clothingItems: updatedItems));
  }
}
