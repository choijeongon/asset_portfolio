import 'package:asset_portfolio/controller/controller.dart';
import 'package:asset_portfolio/db/db.dart';
import 'package:asset_portfolio/main.dart';
import 'package:asset_portfolio/model/assetportfolio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum Safety { safety, unsafety }

class AssetRegistPage extends StatefulWidget {
  @override
  _AssetRegistPageState createState() => _AssetRegistPageState();
}

class _AssetRegistPageState extends State<AssetRegistPage> {
  Safety _safe = Safety.safety;
  bool loading = true;
  final assetController = Get.put(AssetController());
  DBHelper db = DBHelper();
  bool sort;
  List<AssetPortfolio> selectedAssets;

  String valueChoose;
  List listAssets = [
    "주식",
    "현금",
    "외화",
    "채권",
    "자동차",
    "부동산",
    "금",
    "ETF",
    "리츠",
    "청약",
    "기타"
  ];

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode kindFocusNode;
  FocusNode moneyFocusNode;

  TextEditingController kindTextController = TextEditingController();
  TextEditingController moneyTextController = TextEditingController();

  @override
  void dispose() {
    kindTextController.dispose();
    moneyTextController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    valueChoose = '주식';

    getAllAsset();
    sort = false;
    selectedAssets = [];
    kindFocusNode = FocusNode();
    moneyFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Get.offAll(() => Home());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('자산 관리'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columnSpacing: 15,
                        sortAscending: sort,
                        sortColumnIndex: 4,
                        columns: [
                          DataColumn(
                            label: Text('종류'),
                            numeric: false,
                          ),
                          DataColumn(label: Text('분류'), numeric: false),
                          DataColumn(label: Text('안전성'), numeric: false),
                          DataColumn(label: Text('금액'), numeric: true),
                          DataColumn(
                            label: Text('비중'),
                            numeric: true,
                            onSort: (columnIndex, ascending) {
                              setState(() {
                                sort = !sort;
                              });
                              onSortColum(columnIndex, ascending);
                            },
                          ),
                        ],
                        rows: assetController.assets
                            .map(
                              (asset) => DataRow(
                                  selected: selectedAssets.contains(asset),
                                  onSelectChanged: (b) {
                                    onSelectedRow(b, asset);
                                  },
                                  cells: <DataCell>[
                                    DataCell(
                                      Text(asset.kind),
                                    ),
                                    DataCell(
                                      Text(asset.asset),
                                    ),
                                    DataCell(
                                      Text(transferSafety(asset.safety)),
                                    ),
                                    DataCell(
                                      TextFormField(
                                        initialValue: '${asset.money}',
                                        keyboardType: TextInputType.number,
                                        onFieldSubmitted: (val) async {
                                          AssetPortfolio tmp = AssetPortfolio(
                                              kind: asset.kind,
                                              asset: asset.asset,
                                              safety: asset.safety,
                                              money: int.parse(val.trim()),
                                              percent: asset.percent);

                                          await db.updateAssetPortfolio(tmp);
                                          await updateAllAssets();
                                          getAllAsset();
                                        },
                                      ),
                                    ),
                                    DataCell(
                                      Text(asset.percent
                                              .toStringAsFixed(2)
                                              .toString() +
                                          '%'),
                                    ),
                                  ]),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20.0),
                        alignment: Alignment.centerRight,
                        child: RaisedButton(
                          child: Text(
                            '등록하기',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: EdgeInsets.all(20.0),
                          color: Colors.green[500],
                          onPressed: () {
                            _displayAssetInputDialog(context);
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(20.0),
                        alignment: Alignment.centerRight,
                        child: RaisedButton(
                          child: Text(
                            '삭제하기',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: EdgeInsets.all(20.0),
                          color: Colors.red[500],
                          onPressed: selectedAssets.isEmpty
                              ? null
                              : () {
                                  deleteSelected();
                                },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Container(
              //   padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey, width: 1),
              //     borderRadius: BorderRadius.circular(15),
              //   ),
              //   child: Column(
              //     children: [
              //       TextFormField(
              //         focusNode: kindFocusNode,
              //         controller: kindTextController,
              //         keyboardType: TextInputType.text,
              //         decoration: InputDecoration(
              //           hintText: "*종목을 입력하세요(ex:CMA, 삼성전자 등)",
              //           filled: true,
              //           fillColor: Colors.white,
              //           enabledBorder: new OutlineInputBorder(
              //             borderRadius: new BorderRadius.circular(25.0),
              //             borderSide: new BorderSide(
              //               color: Colors.grey,
              //             ),
              //           ),
              //           focusedBorder: new OutlineInputBorder(
              //               borderRadius: new BorderRadius.circular(25.0),
              //               borderSide: new BorderSide(
              //                 color: Colors.blue,
              //               )),
              //           border: OutlineInputBorder(
              //             borderRadius: new BorderRadius.circular(25.0),
              //             borderSide:
              //                 BorderSide(color: Colors.black, width: 1.0),
              //           ),
              //         ),
              //         validator: (value) {
              //           if (value.trim().isEmpty) {
              //             return '종류를 입력하세요';
              //           }
              //           return null;
              //         },
              //         autofocus: true,
              //         textInputAction: TextInputAction.next,
              //         onFieldSubmitted: (value) {
              //           _fieldFocusChange(_formKey.currentContext,
              //               kindFocusNode, moneyFocusNode);
              //         },
              //       ),
              //       SizedBox(
              //         height: 13.0,
              //       ),
              //       Container(
              //         padding: EdgeInsets.only(left: 16, right: 16),
              //         decoration: BoxDecoration(
              //           border: Border.all(color: Colors.grey, width: 1),
              //           borderRadius: BorderRadius.circular(15),
              //         ),
              //         child: DropdownButton(
              //           hint: Text('자산 분류를 선택하세요'),
              //           dropdownColor: Colors.white,
              //           icon: Icon(Icons.arrow_drop_down),
              //           iconSize: 36,
              //           isExpanded: true,
              //           underline: SizedBox(),
              //           style: TextStyle(color: Colors.black, fontSize: 20),
              //           value: valueChoose,
              //           items: listAssets.map((valueAsset) {
              //             return DropdownMenuItem(
              //               value: valueAsset,
              //               child: Text(valueAsset),
              //             );
              //           }).toList(),
              //           onChanged: (newValue) {
              //             setState(() {
              //               valueChoose = newValue;
              //             });
              //           },
              //         ),
              //       ),
              //       SizedBox(
              //         height: 13.0,
              //       ),
              //       Row(
              //         children: [
              //           Text(
              //             '안전 자산',
              //             style: TextStyle(fontSize: 18.0),
              //           ),
              //           Radio(
              //             value: Safety.safety,
              //             groupValue: _safe,
              //             onChanged: (value) {
              //               setState(() {
              //                 _safe = value;
              //               });
              //             },
              //           ),
              //           SizedBox(
              //             width: 15,
              //           ),
              //           Text(
              //             '위험 자산',
              //             style: TextStyle(fontSize: 18.0),
              //           ),
              //           Radio(
              //             value: Safety.unsafety,
              //             groupValue: _safe,
              //             onChanged: (value) {
              //               setState(() {
              //                 _safe = value;
              //               });
              //             },
              //           ),
              //         ],
              //       ),
              //       SizedBox(
              //         height: 13.0,
              //       ),
              //       TextFormField(
              //         focusNode: moneyFocusNode,
              //         controller: moneyTextController,
              //         keyboardType: TextInputType.number,
              //         decoration: InputDecoration(
              //           hintText: "*금액을 입력하세요 (ex: 35000)",
              //           filled: true,
              //           fillColor: Colors.white,
              //           enabledBorder: new OutlineInputBorder(
              //             borderRadius: new BorderRadius.circular(25.0),
              //             borderSide: new BorderSide(
              //               color: Colors.grey,
              //             ),
              //           ),
              //           focusedBorder: new OutlineInputBorder(
              //               borderRadius: new BorderRadius.circular(25.0),
              //               borderSide: new BorderSide(
              //                 color: Colors.blue,
              //               )),
              //           border: OutlineInputBorder(
              //             borderRadius: new BorderRadius.circular(25.0),
              //             borderSide:
              //                 BorderSide(color: Colors.black, width: 1.0),
              //           ),
              //         ),
              //         validator: (value) {
              //           if (value.trim().isEmpty) {
              //             return '금액을 입력하세요';
              //           }
              //           return null;
              //         },
              //         autofocus: true,
              //         textInputAction: TextInputAction.done,
              //         onFieldSubmitted: (value) {
              //           moneyFocusNode.unfocus();
              //         },
              //       ),
              //       Container(
              //         margin: const EdgeInsets.all(16.0),
              //         alignment: Alignment.centerRight,
              //         child: RaisedButton(
              //           textColor: Colors.white,
              //           padding: EdgeInsets.all(0.0),
              //           shape: StadiumBorder(),
              //           child: Container(
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(25.0),
              //               gradient: LinearGradient(
              //                 colors: [
              //                   Color(0xFF00b09b),
              //                   Color(0xFF96c93d),
              //                 ],
              //               ),
              //             ),
              //             child: Text('등록하기'),
              //             padding: EdgeInsets.symmetric(
              //                 horizontal: 70.0, vertical: 15.0),
              //           ),
              //           onPressed: () async {
              //             if (_formKey.currentState.validate()) {
              //               if (int.parse(moneyTextController.text.trim()) <
              //                   0) {
              //                 showDialog(
              //                     context: context,
              //                     barrierDismissible: false,
              //                     builder: (BuildContext context) {
              //                       return AlertDialog(
              //                         title: Text('음수값 입력'),
              //                         content: SingleChildScrollView(
              //                           child: ListBody(
              //                             children: [
              //                               Text('음수 값은 입력할 수 없습니다.')
              //                             ],
              //                           ),
              //                         ),
              //                         actions: [
              //                           FlatButton(
              //                               onPressed: () {
              //                                 Navigator.of(context).pop();
              //                               },
              //                               child: Text('취소'))
              //                         ],
              //                       );
              //                     });
              //                 return null;
              //               }

              //               var data = AssetPortfolio(
              //                 kind: kindTextController.text.trim(),
              //                 asset: valueChoose,
              //                 safety: _safe.toString(),
              //                 money:
              //                     int.parse(moneyTextController.text.trim()),
              //               );

              //               await db.insertAssetPortfolio(data);
              //               textFormFieldClear();
              //               await updateAllAssets();
              //               getAllAsset();
              //             }
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _displayAssetInputDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text('자산 입력'),
              insetPadding: EdgeInsets.symmetric(horizontal: 10),
              content: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        focusNode: kindFocusNode,
                        controller: kindTextController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "*종목을 입력하세요",
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(
                                color: Colors.blue,
                              )),
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                        ),
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return '종류를 입력하세요';
                          }
                          return null;
                        },
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          _fieldFocusChange(_formKey.currentContext,
                              kindFocusNode, moneyFocusNode);
                        },
                      ),
                      SizedBox(
                        height: 13.0,
                      ),
                      TextFormField(
                        focusNode: moneyFocusNode,
                        controller: moneyTextController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "*금액을 입력하세요",
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(
                                color: Colors.blue,
                              )),
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                        ),
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return '금액을 입력하세요';
                          }
                          return null;
                        },
                        autofocus: true,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {
                          moneyFocusNode.unfocus();
                        },
                      ),
                      SizedBox(
                        height: 13.0,
                      ),
                      Container(
                        padding: EdgeInsets.all(0.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: DropdownButton(
                          hint: Text('자산 분류를 선택하세요'),
                          dropdownColor: Colors.white,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 36,
                          isExpanded: true,
                          underline: SizedBox(),
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          value: valueChoose,
                          items: listAssets.map((valueAsset) {
                            return DropdownMenuItem(
                              value: valueAsset,
                              child: Text(valueAsset),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              valueChoose = newValue;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 13.0,
                      ),
                      Row(
                        children: [
                          Text(
                            '안전 자산',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Radio(
                            value: Safety.safety,
                            groupValue: _safe,
                            onChanged: (value) {
                              setState(() {
                                _safe = value;
                              });
                            },
                          ),
                          Text(
                            '위험 자산',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Radio(
                            value: Safety.unsafety,
                            groupValue: _safe,
                            onChanged: (value) {
                              setState(() {
                                _safe = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.all(5.0),
                  alignment: Alignment.centerRight,
                  child: RaisedButton(
                    textColor: Colors.white,
                    padding: EdgeInsets.all(0.0),
                    shape: StadiumBorder(),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF00b09b),
                            Color(0xFF96c93d),
                          ],
                        ),
                      ),
                      child: Text('등록하기'),
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 15.0),
                    ),
                    onPressed: () async {
                      var pkcheck = await db
                          .getAssetPortfolio(kindTextController.text.trim());

                      if (_formKey.currentState.validate()) {
                        if (pkcheck != null) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('등록된 종목'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [Text('이미 등록된 종목입니다.')],
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('취소'))
                                  ],
                                );
                              });
                          return null;
                        }
                        if (int.parse(moneyTextController.text.trim()) < 0) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('음수값 입력'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: [Text('음수 값은 입력할 수 없습니다.')],
                                    ),
                                  ),
                                  actions: [
                                    FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('취소'))
                                  ],
                                );
                              });
                          return null;
                        }

                        var data = AssetPortfolio(
                          kind: kindTextController.text.trim(),
                          asset: valueChoose,
                          safety: _safe.toString(),
                          money: int.parse(moneyTextController.text.trim()),
                        );

                        await db.insertAssetPortfolio(data);
                        await updateAllAssets();
                        getAllAsset();
                        textFormFieldClear();
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            );
          });
        });
  }

  Future getAllAsset() async {
    assetController.assets = await db.getAllAssetPortfolio();
    setState(() {
      loading = false;
    });
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 4) {
      if (ascending) {
        assetController.assets.sort((a, b) => a.percent.compareTo(b.percent));
      } else {
        assetController.assets.sort((a, b) => b.percent.compareTo(a.percent));
      }
    }
  }

  onSelectedRow(bool selected, AssetPortfolio asset) async {
    setState(() {
      if (selected) {
        selectedAssets.add(asset);
      } else {
        selectedAssets.remove(asset);
      }
    });
  }

  deleteSelected() async {
    setState(() {
      if (selectedAssets.isNotEmpty) {
        List<AssetPortfolio> temp = [];
        temp.addAll(selectedAssets);
        for (AssetPortfolio asset in temp) {
          db.deleteAssetPortfolio(asset.kind);
          selectedAssets.remove(asset);
        }
      }
    });

    getAllAsset();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void textFormFieldClear() {
    kindTextController.clear();
    moneyTextController.clear();
    valueChoose = '주식';

    _safe = Safety.safety;
  }

  String transferSafety(String safety) {
    if (safety == 'Safety.safety') {
      return '안전';
    } else if (safety == 'Safety.unsafety') {
      return '위험';
    } else {
      return '';
    }
  }

  Future<void> updateAllAssets() async {
    assetController.assets = await db.getAllAssetPortfolio();

    int allMoney = 0;

    for (AssetPortfolio asset in assetController.assets) {
      allMoney += asset.money;
    }

    for (AssetPortfolio asset in assetController.assets) {
      double percent = (asset.money / allMoney) * 100;
      var temp = AssetPortfolio(
          kind: asset.kind,
          asset: asset.asset,
          safety: asset.safety,
          percent: percent,
          money: asset.money);

      await db.updateAssetPortfolio(temp);
    }
  }
}
