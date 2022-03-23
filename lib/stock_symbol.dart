import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class GetRequest {
  late String apiKey;
  late String exchange;
  late String token;
  List<dynamic> listStock = [];

  Future<Dio?> stockSymbol() async {
    exchange = 'US';
    token = 'c8sugoiad3ib2st12aa0';
    String url = 'https://finnhub.io';
    try {
      var options = BaseOptions(
        method: 'GET',
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
        baseUrl: url,
        //connectTimeout: 7000,
        //receiveTimeout: 7000,
      );

      Dio dio = Dio(options);
      var response =
          await dio.get('/api/v1/stock/symbol?exchange=$exchange&token=$token');
      debugPrint(response.data);
      //   print(response.statusCode);
      //Map<String, dynamic>.from(response.data);
      listStock = json.decode(response.data);
      //print(listStock![1].runtimeType);
    } on DioError catch (e) {
      print(e);
    }
  }
}
