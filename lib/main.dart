import 'dart:async';

import 'package:flutter/material.dart';
import 'stock_list.dart';
import 'stock.dart';
import 'stock_service.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Stock Watcher App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _stockList = new List<Stock>();
  String _model = "";
  StockService _stockService = new StockService();

  @override
  initState() {
    super.initState();
  }

  Future<Null> _inputStock() async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: const Text('Input Stock Ticker Symbol'),
            contentPadding: EdgeInsets.all(5.0),
            content: new TextField(
              decoration: new InputDecoration(hintText: "Ticker Symbol"),
              onChanged: (String value) {
                _model = value;
              },
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Ok"),
              onPressed: () async {
                if(_model.isNotEmpty) {
                  double price = await _stockService.getPrice(_model);
                  setState(() {
                    var s = new Stock(_model, price);
                    s.lastUpdated = new DateTime.now();
                    _stockList.add(s);
                  });
                }                  
                _model = "";                  
                Navigator.pop(context);
              },
              ),
              new FlatButton(
                child: new Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  Future<void> _refreshStockPrices() async
  {
    print('refreshing stocks...');
    _stockList.forEach((s) async {
      double price = await _stockService.getPrice(s.symbol);
      setState(() {
        s.price = price;
        s.lastUpdated = new DateTime.now();              
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Container(
        child: new Center(
          child: new RefreshIndicator(
            child: new StockList(stocks: _stockList),
            onRefresh: _refreshStockPrices,
          ) 
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _inputStock(),
        tooltip: 'Add',
        child: new Icon(Icons.add),
      ),
    );
  }
}