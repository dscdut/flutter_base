import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_unihack_template/common/constants/hive_keys.dart';
import 'package:flutter_unihack_template/data/dtos/auth/refresh_token_dto.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

class AppInterceptor extends QueuedInterceptor {
  AppInterceptor({
    @Named(HiveKeys.authBox) required Box<dynamic> authBox,
    required Dio dio,
  })  : _authBox = authBox,
        _dio = dio;

  final Box<dynamic> _authBox;
  final Dio _dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    log('REQUEST[${options.method}] => PATH: ${options.path}');

    await _checkTokenExpired();

    final accessToken = _authBox.get(HiveKeys.accessToken) as String?;

    if (accessToken != null) {
      options.headers.addAll({
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      });
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    log(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
      name: 'Intercepter: onResponse',
    );

    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      // HACK: handle logout, maybe

      return;
    }

    log(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
      name: 'Intercepter: onError',
    );

    return handler.next(err);
  }

  Future<void> _checkTokenExpired() async {
    final expiredTime = _authBox.get(HiveKeys.expiresIn) as String?;

    if (expiredTime != null && DateTime.parse(expiredTime).isBefore(DateTime.now().add(const Duration(seconds: 3)))) {
      await _refreshToken();
    }
  }

  Future<void> _refreshToken() async {
    final refreshToken = _authBox.get(HiveKeys.refreshToken) as String?;

    if (refreshToken == null || refreshToken.isEmpty) {
      // TODO: navigate to login screen

      return;
    }

    log('--[REFRESH TOKEN]--: $refreshToken');

    try {
      final response = await _dio.get('');

      final refreshTokenDTO = RefreshTokenDTO.fromJson(response.data as Map<String, dynamic>);

      await _authBox.putAll(refreshTokenDTO.toLocalJson());
    } catch (err) {
      // TODO: logout
    }
  }
}
