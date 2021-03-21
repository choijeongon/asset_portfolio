import 'package:asset_portfolio/module/AutoStockChart.dart';
import 'package:flutter/material.dart';

class StockPortfolioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Column(
          children: [
            Expanded(
              child: AutoStockChart(),
            ),
          ],
        ),
    );
  }
}