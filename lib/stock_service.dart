import 'package:http/http.dart' as http;
import 'dart:async';

class StockService {

  Future<double> getPrice(String symbol) async {
    String url = "https://api.iextrading.com/1.0/stock/${symbol}/price";
    print('getting price for: ' + url);
    http.Response response = await http.get(url);
    double price = double.tryParse(response.body);
    print('price for ${symbol} was ${price}');
    return price;
  }

}