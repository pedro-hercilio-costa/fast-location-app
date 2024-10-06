import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../modules/home/model/address_model.dart';

class ApiCall extends StatelessWidget {
  const ApiCall({super.key});

  Future<List<AddressModel>> fetchAPI(numCep) async {
    Dio dio = Dio();

    var response = await dio.get('https://viacep.com.br/ws/$numCep/json/');

    final List<dynamic> responseData = response.data;
    List<AddressModel> result =
        responseData.map((json) => AddressModel.fromJson(json)).toList();

    return result;
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

mixin AppDio {
  static Future<Dio> getConnection(cepController) async {
    String numCep = cepController.text;
    Dio dio = Dio();

    final Map<String, String> headers = <String, String>{};

    dio.options = BaseOptions(
        baseUrl: 'https://viacep.com.br/ws/$numCep/json/',
        receiveTimeout: const Duration(milliseconds: 30000),
        sendTimeout: const Duration(milliseconds: 15000),
        headers: headers);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        onRequest(options);
        handler.next(options);
      },
      onResponse: onResponse,
      onError: (error, handler) async {
        onError(dio, error, handler);
      },
    ));

    return dio;
  }

  static void onRequest(RequestOptions options) {
    options.headers["Accept"] = "application/json";
    options.headers["Content-Type"] = "application/json";

    debugPrint('-----------| Request log |-----------');
    debugPrint('${options.uri}');
  }

  static void onResponse(
      Response<dynamic> response, ResponseInterceptorHandler handler) {
    debugPrint('-----------| Response log |-----------');
    debugPrint(response.data.toString());
    handler.next(response);
  }

  static void onError(
      Dio dio, DioError error, ErrorInterceptorHandler handler) {
    debugPrint('-----------| Error log |-----------');
    debugPrint('${error.response}');
    handler.next(error);
  }
}
