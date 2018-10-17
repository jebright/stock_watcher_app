import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'stock.dart';

class StockList extends StatefulWidget {

  StockList({Key key, this.stocks}) : super(key: key);

  final List<Stock> stocks;

  @override
  State<StatefulWidget> createState() {
    return new _StockListState();
  }
}

class _StockListState extends State<StockList> {

  @override
  Widget build(BuildContext context) {
    return _buildStockList(context, widget.stocks);
  }

  ListView _buildStockList(context, List<Stock> stocks) {
    return new ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        var s = stocks[index];
        return ListTile(title: Text('${s.symbol}'), subtitle: Text('${s.price ?? "price not found"}'));
      },
    );
  }

}