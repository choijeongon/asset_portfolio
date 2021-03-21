import 'package:asset_portfolio/page/assetPortfolioPage.dart';
import 'package:asset_portfolio/page/assetRegistPage.dart';
import 'package:asset_portfolio/page/safetyChartPage.dart';
import 'package:asset_portfolio/page/stockPortfolioPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'asset_portfolio',
      theme: ThemeData(
        primaryColor: Color(0xFF2196F3),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _index = 0;
  var _pages = [
    AssetPortfolioPage(),
    StockPortfolioPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.bar_chart, color: Colors.white,), onPressed: (){
            Get.to(() => SafetyChartPage());
          }),
        ],
      ),
      body: _pages[_index],
      floatingActionButton: Container(
        height: 65,
        width: 65,
        child: FloatingActionButton(
          backgroundColor: Color(0xFF2196F3),
          child: Icon(Icons.add),
          onPressed: () {
            Get.to(() => AssetRegistPage());
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            label: "자산 포트폴리오",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "주식 포트폴리오",
            icon: Icon(Icons.show_chart),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
