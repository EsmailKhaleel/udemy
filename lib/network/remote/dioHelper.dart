// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

//init dioHelper________________________________________________________________
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
    print('Dio inits successfully');
  }

//getData Method________________________________________________________________
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    print(token);
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

//postData Method________________________________________________________________
  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
  
//putData Method________________________________________________________________
  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token,
      'Content-Type': 'application/json',
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
