import 'package:asset_portfolio/db/db.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:asset_portfolio/model/assetportfolio.dart';
import 'package:intl/intl.dart';
import 'package:asset_portfolio/const.dart';

class AutoStockChart extends StatefulWidget {
  @override
  _AutoStockChartState createState() => _AutoStockChartState();
}

class _AutoStockChartState extends State<AutoStockChart> {
  List<charts.Series<AssetPortfolio, String>> _seriesPieData;
  List<AssetPortfolio> mydata = [];
  bool loading = true;
  List<AssetPortfolio> stocks = [];
  DBHelper db = DBHelper();
  NumberFormat f = NumberFormat('#,###');
  int allmoney = 0;

  _generateData(mydata) {
    _seriesPieData = List<charts.Series<AssetPortfolio, String>>();
    _seriesPieData = [];
    _seriesPieData.add(
      charts.Series(
        id: 'stockportfolios',
        domainFn: (AssetPortfolio portfolio, _) => portfolio.kind,
        measureFn: (AssetPortfolio portfolio, _) => portfolio.money,
        colorFn: (_, index) {
          if (index < colors.length)
            return colors[index];
          else {
            return charts.MaterialPalette.blue.shadeDefault;
          }
        },
        data: mydata,
        // Set a label accessor to control the text of the arc label.
        labelAccessorFn: (AssetPortfolio row, _) =>
            '${row.percent.toStringAsFixed(1)}%',
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getStocks();
  }

  @override
  Widget build(BuildContext context) {
    _generateData(stocks);
    return new charts.PieChart(
      _seriesPieData,
      animate: false,
      animationDuration: Duration.zero,
      behaviors: [
        new charts.DatumLegend(
            outsideJustification: charts.OutsideJustification.middleDrawArea,
            horizontalFirst: false,
            desiredMaxRows: 3,
            cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
            entryTextStyle: charts.TextStyleSpec(
                color: charts.MaterialPalette.purple.shadeDefault,
                fontFamily: 'Georgia',
                fontSize: 11))
      ],
      defaultRenderer: new charts.ArcRendererConfig(
        arcWidth: 100,
        arcRendererDecorators: [
          new charts.ArcLabelDecorator(
            labelPosition: charts.ArcLabelPosition.auto,
          )
        ],
      ),
    );
  }

  Future getStocks() async {
    stocks = await db.getStocksPortfolio();

    allmoney = getAllsum(stocks);

    calculatePercent(stocks, allmoney);

    setState(() {
      loading = false;
    });
  }

  int getAllsum(List<AssetPortfolio> stock) {
    int allSum = 0;

    for (int i = 0; i < stock.length; i++) {
      allSum += stock[i].money;
    }

    return allSum;
  }

  void calculatePercent(List<AssetPortfolio> stock, int allsum) {
    for (int i = 0; i < stock.length; i++) {
      double percent = (stock[i].money / allsum) * 100;

      stock[i].asset = stock[i].asset;
      stock[i].kind = stock[i].kind;
      stock[i].safety = stock[i].safety;
      stock[i].money = stock[i].money;
      stock[i].percent = percent;
    }
  }
}
