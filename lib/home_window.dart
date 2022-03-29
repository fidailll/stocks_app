import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Акции',
      theme: ThemeData(
        fontFamily: 'Exo2',
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.yellow[600],
          shadowColor: Colors.grey[200],
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 25),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.green[50],
          unselectedItemColor: Colors.green,
          selectedItemColor: Colors.green[800],
        ),
      ),
      home: const MyHomePage(title: 'Акции США'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://ws.finnhub.io/?token=c8sugoiad3ib2st12aa0'),
  );
  List<Map>? listData;
  @override
  void initState() {
    channel.sink.add('{"type":"subscribe","symbol":"AAPL"}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(widget.title),
          ],
        ),
      ),
      body: Center(
        child: StreamBuilder(
          stream: channel.stream,
          builder: (context, snapshot) {
            Map<String, dynamic>? data;
            snapshot.hasData
                ? {
                    data = jsonDecode(snapshot.data.toString()),
                    for (int i = 0; i < data!.length; i++)
                      {listData!.add(data['data'][i])}
                  }
                : data = {};

            return Text(snapshot.hasData ? '${listData![0]['c']}' : '');
          },
        ),
      ),
    );
  }
}
