import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StockSymbol {
  late String apiKey;
  late String exchange;
  late String token;
  List<dynamic> listStock = [];

  Future<Dio?> stockSymbol(context) async {
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
      //debugPrint(response.data);
      //   print(response.statusCode);
      //Map<String, dynamic>.from(response.data);
      listStock = json.decode(response.data);
      //print(listStock![1].runtimeType);
    } on DioError catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text("Уведомление"),
              content: Text("Нету соединения с сервером!"),
            );
          });
      print(e);
    }
  }
}
