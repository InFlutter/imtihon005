import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon005/cubit/user_cubit/user_state.dart';
import 'package:imtihon005/data/model/forms_status.dart';
import 'package:imtihon005/data/model/user_model/user_model.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState.initial());

  Future<void> insertUser({required UserModel userModel}) async {
    try {
      final dio = Dio();
      debugPrint("insert user ga kirdi___________________________________- ");

      final pushResponse = await dio.post(
        "https://imitxon5-default-rtdb.asia-southeast1.firebasedatabase.app/user.json",
        data: userModel.toJson(),
      );

      debugPrint("insert user ga kirdi qo'shdi ___________________________________- ");

      if (pushResponse.statusCode == 200) {
        final uid = pushResponse.data['name'];
        debugPrint("insert user ga qo'shild va succes keldi___________________________________- ");

        userModel = userModel.copyWith(uid: uid);
        debugPrint("insert user updatega kirdi___________________________________- ");

        final response = await dio.put(
          "https://imitxon5-default-rtdb.asia-southeast1.firebasedatabase.app/user/$uid.json",
          data: userModel.toUpdateJson(),
        );
        debugPrint("insert user ga kirdi update___________________________________- ");

        if (response.statusCode == 200) {
          debugPrint("insert user ga kirdi update succes___________________________________- ");
          emit(
            state.copyWith(
              status: FormsStatus.success,
              userModel: userModel,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: FormsStatus.error,
              errorMessage: 'Failed to update user data.',
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            status: FormsStatus.error,
            errorMessage: 'Failed to create user UID.',
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> updateUser({required UserModel userModel}) async {
    try {
      final dio = Dio();

      final response = await dio.put(
        "https://imitxon5-default-rtdb.asia-southeast1.firebasedatabase.app/user/${userModel.uid}.json",
        data: userModel.toUpdateJson(),
      );

      if (response.statusCode == 200) {
        emit(
          state.copyWith(
            status: FormsStatus.success,
            userModel: userModel,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: FormsStatus.error,
            errorMessage: 'Failed to update user data.',
          ),
        );
      }
    } catch (error) {
      emit(
        state.copyWith(
          status: FormsStatus.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
