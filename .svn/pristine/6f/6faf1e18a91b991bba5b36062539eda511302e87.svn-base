import 'package:flutter/material.dart';
import 'package:asset_portfolio/db/db.dart';
import 'package:charts_flutter/flutter.dart' as charts;

enum Safety { safety, unsafety }

class AutoSafetyChart extends StatefulWidget {
  @override
  _AutoSafetyChartState createState() => _AutoSafetyChartState();
}

class _AutoSafetyChartState extends State<AutoSafetyChart> {
  List<charts.Series<Safe, String>> seriesList;
  List<Safe> mydata;
  bool loading = true;
  DBHelper db = DBHelper();
  double safetySum = 0.0;
  double unsafetySum = 0.0;

  @override
  void initState() {
    super.initState();
    getAllSafety();
  }

  _generateData(mydata) {
    seriesList = List<charts.Series<Safe, String>>();
    seriesList =[];
    seriesList.add(
      charts.Series(
        id: 'assetportfolios',
        domainFn: (Safe safe, _) => safe.safeValue,
        measureFn: (Safe safe, _) => safe.percent,
        colorFn: (Safe safe, _) => charts.ColorUtil.fromDartColor(Color(int.parse(safe.colorVal))),
        data: mydata,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Safe> data = [
      new Safe("안전 자산", safetySum, "0xff109618"),
      new Safe("위험 자산", unsafetySum, "0xffE33335"),
    ];

    _generateData(data);

    return Container(
      padding: EdgeInsets.all(20.0),
      child: new charts.BarChart(
        seriesList,
        animate: false,
      ),
    );
  }

  Future getAllSafety() async {
    safetySum = await db.getSafetyAsset();
    unsafetySum = await db.getUnSafetyAsset();

    setState(() {
      loading = false;
    });
  }
}

class Safe {
  String safeValue;
  double percent;
  String colorVal;

  Safe(this.safeValue, this.percent, this.colorVal);
}
