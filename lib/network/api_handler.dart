import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();
  String baseUrl = "https://jsonplaceholder.typicode.com";
  ApiService() {
    _dio.options.headers["Content-Type"] = "application/json";
  }

  Future<Response> getTodos(String url) async {
    try {
      return await _dio.get("$baseUrl$url");
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Response> postTodo(String url, dynamic data) async {
    try {
      return await _dio.post("$baseUrl$url", data: data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Response> deleteTodo(String url) async {
    try {
      return await _dio.delete("$baseUrl$url");
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
