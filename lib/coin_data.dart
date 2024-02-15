import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const authority = 'rest.coinapi.io';

const apiKey = '9514F48A-57E3-4D56-BC28-32452BB5248B';

class CoinData {
  CoinData(this.currency);

  final currency;


  Future getCoinData(String selectedCurrency) async {

    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {

      var url = Uri.https(authority, '/v1/exchangerate/$crypto/$currency',{'apikey':apiKey});

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];

        cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
        print(response.statusCode);
        print(lastPrice);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }

      if(response.statusCode == 429){
        print(response.headers['x-ratelimit-remaining']);
      }
    }
    return cryptoPrices;
  }
}



//https://rest.coinapi.io/v1/exchangerate/BTC/USD?apiKEY=9514F48A-57E3-4D56-BC28-32452BB5248B