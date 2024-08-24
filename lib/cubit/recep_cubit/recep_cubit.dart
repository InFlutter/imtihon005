import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imtihon005/cubit/recep_cubit/recep_state.dart';
import 'package:imtihon005/data/model/forms_status.dart';
import 'package:imtihon005/data/model/recep_model/recep_model.dart';

class RecepCubit extends Cubit<RecepState> {
  RecepCubit() : super(RecepState.initial());

  // Create
  Future<void> insertRecep({required RecepModel recepModel}) async {
    try {
      final dio = Dio();

      final pushResponse = await dio.post(
        "https://imitxon5-default-rtdb.asia-southeast1.firebasedatabase.app/recep.json",
        data: recepModel.toJson(),
      );

      if (pushResponse.statusCode == 200) {
        final uid = pushResponse.data['name']; // UID'ni olish

        recepModel = recepModel.copyWith(uid: uid);

        final response = await dio.put(
          "https://imitxon5-default-rtdb.asia-southeast1.firebasedatabase.app/recep/$uid.json",
          data: recepModel.toUpdateJson(),
        );

        if (response.statusCode == 200) {
          fetchAllReceps();
        } else {
          emit(
            state.copyWith(
              status: FormsStatus.error,
              errorMessage: 'Failed to update recep data.',
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            status: FormsStatus.error,
            errorMessage: 'Failed to create recep UID.',
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

  // Read (Fetch all)
  Future<void> fetchAllReceps() async {
    try {
      final dio = Dio();

      final response = await dio.get(
        "https://imitxon5-default-rtdb.asia-southeast1.firebasedatabase.app/recep.json",
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final receps = data.entries.map((entry) {
          final recepData = entry.value as Map<String, dynamic>;
          return RecepModel.fromJson(recepData).copyWith(uid: entry.key);
        }).toList();

        emit(
          state.copyWith(
            status: FormsStatus.success,
            listRecep: receps,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: FormsStatus.error,
            errorMessage: 'Failed to fetch data.',
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

  // Update
  Future<void> updateRecep({required RecepModel recepModel}) async {
    try {
      final dio = Dio();

      final response = await dio.put(
        "https://imitxon5-default-rtdb.asia-southeast1.firebasedatabase.app/recep/${recepModel.uid}.json",
        data: recepModel.toUpdateJson(),
      );

      if (response.statusCode == 200) {
        fetchAllReceps();
      } else {
        emit(
          state.copyWith(
            status: FormsStatus.error,
            errorMessage: 'Failed to update data.',
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

  // Delete
  Future<void> deleteRecep({required String uid}) async {
    try {
      final dio = Dio();

      final response = await dio.delete(
        "https://imitxon5-default-rtdb.asia-southeast1.firebasedatabase.app/recep/$uid.json",
      );

      if (response.statusCode == 200) {
        fetchAllReceps();
      } else {
        emit(
          state.copyWith(
            status: FormsStatus.error,
            errorMessage: 'Failed to delete data.',
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
