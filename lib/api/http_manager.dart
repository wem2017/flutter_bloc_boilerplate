import 'dart:convert' show utf8;

import 'package:dio/dio.dart';
import 'package:envato/blocs/bloc.dart';
import 'package:envato/configs/config.dart';
import 'package:envato/utils/utils.dart';

class HTTPManager {
  late final Dio dioInternal;
  late final Dio dioExternal;

  final List<String> rejectCode = [
    'jwt expired',
    'un_authorized',
    'user_not_found'
  ];

  HTTPManager() {
    ///Dio internal
    dioInternal = Dio(
      BaseOptions(
        baseUrl: Application.domain,
        connectTimeout: 10000,
        receiveTimeout: 10000,
        responseType: ResponseType.json,
      ),
    );

    ///Dio external
    dioExternal = Dio(
      BaseOptions(
        baseUrl: "https://api.envato.com",
        connectTimeout: 10000,
        receiveTimeout: 10000,
        responseType: ResponseType.json,
      ),
    );

    ///Interceptors internal
    dioInternal.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          Map<String, dynamic> headers = {
            "uuid": Application.device?.uuid,
            "name": utf8.encode(Application.device?.name ?? ''),
            "model": Application.device?.model,
            "version": Application.device?.version,
            "appVersion": Application.version,
            "type": Application.device?.type,
            "token": Application.device?.token,
          };
          String? token = AppBloc.userCubit.state?.token;
          if (token != null) {
            headers["Authorization"] = "Bearer $token";
          }
          options.headers.addAll(headers);
          printRequest(options);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError error, handler) async {
          if (error.type != DioErrorType.response) {
            return handler.next(error);
          }
          final message = error.response?.data['message'];

          ///Logout
          if (rejectCode.contains(message)) {
            dioInternal.lock();
            dioInternal.interceptors.responseLock.lock();
            dioInternal.interceptors.errorLock.lock();
            dioExternal.lock();
            dioExternal.interceptors.responseLock.lock();
            dioExternal.interceptors.errorLock.lock();
            await AppBloc.signCubit.onLogOut();
            dioExternal.unlock();
            dioExternal.interceptors.responseLock.unlock();
            dioExternal.interceptors.errorLock.unlock();
            dioInternal.unlock();
            dioInternal.interceptors.responseLock.unlock();
            dioInternal.interceptors.errorLock.unlock();
          }
          final response = Response(
            requestOptions: error.requestOptions,
            data: error.response?.data,
          );
          return handler.resolve(response);
        },
      ),
    );

    ///Interceptors external
    dioExternal.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          Map<String, dynamic> headers = {};
          String? token = AppBloc.userCubit.state?.envatoToken;
          if (token != null) {
            headers["Authorization"] = "Bearer $token";
          }
          options.headers.addAll(headers);
          printRequest(options);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          response.data = {
            "success": true,
            "data": response.data,
          };
          return handler.next(response);
        },
        onError: (DioError error, handler) async {
          if (error.type != DioErrorType.response) {
            return handler.next(error);
          }
          final options = error.response!.requestOptions;
          final data = error.response?.data ?? {};

          if (error.response?.statusCode == 403) {
            dioExternal.lock();
            dioExternal.interceptors.responseLock.lock();
            dioExternal.interceptors.errorLock.lock();
            final user = await AppBloc.userCubit.onLoadUser();
            if (user != null) {
              String? token = user.envatoToken;
              if (token != null) {
                options.headers["Authorization"] = "Bearer $token";
              }
              dioExternal.unlock();
              dioExternal.interceptors.responseLock.unlock();
              dioExternal.interceptors.errorLock.unlock();
              printRequest(options);
              dioExternal.fetch(options).then(
                (r) => handler.resolve(r),
                onError: (e) {
                  handler.reject(e);
                },
              );
              return;
            }
          }

          if (error.response?.statusCode == 429) {
            int retry = 60;
            retry = int.tryParse(
              error.response!.headers['retry-after']![0],
            )!;
            AppBloc.messageBloc.add(OnMessage(message: 'limit_request'));
            dioExternal.lock();
            dioExternal.interceptors.responseLock.lock();
            dioExternal.interceptors.errorLock.lock();
            await Future.delayed(Duration(seconds: retry));
            dioExternal.unlock();
            dioExternal.interceptors.responseLock.unlock();
            dioExternal.interceptors.errorLock.unlock();
            printRequest(options);
            dioExternal.fetch(options).then(
              (r) => handler.resolve(r),
              onError: (e) {
                handler.reject(e);
              },
            );
            return;
          }

          final response = Response(
            requestOptions: error.requestOptions,
            data: {
              "success": false,
              "message": data['reason'] ?? data['error'],
              "data": data,
            },
          );

          return handler.resolve(response);
        },
      ),
    );
  }

  ///Post method
  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? data,
    Options? options,
    bool external = false,
  }) async {
    Dio request = dioInternal;
    if (external) {
      request = dioExternal;
    }
    try {
      final response = await request.post(
        url,
        data: data,
        options: options,
      );
      return response.data;
    } on DioError catch (error) {
      return errorHandle(error);
    }
  }

  ///Get method
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? params,
    Options? options,
    bool external = false,
  }) async {
    Dio request = dioInternal;
    if (external) {
      request = dioExternal;
    }
    try {
      final response = await request.get(
        url,
        queryParameters: params,
        options: options,
      );
      return response.data;
    } on DioError catch (error) {
      return errorHandle(error);
    }
  }

  ///Print request info
  void printRequest(RequestOptions options) {
    UtilLogger.log("BEFORE REQUEST ====================================");
    UtilLogger.log("${options.method} URL", options.path);
    UtilLogger.log("HEADERS", options.headers);
    if (options.method == 'GET') {
      UtilLogger.log("PARAMS", options.queryParameters);
    } else {
      UtilLogger.log("DATA", options.data);
    }
  }

  ///Error common handle
  Map<String, dynamic> errorHandle(DioError error) {
    String message = "unknown_error";
    Map<String, dynamic> data = {};

    switch (error.type) {
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        message = "request_time_out";
        break;

      default:
        message = "cannot_connect_server";
        break;
    }

    return {
      "success": false,
      "message": message,
      "data": data,
    };
  }
}
