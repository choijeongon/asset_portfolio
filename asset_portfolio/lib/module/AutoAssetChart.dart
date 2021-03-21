import 'package:asset_portfolio/controller/controller.dart';
import 'package:asset_portfolio/db/db.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:asset_portfolio/model/assetportfolio.dart';
import 'package:get/get.dart';
import 'package:asset_portfolio/const.dart';

class AutoAssetChart extends StatefulWidget {
  @override
  _AutoAssetChartState createState() => _AutoAssetChartState();
}

class _AutoAssetChartState extends State<AutoAssetChart> {
  List<charts.Series<AssetPortfolio, String>> _seriesPieData;
  bool loading = true;
  List<AssetPortfolio> mydata;
  DBHelper db = DBHelper();
  final assetController = Get.put(AssetController());

  _generateData(mydata) {
    _seriesPieData = List<charts.Series<AssetPortfolio, String>>();
    _seriesPieData = [];
    _seriesPieData.add(
      charts.Series(
        id: 'assetportfolios',
        domainFn: (AssetPortfolio portfolio, _) => portfolio.kind,
        measureFn: (AssetPortfolio portfolio, _) => portfolio.money,
        colorFn: (_, index) {
          if(index < colors.length)
            return colors[index];
          else{
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

    getAllAsset();
  }

  @override
  Widget build(BuildContext context) {
    _generateData(assetController.assets);
    return new charts.PieChart(_seriesPieData,
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
        ));
  }

  Future getAllAsset() async {
    assetController.assets = await db.getAllAssetPortfolio();
    setState(() {
      loading = false;
    });
  }
}
