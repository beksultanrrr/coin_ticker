import 'services/networking.dart';

class CoinModel {
   Future  getCurrentPrice(firstCurrency, selectedCurrency) async {
    NetworkingHelper networkingHelper = NetworkingHelper(
        Url:
            "https://rest.coinapi.io/v1/exchangerate/$firstCurrency/$selectedCurrency?apikey=9A235888-FFF8-4744-8876-47BB48B0EB2D");
    var decodeData = await networkingHelper.getData();
    return decodeData["rate"];
  }
}

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {}
