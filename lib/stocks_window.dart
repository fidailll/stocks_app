import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stocks_app/stock_symbol.dart';

/// Окно акци1
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  GetRequest _getRequest = GetRequest();
  List<dynamic> listStock = [];
  List<dynamic> listStockCache = [];
  final _textController = TextEditingController();
  final _formKeyEdit = GlobalKey<FormState>();

  @override
  void initState() {
    _myRequest();
    super.initState();
  }

  Future<void> _myRequest() async {
    _getRequest.stockSymbol();

    setState(() {
      Timer(Duration(seconds: 10), () {
        listStock = _getRequest.listStock;
        listStockCache = _getRequest.listStock;
        print(listStock);
      });
    });
  }

  Map<int, dynamic> list = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(widget.title),
            Container(),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 40,
              //margin: EdgeInsets.only(top: 1, bottom: 1),
              decoration: BoxDecoration(
                  color: Colors.yellow[400],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const []),
              child: Form(
                key: _formKeyEdit,
                child: TextFormField(
                  controller: _textController,
                  cursorColor: Colors.black,
                  //strutStyle: StrutStyle()
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    //enabled: false,
                    hintText: 'Поиск',
                    hintStyle: TextStyle(color: Colors.white),
                    //focusColor: Colors.black,
                    icon: Icon(CupertinoIcons.search, color: Colors.white70),
                    labelStyle: const TextStyle(color: Colors.white70),
                  ),
                  onFieldSubmitted: (value) {
                    // print(_textController.text);
                    //print(listStock[5]['description'].length);
                    if (_textController.text != '') {
                      listStock = [];
                      for (int i = 0; i < listStockCache.length; i++) {
                        if (_textController.text ==
                                listStockCache[i]['description'] ||
                            _textController.text ==
                                listStockCache[i]['displaySymbol']) {
                          //print(listStock[i]['description']);
                          var element = listStockCache[i];
                          // print(listStockCache);
                          setState(() {
                            listStock.add(element);
                            //  print(listStock);
                          });
                        }
                      }
                      // setState(() {
                      //   listStock.clear();
                      //  });
                    } else {
                      setState(() {
                        //  print(listStockCache);
                        listStock = listStockCache;
                      });
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: FutureBuilder(
            future: Future.delayed(const Duration(seconds: 15)),
            builder: (context, snapshot) {
              return _myList();
              // return Text('');
            }),
      ),
    );
  }

  Widget _myList() {
    if (listStock.isNotEmpty) {
      ListView myList = ListView.builder(
        itemCount: listStock.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: const [
                        BoxShadow(
                            blurStyle: BlurStyle.normal,
                            color: Colors.black12,
                            blurRadius: 3.0,
                            spreadRadius: 3.0,
                            offset: Offset.zero),
                      ]),
                  margin: EdgeInsets.only(left: 1, right: 1, top: 1, bottom: 1),
                  child: Column(
                    children: [
                      // SizedBox(height: 10),
                      // Text('${_getRequest.listStock[index]['currency']}'),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.only(
                            left: 5, right: 5, top: 1, bottom: 1),
                        alignment: Alignment.topLeft,
                        child: Text('${listStock[index]['displaySymbol']}',
                            style: TextStyle(fontSize: 25)),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: 5, right: 5, top: 1, bottom: 1),
                        alignment: Alignment.topLeft,
                        child: Text('${listStock[index]['description']}',
                            style: TextStyle(fontSize: 15)),
                      )

                      // SizedBox(height: 10),
                      // Text('${_getRequest.listStock[index]['displaySymbol']}'),
                      // SizedBox(height: 10),
                      // Text('${_getRequest.listStock[index]['figi']}'),
                      // SizedBox(height: 10),
                      // Text('${_getRequest.listStock[index]['mic']}'),
                      // SizedBox(height: 10),
                      // Text('${_getRequest.listStock[index]['isin']}'),
                      // SizedBox(height: 10),
                      // Text('${_getRequest.listStock[index]['shareClassFIGI']}'),
                      // SizedBox(height: 10),
                      // Text('${_getRequest.listStock[index]['symbol']}'),
                      // SizedBox(height: 10),
                      // Text('${_getRequest.listStock[index]['symbol2']}'),
                      // SizedBox(height: 10),
                      // Text('${_getRequest.listStock[index]['type']}'),
                    ],
                  )),
            ],
          );
        },
      );
      return myList;
    } else {
      return Text('Идет загрузка...');
    }
  }
}
