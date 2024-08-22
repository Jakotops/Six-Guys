import 'package:http/http.dart' as http;
import 'dart:convert';

class Functionality{

  final APIKey = "W5GIE7M8AYEPJR75";

  //String symbol = 'AAPL';
  //String date = '2023-08-01';


  Future<double> fetchHistoricalPrice(String date, String symbol) async {
    String historicalUrl = 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=$APIKey';

    final response = await http.get(Uri.parse(historicalUrl));

    print(date);


    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final timeSeries = data['Time Series (Daily)'];

      print(response.body);

      if (timeSeries.containsKey(date)) {
        return double.parse(timeSeries[date]['4. close']);
      } else {
        throw Exception('Date not found in historical data');
      }
    } else {
      throw Exception('Failed to load historical price');
    }
  }

  Future<double> fetchCurrentPrice(String symbol) async {
    String currentPriceUrl = 'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=$symbol&apikey=$APIKey';
    final response = await http.get(Uri.parse(currentPriceUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return double.parse(data['Global Quote']['05. price']);
    } else {
      throw Exception('Failed to load current price');
    }
  }

  Future<double> calculateGainOrLoss(double amountInvested, String date, String symbol) async {
    try {
      double historicalPrice = await fetchHistoricalPrice(date, symbol);
      double currentPrice = await fetchCurrentPrice(symbol);

      double shares = amountInvested / historicalPrice;
      double currentValue = shares * currentPrice;

      return currentValue - amountInvested;

    } catch (e) {
      print(e);
      throw Exception('Failed');
    }
  }

}