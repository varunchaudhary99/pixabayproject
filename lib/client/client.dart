
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'exceptions.dart';
import 'log_interceptor.dart'as LogInterceptor;

const _defaultConnectTimeout = Duration(seconds: 30);
const _defaultReceiveTimeout = Duration(seconds: 30);

setContentType() {
  return "application/json";
}

class _DioClient {
  String baseUrl ='https://pixabay.com';

  static late Dio _dio;

  final List<Interceptor>? interceptors;

  _DioClient( {
        this.interceptors,
      }) {
    _dio = Dio();
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.contentType = setContentType()
      ..options.headers = {
        'Content-Type': setContentType(),
      };

    if (interceptors?.isNotEmpty ?? false) {
      _dio.interceptors.addAll(interceptors!);
    }
    if (kDebugMode) {
      _dio.interceptors.add(
        LogInterceptor.LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: true,
          responseHeader: false,
          request: false,
          requestBody: true,
        ),
      );
    }
  }

  Future<dynamic> get(String uri,
      {Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
        bool skipAuth =false}) async {
    try {
      /*if (skipAuth == false) {
        String? token = await globalData.authToken;//TODO
        debugPrint("Token - $token");
        if (token != null) {
          options = Options(headers: {"Authorization": "Bearer $token"});
        }
      }*/
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  Future<dynamic> delete(String uri,
      {Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
        bool skipAuth =false}) async {
    try {
     /* if (skipAuth == false) {
        //for token
      String? token = await globalData.authToken;
        debugPrint("Token - $token");
        if (token != null) {
          options = Options(headers: {"Authorization": "Bearer $token"});
        }
      }*/
      var response = await _dio.delete(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }

  Future<dynamic> post(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
        bool? skipAuth = false,
        bool? isLoading = true,
        String? authToken,/// if user want to send token manually
      }) async {
    try {
      /*if (skipAuth == false) {
        String? token = (await globalData.authToken)?? authToken;//TODO
        debugPrint("authorization============ $token");

        if (token != null) {
          if (options == null) {
            options = Options(headers: {"Authorization": "Bearer $token"});
          }
        }
      }*/

      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {

      throw FormatException("Unable to process the data");
    } catch (e) {
      throw NetworkExceptions.getDioException(e);
    }
  }


  static Future<dynamic> put(
      String uri, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {

      throw NetworkExceptions.getDioException(e);
    }
  }
}

var apiRequest = _DioClient();

class SuccessMessage{
  String message;
  String copyrights;
  SuccessMessage(this.message,this.copyrights);
  SuccessMessage.fromJson(Map<String,dynamic> json):
        this.message = json['message']??'',
        this.copyrights = json['copyrights']??"";

}