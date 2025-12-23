import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app/constants/api_string.dart';
import 'package:movie_app/utils/setting.dart';

class ApiHandler {
  static String baseURL = APIString.baseURL;
  static final Dio dio = Dio();
  // static final bool _isRefreshing = false;

  // Initialize once at app startup

  static void init() {
    // Add interceptor for global error handling
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) async {
          if (e.response?.statusCode == 401) {
            //  dio.; // block new requests
            // dio.close(force: true); // cancel pending requests

            await Storage.clearStorage();

            // Try to refresh token
            // if (await refreshToken()) {
            //   // Refresh successful, retry original request with new token
            //   final options = e.requestOptions;
            //   options.headers['Authorization'] = 'Bearer ${Settings.token}';
            //   return handler.resolve(await dio.fetch(options));
            // }
            // Refresh failed, continue with errors
            // return handler.next(e);
          }
          return handler.next(e);
        },
      ),
    );
  }

  // // Simple refresh token implementation
  // static Future<bool> refreshToken() async {
  //   // Prevent multiple simultaneous refresh attempts
  //   if (_isRefreshing) return false;

  //   _isRefreshing = true;
  //   log("Refreshing token...");

  //   try {
  //     // URL encode the refresh token
  //     // Prepare form data for token request
  //     final formData = {
  //       'client_id': 'be18d275-281b-42b5-a8a6-eb2a608ba04b',
  //       'client_secret': '2ecded3d-c893-4231-9eb5-7ce395b8b1ea',
  //       'grant_type': 'client_credentials',
  //       'scope': 'InvoicingAPI',
  //     };

  //     log("Token API URL: $baseURL${APIString.tokenApi}");
  //     log("Form data: $formData");

  //     // Make token request
  //     final response = await dio.post(
  //       "$baseURL${APIString.tokenApi}",
  //       data: formData,
  //       options: Options(
  //         headers: {
  //           'onbehalfof': 'C1851771040',
  //           'Content-Type': 'application/x-www-form-urlencoded',
  //         },
  //         contentType: Headers.formUrlEncodedContentType,
  //       ),
  //     );

  //     // Process successful response
  //     if (response.statusCode == 200 && response.data != null) {
  //       final data = response.data;

  //       // Update tokens
  //       if (data['access_token'] != null) {
  //         Settings.token = data['access_token'];
  //       }

  //       _isRefreshing = false;
  //       return true;
  //     } else {
  //       await signOut(isRoute: true);
  //     }
  //   } catch (e) {
  //     _isRefreshing = false;
  //     await signOut(isRoute: true);

  //     log("Refresh token error: $e");
  //   }

  //   _isRefreshing = false;
  //   return false;
  // }

  // Get request headers
  static Future<Map<String, String>> _getHeaders() async {
    final String? token = null;
    /*final String? token =   Storage.token */

    log("---Token---- :- ${token ?? ""}");
    return {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // GET method
  static Future<ApiResponse> get(
    String? url, {
    bool isMockUrl = false,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final header = await _getHeaders();
      final fullUrl = isMockUrl ? "$url" : "$baseURL$url";

      log("GET: $fullUrl");

      final response = await dio.get(
        fullUrl,
        options: Options(headers: headers ?? header),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      log("Error: ${e.message}");
      return ApiResponse(
        body: e.response?.data,
        error: "${e.response?.statusCode ?? 'Unknown'}",
        statusCode: e.response?.statusCode,
      );
    }
  }

  // POST method
  static Future<ApiResponse> post(
    String? url, {
    dynamic body,
    bool isMockUrl = false,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final header = await _getHeaders();
      final fullUrl = isMockUrl ? "$url" : "$baseURL$url";
      log("POST Api: $fullUrl");
      log("body: ${jsonEncode(body)}");

      final response = await dio.post(
        fullUrl,
        data: jsonEncode(body),
        options: Options(headers: headers ?? header),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      log("Error: ${e.message}");
      return ApiResponse(
        body: e.response?.data,
        error: "${e.response?.statusCode ?? 'Unknown'}",
        statusCode: e.response?.statusCode,
      );
    }
  }

  // PUT method
  static Future<ApiResponse> put(
    String? url, {
    dynamic body,
    bool isMockUrl = false,
  }) async {
    try {
      final header = await _getHeaders();
      final fullUrl = isMockUrl ? "$url" : "$baseURL$url";
      log("PUT Api: $fullUrl");
      log("body: ${jsonEncode(body)}");

      final response = await dio.put(
        fullUrl,
        data: body,
        options: Options(headers: header),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      log("Error: ${e.message}");
      return ApiResponse(
        body: e.response?.data,
        error: "${e.response?.statusCode ?? 'Unknown'}",
        statusCode: e.response?.statusCode,
      );
    }
  }

  // PATCH method
  static Future<ApiResponse> patch(
    String? url, {
    dynamic body,
    bool isMockUrl = false,
  }) async {
    try {
      final header = await _getHeaders();
      final fullUrl = isMockUrl ? "$url" : "$baseURL$url";
      log("Patch Api: $fullUrl");
      log("body: ${jsonEncode(body)}");

      final response = await dio.patch(
        fullUrl,
        data: body,
        options: Options(headers: header),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      log("Error: ${e.message}");
      return ApiResponse(
        body: e.response?.data,
        error: "${e.response?.statusCode ?? 'Unknown'}",
        statusCode: e.response?.statusCode,
      );
    }
  }

  // DELETE method
  static Future<ApiResponse> delete(String? url) async {
    try {
      final header = await _getHeaders();

      log("DELETE: $baseURL$url");

      final response = await dio.delete(
        "$baseURL$url",
        options: Options(headers: header),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      log("Error: ${e.message}");
      return ApiResponse(
        body: e.response?.data,
        error: "${e.response?.statusCode ?? 'Unknown'}",
        statusCode: e.response?.statusCode,
      );
    }
  }

  // Handle API response
  static ApiResponse _handleResponse(Response response) {
    final int statusCode = response.statusCode ?? 0;
    debugPrint("Response Code: $statusCode");
    debugPrint("Response ==> ${jsonEncode(response.data)}");

    if (statusCode >= 200 && statusCode < 300) {
      return ApiResponse(
        body: response.data,
        error: null,
        statusCode: statusCode,
      );
    } else {
      String errorType = "ERROR";

      if (statusCode >= 400 && statusCode < 500) {
        switch (statusCode) {
          case 400:
            errorType = "BAD_REQUEST";
            break;
          case 401:
            errorType = "UNAUTHORIZED";
            break;
          case 403:
            errorType = "FORBIDDEN";
            break;
          case 404:
            errorType = "NOT_FOUND";
            break;
          case 422:
            errorType = "VALIDATION_ERROR";
            break;
          default:
            errorType = "CLIENT_ERROR";
        }
      } else if (statusCode >= 500) {
        errorType = "SERVER_ERROR";
      }

      return ApiResponse(
        body: response.data,
        error: errorType,
        statusCode: statusCode,
      );
    }
  }
}

class ApiResponse {
  final dynamic body;
  final String? error;
  final int? statusCode;

  ApiResponse({this.body, this.error, this.statusCode});

  // Create from API response map
  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      body: json['body'],
      error: json['error'],
      statusCode: json['statusCode'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {'body': body, 'error': error, 'statusCode': statusCode};
  }

  // Check if the response is successful (no error)
  bool get isSuccess => error == null;
}
