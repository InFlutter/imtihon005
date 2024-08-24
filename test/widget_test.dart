// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter_test/flutter_test.dart';
import 'package:imtihon005/cubit/recep_cubit/recep_cubit.dart';
import 'package:imtihon005/data/model/forms_status.dart';
import 'package:imtihon005/data/model/recep_model/recep_model.dart';

void main() {
  group("Funksiyalarni testlash", () {
    // Insert function testi
    test("Recep Insert check test", () async {
      final recepCubit = RecepCubit();
      RecepModel recepModel = RecepModel.initialValue();

      // Dastlabki holat pure bo'lishini tekshiramiz
      expect(recepCubit.state.status, FormsStatus.pure);

      // Funksiyani chaqiramiz va natijani kutamiz
      await recepCubit.insertRecep(recepModel: recepModel);

      // Success holatini kutamiz
      expect(recepCubit.state.status, FormsStatus.success);
    });

    // Fetch function testi
    test("Recep Fetch check test", () async {
      final recepCubit = RecepCubit();

      // Dastlabki holatni tekshiramiz
      expect(recepCubit.state.status, FormsStatus.pure);

      // Funksiyani chaqiramiz va natijani kutamiz
      await recepCubit.fetchAllReceps();

      // Success holatini kutamiz
      expect(recepCubit.state.status, FormsStatus.success);
    });

    // Update function testi
    test("Recep Update check test", () async {
      final recepCubit = RecepCubit();
      RecepModel recepModel = RecepModel.initialValue();

      // Dastlabki holatni tekshiramiz
      expect(recepCubit.state.status, FormsStatus.pure);

      // Funksiyani chaqiramiz va natijani kutamiz
      await recepCubit.updateRecep(recepModel: recepModel);

      // Success holatini kutamiz
      expect(recepCubit.state.status, FormsStatus.success);
    });

    // Delete function testi
    test("Recep Delete check test", () async {
      final recepCubit = RecepCubit();
      const String uid = "some_uid"; // Test uchun qilingan ID

      // Dastlabki holatni tekshiramiz
      expect(recepCubit.state.status, FormsStatus.pure);

      // Funksiyani chaqiramiz va natijani kutamiz
      await recepCubit.deleteRecep(uid: uid);

      // Success holatini kutamiz
      expect(recepCubit.state.status, FormsStatus.success);
    });
  });
}