import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon005/data/model/forms_status.dart';
import 'package:imtihon005/data/network/network_response.dart';
import 'package:imtihon005/data/repository/auth_repository/auth_repository.dart';
import 'package:imtihon005/services/services_locator.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse response =
        await getIt<AuthRepository>().registerWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
    );
    if (response.errorMessage.isEmpty) {
      emit(
        state.copyWith(
          status: FormsStatus.success,
          uid: response.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          errorMessage: response.errorMessage.toString(),
        ),
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse response =
    await getIt<AuthRepository>().signInWithEmailAndPassword(email: email, password: password);
    if (response.errorMessage.isEmpty) {
      emit(
        state.copyWith(
          status: FormsStatus.success,
          uid: response.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          errorMessage: response.errorMessage.toString(),
        ),
      );
    }
  }

  Future<void> googleSing() async {
    emit(state.copyWith(status: FormsStatus.loading));
    NetworkResponse response =
    await getIt<AuthRepository>().signInWithGoogle();
    if (response.errorMessage.isEmpty) {
      emit(
        state.copyWith(
          status: FormsStatus.success,
          uid: response.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          errorMessage: response.errorMessage.toString(),
        ),
      );
    }
  }

  void initialState()=>emit(AuthState.initial());

}
