import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:matrimonial_app/model/UserProfile.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late Dio dio;

  ApiService._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://192.168.1.27:8080/api/', // TODO: replace with your API base URL
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      requestBody: true,
    ));
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      final response = await dio.get(endpoint, queryParameters: params);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String endpoint, dynamic data) async {
    try {
      final response = await dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String endpoint, dynamic data) async {
    try {
      final response = await dio.put(endpoint, data: data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String endpoint) async {
    try {
      final response = await dio.delete(endpoint);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  void printFullResponse(Map<String, dynamic> data) {
    const int chunkSize = 1000;
    final jsonStr = jsonEncode(data);
    for (var i = 0; i < jsonStr.length; i += chunkSize) {
      final end = (i + chunkSize < jsonStr.length) ? i + chunkSize : jsonStr.length;
      print(jsonStr.substring(i, end));
    }
  }

  Future<Response> login(String username, String password) {
    return dio.post('/login', data: {
      'username': username,
      'password': password,
    });
  }

  Future<(UserProfile, List<MatchProfile>)> getHomeData(int userId) async {
    final r = await dio.get('/profile/$userId');
    printFullResponse(r.data);
    if (r.statusCode == 200 && r.data['status'] == 'success') {
      final data = r.data['data'];
      final user = UserProfile.fromJson(data['userProfile']);
      final matches = (data['matchingProfiles'] as List)
          .map((e) => MatchProfile.fromJson(e))
          .toList();
      return (user, matches);
    }
    throw Exception('Failed to load home data');
  }

}

