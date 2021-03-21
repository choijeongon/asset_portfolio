import 'package:asset_portfolio/model/assetportfolio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// ignore: non_constant_identifier_names
final String MainTableName = 'assetportfolio';

class DBHelper {
  var _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(
      // 데이터베이스 경로를 지정합니다. 참고: `path` 패키지의 `join` 함수를 사용하는 것이
      // 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법입니다.
      join(await getDatabasesPath(), 'assetportfolio.db'),
      // 데이터베이스가 처음 생성될 때, assetportfolio를 저장하기 위한 테이블을 생성합니다.
      onCreate: (db, version) => _createDb(db),
      // 버전을 설정하세요. onCreate 함수에서 수행되며 데이터베이스 업그레이드와 다운그레이드를
      // 수행하기 위한 경로를 제공합니다.
      version: 1,
    );
    return _db;
  }

  static void _createDb(Database db) {
    db.execute(
        "CREATE TABLE assetportfolio(kind TEXT PRIMARY KEY, asset TEXT, safety TEXT, percent REAL, money INTEGER)");
    db.execute("CREATE TABLE assetvalue(value TEXT PRIMARY KEY)");
  }

  Future<void> insertAssetPortfolio(AssetPortfolio assetPortfolio) async {
    final db = await database;

    // assetPortfolio를 올바른 테이블에 추가하세요. 또한
    // `conflictAlgorithm`을 명시할 것입니다. 본 예제에서는
    // 만약 동일한 assetPortfolio가 여러번 추가되면, 이전 데이터를 덮어쓸 것입니다.
    await db.insert(
      MainTableName,
      assetPortfolio.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<AssetPortfolio>> getAllAssetPortfolio() async {
    final db = await database;

    // 모든 AssetPortfolio를 얻기 위해 테이블에 질의합니다.
    final List<Map<String, dynamic>> maps = await db.query('assetportfolio');

    // List<Map<String, dynamic>를 List<AssetPortfolio>으로 변환합니다.
    return List.generate(maps.length, (i) {
      return AssetPortfolio(
        kind: maps[i]['kind'],
        asset: maps[i]['asset'],
        safety: maps[i]['safety'],
        percent: maps[i]['percent'],
        money: maps[i]['money'],
      );
    });
  }

  Future<dynamic> getAssetPortfolio(String kind) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = (await db
        .query('assetportfolio', where: 'kind = ?', whereArgs: [kind]));

    return maps.isNotEmpty ? maps.first['kind'] : null;
  }

  Future<dynamic> getSafetyAsset() async {
    final db = await database;

    var res = await db.rawQuery(
        'SELECT SUM(percent) safe FROM $MainTableName WHERE safety = "Safety.safety"');

    return res.isNotEmpty ? res.first['safe'] : null;
  }

    Future<dynamic> getUnSafetyAsset() async {
    final db = await database;

    var res = await db.rawQuery(
        'SELECT SUM(percent) unsafe FROM $MainTableName WHERE safety = "Safety.unsafety"');

    return res.isNotEmpty ? res.first['unsafe'] : null;
  }

  Future<List<AssetPortfolio>> getStocksPortfolio() async {
    final db = await database;

    // 모든 AssetPortfolio를 얻기 위해 테이블에 질의합니다.
    final List<Map<String, dynamic>> maps = await db.query(
      'assetportfolio',
      where: 'asset = "주식"',
    );

    // List<Map<String, dynamic>를 List<AssetPortfolio>으로 변환합니다.
    return List.generate(maps.length, (i) {
      return AssetPortfolio(
        kind: maps[i]['kind'],
        asset: maps[i]['asset'],
        safety: maps[i]['safety'],
        percent: maps[i]['percent'],
        money: maps[i]['money'],
      );
    });
  }

  Future<void> updateAssetPortfolio(AssetPortfolio assetPortfolio) async {
    final db = await database;

    // 주어진 assetPortfolio를 수정합니다.
    await db.update(
      MainTableName,
      assetPortfolio.toMap(),
      // assetPortfolio의 kind가 일치하는 지 확인합니다.
      where: "kind = ?",
      // assetPortfolio의 kind를 whereArg로 넘겨 SQL injection을 방지합니다.
      whereArgs: [assetPortfolio.kind],
    );
  }

  Future<void> deleteAssetPortfolio(String kind) async {
    final db = await database;

    // 데이터베이스에서 AssetPortfolio를 삭제합니다.
    await db.delete(
      MainTableName,
      // 특정 AssetPortfolio를 제거하기 위해 `where` 절을 사용하세요
      where: "kind = ?",
      // AssetPortfolio의 kind를 where의 인자로 넘겨 SQL injection을 방지합니다.
      whereArgs: [kind],
    );
  }
}
