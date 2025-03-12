import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zilant_look/core/resources/data_state.dart';
import 'package:zilant_look/features/auth/presentation/bloc/auth_event.dart';
import 'package:zilant_look/features/auth/presentation/bloc/auth_state.dart';

import '../../domain/usecases/check_license.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CheckLicenseUseCase _checkLicenseUseCase;

  AuthBloc(this._checkLicenseUseCase) : super(const StartLicenseState()) {
    on<CheckLicense>(checkLicense);
  }

  Future<void> checkLicense(CheckLicense event, Emitter<AuthState> emit) async {
    final dataState = await _checkLicenseUseCase(params: event.key);
    if (dataState is DataSuccess) {
      emit(const ValidLicense());
    }
    if (dataState is DataFailed) {
      emit(NotValidLicense(dataState.errorMessage!));
    }

    if (dataState is DataFailed) {
      emit(NotValidLicense(dataState.error!.error!.toString()));
    }
  }
}
