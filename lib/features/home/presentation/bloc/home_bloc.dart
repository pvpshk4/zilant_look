// features/home/presentation/bloc/home_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zilant_look/features/home/domain/usecases/get_home_content.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeContent getHomeContent;

  HomeBloc({required this.getHomeContent}) : super(HomeInitialState()) {
    on<LoadHomeContentEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        final content = await getHomeContent();
        emit(HomeLoadedState(content));
      } catch (e) {
        emit(HomeErrorState('Failed to load content: $e'));
      }
    });
  }
}
