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

  deleteFromList(Stock s) {
    print('removing ${s.symbol}');
    setState(() {
          this.widget.stocks.remove(s);
        });
        Scaffold.of(context).removeCurrentSnackBar(); //in case we are doing more than 1 per 2 seconds...
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("${s.symbol} removed!"),
        duration: new Duration(seconds: 2),        
        ));
  }

  ListView _buildStockList(context, List<Stock> stocks) {
    return new ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        var s = stocks[index];
        return Dismissible(
          key: Key(s.symbol),
          background: Container(color: Colors.grey),
          onDismissed: (direction) {
            deleteFromList(s);
          },
          child: ListTile(
              title: Text('${s.symbol}'), 
              subtitle: Text(
              '${s.price ?? "price not found"}' + ", last updated: ${s.lastUpdated}"
            )
        ),
        );
      },
    );
  }

}