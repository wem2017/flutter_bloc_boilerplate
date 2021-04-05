import 'package:dio/dio.dart';
import 'package:envato/blocs/bloc.dart';
import 'package:envato/configs/config.dart';
import 'package:envato/utils/logger.dart';

final List<String> rejectCode = [
  'jwt expired',
  'un_authorized',
  'invalid-token'
];

Map<String, dynamic> errorHandle({required DioError error}) {
  UtilLogger.log("ERROR", error);
  String message = "unknown_error";

  Map<String, dynamic>? data;

  switch (error.type) {
    case DioErrorType.sendTimeout:
    case DioErrorType.receiveTimeout:
      message = "request_time_out";
      break;
    case DioErrorType.response:
      if (error.response!.data is Map<String, dynamic>) {
        data = error.response!.data;
        message = data!['reason'] ?? data['message'] ?? message;
      }
      break;
    default:
      message = "connect_to_server_fail";
      break;
  }

  ///Logout
  if (rejectCode.contains(message)) {
    AppBloc.authBloc.add(OnClear());
  }

  return {
    "success": false,
    "message": message,
    "data": data,
  };
}

class HTTPManager {
  BaseOptions baseOptions = BaseOptions(
    baseUrl: Application.domain,
    connectTimeout: 10000,
    receiveTimeout: 10000,
    responseType: ResponseType.json,
  );

  BaseOptions exportOption() {
    String? token;
    final Map<String, dynamic> header = {"uuid": ''};
    baseOptions.headers.addAll(header);

    if (token != null) {
      baseOptions.headers["Authorization"] = token;
    }
    return baseOptions;
  }

  ///Post method
  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    UtilLogger.log("POST URL", url);
    UtilLogger.log("DATA", data);
    Dio dio = new Dio(exportOption());
    try {
      final response = await dio.post(
        url,
        data: data,
        options: options,
      );
      return response.data;
    } on DioError catch (error) {
      return errorHandle(error: error);
    }
  }

  ///Get method
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    UtilLogger.log("GET URL", url);
    UtilLogger.log("PARAMS", params);
    Dio dio = new Dio(exportOption());
    try {
      final response = await dio.get(
        url,
        queryParameters: params,
        options: options,
      );
      return response.data;
    } on DioError catch (error) {
      return errorHandle(error: error);
    }
  }

  factory HTTPManager() {
    return HTTPManager._internal();
  }

  HTTPManager._internal();
}
