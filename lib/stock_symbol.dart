import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class GetRequest {
  late String apiKey;
  late String exchange;
  late String token;

  Future<Dio?> stockSymbol() async {
    exchange = 'US';
    token = 'c8sugoiad3ib2st12aa0';
    String url = 'https://finnhub.io';
    try {
      var options = BaseOptions(
        method: 'GET',
        // headers: {
        //   'authorization':
        //       'Basic ${_loginController.text}-|+${sha256.convert(utf8.encode(_passController.text))}',
        //  },
        //headers: {
        //  'authorization':
        //       'Basic test-|+-9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08',
        //  },
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
        baseUrl: url,
        connectTimeout: 7000,
        receiveTimeout: 7000,
      );

      Dio dio = Dio(options);
      var response =
          await dio.get('/api/v1/stock/symbol?exchange=$exchange&token=$token');
      debugPrint(response.data);
      print(response.statusCode);

      List<dynamic> jsonFormate = json.decode(response.data);
      print(jsonFormate[1]);

      //     setState(() {
      //       if (response.data != 'false' && response.statusCode == 200) {
      //         print(response.data);
      //         _token = response.data.split('+|-');

      //         Get.to(
      //             BottomMenu(_token, _loginController.text, _passController.text));
      //         _loginController.text = '';
      //         _passController.text = '';
      //       } else if (response.statusCode != 200) {
      //         showDialog(
      //             context: context,
      //             builder: (BuildContext context) {
      //               return AlertDialog(
      //                 title: Text(_dictionary.localization()!['notification']),
      //                 content: Text(
      //                     "${_dictionary.localization()!['mistake']}: ${response.statusCode}"),
      //               );
      //             });
      //       } else {
      //         showDialog(
      //             context: context,
      //             builder: (BuildContext context) {
      //               return AlertDialog(
      //                 title: Text(
      //                   _dictionary.localization()!['mistake'],
      //                 ),
      //                 content: Text(_dictionary
      //                     .localization()!['youEnteredTheWrongUsernameOrPassword']),
      //               );
      //             });
      //       }
      //     });
      //   } on DioError catch (e) {
      //     showDialog(
      //         context: context,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //             title: Text(_dictionary.localization()!['mistake']),
      //             content:
      //                 Text(_dictionary.localization()!['noConnectionToServer']),
      //           );
      //         });
      //   }
    } on DioError catch (e) {
      print(e);
    }
  }
}
