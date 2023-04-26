import 'package:flutter/material.dart';

class CurrencyBar extends StatelessWidget {
  const CurrencyBar({
    super.key,
    required this.firstCurrency,
    required this.priceCurrency,
    required this.selectedCurrency,
  });

  final String priceCurrency;
  final String selectedCurrency;
  final String firstCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
          color: Colors.lightBlueAccent,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
            child: Text(
              '1 $firstCurrency = $priceCurrency $selectedCurrency',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          )),
    );
  }
}
