import 'package:dio/dio.dart';
import 'api_response.dart';
import 'network.dart';

class Network {
  static int _timeOut = 10000; //10s
  static BaseOptions options = BaseOptions(
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
      baseUrl: ApiConstant.BASE_URL);
  static Dio _dio = Dio(options);

  Network._internal() {
    _dio.interceptors.add(LogInterceptor(
        responseBody: true, requestBody: true, requestHeader: true));
  }

  static final Network instance = Network._internal();

  Future<Response> get(
      {String url}) async {
    try {
      Response response = await _dio.get(
        url,
        options: Options(responseType: ResponseType.json, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
      );
      return response;
      // return getApiResponse(response);
    } on DioError catch (e) {
      print("DioError: ${e.toString()}");
      return getError(e);
    }
  }

  Future<Response> post(
      {String url,
      Object body = const {},
      Map<String, dynamic> params = const {}
      }) async {
    try {
      Response response = await _dio.post(
        url,
        data: body,
        queryParameters: params,
        options: Options(responseType: ResponseType.json, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
      );
      return response;
    } on DioError catch (e) {
      print("DioError: ${e.toString()}");
      return getError(e);
    }
  }

  Future<Response> put({
    String url,
    Object body = const {},
    Map<String, dynamic> params = const {},
  }) async {
    try {
      Response response = await _dio.put(
        url,
        data: body,
        queryParameters: params,
        options: Options(responseType: ResponseType.json, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
      );
      return response;
    } on DioError catch (e) {
      //handle error
      print("DioError: ${e.toString()}");
      return getError(e);
    }
  }

  Future<Response> delete({
    String url,
    Object body = const {},
    Map<String, dynamic> params = const {},
  }) async {
    try {
      Response response = await _dio.delete(
        url,
        data: body,
        queryParameters: params,
        options: Options(responseType: ResponseType.json, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }),
      );
      return response;
    } on DioError catch (e) {
      print("DioError: ${e.toString()}");
      return getError(e);
    }
  }

  Response<ApiResponse> getError(DioError e) {
    switch (e.type) {
      case DioErrorType.CANCEL:
        return Response<ApiResponse>(
            data: ApiResponse.error("error.connect_fail"));
      case DioErrorType.CONNECT_TIMEOUT:
        return Response<ApiResponse>(
            data: ApiResponse.error("error.connect_fail"));
      case DioErrorType.RECEIVE_TIMEOUT:
        return Response<ApiResponse>(
            data: ApiResponse.error("error.connect_fail"));
      case DioErrorType.SEND_TIMEOUT:
        return Response<ApiResponse>(
            data: ApiResponse.error("error.connect_fail"));
      case DioErrorType.DEFAULT:
        return Response<ApiResponse>(
          data: ApiResponse.error("error.connect_fail"),
        );
      default:
        return Response<ApiResponse>(
            data: ApiResponse.error("error.connect_fail"));
    }
  }
}
