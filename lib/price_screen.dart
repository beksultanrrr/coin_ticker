import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'currency_bar.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);
  @override
  PriceScreenState createState() => PriceScreenState();
}

class PriceScreenState extends State<PriceScreen> {
  Map<String, double> priceCurrencyList = {};

  @override
  initState() {
    super.initState();
    first("USD");
  }

  void first(String value) async {
    priceCurrencyList['BTC'] = await coinModel.getCurrentPrice("BTC", value);
    priceCurrencyList['ETH'] = await coinModel.getCurrentPrice("BTC", value);
    priceCurrencyList['LTC'] = await coinModel.getCurrentPrice("BTC", value);

    setState(() {});
  }

  CoinModel coinModel = CoinModel();

  String priceCurrencyBTC = "?";
  String priceCurrencyETH = "?";
  String priceCurrencyLTC = "?";
  String selectedCurrency = "USD";

  void updateUI(
      dynamic decodeDataBTC, dynamic decodeDataETH, dynamic decodeDataLTC) {
    setState(() {
      try {
        priceCurrencyBTC = decodeDataBTC.toStringAsFixed(0);
        priceCurrencyETH = decodeDataETH.toStringAsFixed(0);
        priceCurrencyLTC = decodeDataLTC.toStringAsFixed(0);
      } catch (e) {
        print(e);
      }
      // print("YES");
      // if (decodeData == null) {
      //   priceCurrency = "Error";
      //   return;
      // }
      // print("DECODE $decodeData");
      // double selCur = decodeData["rate"];
      // priceCurrency = selCur.toStringAsFixed(0);
      // print("AAAAAAAAAAAAAAAAAAAAA $priceCurrency");
    });
  }

  DropdownButton<String> andoidDropDown() {
    List<DropdownMenuItem<String>> dropDownItems = currenciesList
        .map((currency) =>
            DropdownMenuItem<String>(child: Text(currency), value: currency))
        .toList();
    // List<DropdownMenuItem<String>> dropDownItems = [];
    // for (int i = 0; i < currenciesList.length; i++) {
    //   String currency = currenciesList[i];
    //   var newItem = DropdownMenuItem(
    //     child: Text(currency),
    //     value: currency,
    //   );
    //   dropDownItems.add(newItem);
    // }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItems,
      // for (var curren in currenciesList)
      // DropdownMenuItem(
      //   child: Text(curren),
      //   value: curren,
      // ),

      onChanged: (value) async {
        selectedCurrency = value!;
        first(selectedCurrency);
      },
    );
  }

  CupertinoPicker IOSPickker() {
    List<Text> dropDownItems2 = currenciesList
        .map(
          (e) => Text(e),
        )
        .toList();
    // List<Text> dropDownItems2 = [];
    // for (var i in currenciesList) {
    //   var newItem = Text(i);
    //   dropDownItems2.add(newItem);
    // }
    return CupertinoPicker(
        itemExtent: 32,
        onSelectedItemChanged: (selectedIndex) async {
          var decodeDataBTC = await coinModel.getCurrentPrice(
              "BTC", dropDownItems2[selectedIndex].data);
          var decodeDataETH = await coinModel.getCurrentPrice(
              "ETH", dropDownItems2[selectedIndex].data);
          var decodeDataLTC = await coinModel.getCurrentPrice(
              "LTC", dropDownItems2[selectedIndex].data);
          updateUI(decodeDataBTC, decodeDataETH, decodeDataLTC);
        },
        children: dropDownItems2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: cryptoList.asMap().entries.map((entry) {
              int index = entry.key;
              String cryptoName = entry.value;
              String cryptoColor =
                  priceCurrencyList[cryptoName]?.toStringAsFixed(0) ?? '?';
              return CurrencyBar(
                  firstCurrency: cryptoName,
                  priceCurrency: cryptoColor,
                  selectedCurrency: selectedCurrency);
            }).toList(),
          ),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: IOSPickker(),
          ), //[for (var curren in currenciesList) Text(curren)]
        ],
      ),
    );
  }
}
