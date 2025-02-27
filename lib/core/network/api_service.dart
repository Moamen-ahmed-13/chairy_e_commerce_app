import 'dart:convert';

import 'package:dio/dio.dart';

import '../../constants.dart';
import '../../features/product/domain/entities/product.dart';

class ApiService {
  late Dio dio;

  ApiService() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    );
    dio = Dio(options);
  }
  Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    final response = await dio.get('', queryParameters: {'q': query});
    return List<Map<String, dynamic>>.from(response.data['data']);
  }

  Future<Response<dynamic>> getProducts() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        baseUrl,
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        print(json.encode(response.data));
      } else {
        print(response.statusMessage);
      }
      return response;
    } catch (e) {
      print(e);
      return Response(
        requestOptions: RequestOptions(path: baseUrl),
        statusCode: 500, // Internal Server Error
        statusMessage: "Error: $e",
      );
    }
  }
}
