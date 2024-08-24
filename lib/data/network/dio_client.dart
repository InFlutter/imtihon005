import 'package:dio/dio.dart';

class DioClient{
  final Dio dio = Dio();
  DioClient._singleton(){
    dio.options.baseUrl = "https://imitxon5-default-rtdb.asia-southeast1.firebasedatabase.app/";
  }

  static final DioClient _instance = DioClient._singleton();
  factory DioClient() => _instance;

}