import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';
import 'package:path/path.dart';

Future<Database> getDatabase(
    String user, String databasePath, String password) async {
  final databaseFileName =
      user.replaceAll('/', '_').replaceAll('.db', '') + '.db';

  final path = join(databasePath, databaseFileName);

  return await openDatabase(
    path,
    password: password,
    singleInstance: false,
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE merchant(id TEXT PRIMARY KEY,'
        ' name TEXT NOT NULL,'
        ' nickname TEXT)',
      );

      await db.execute(
        'CREATE TABLE brand(id INTEGER PRIMARY KEY AUTOINCREMENT,'
        ' name TEXT NOT NULL,'
        ' nickname TEXT)',
      );

      await db.execute(
        'CREATE TABLE product(cod TEXT PRIMARY KEY, '
        'description TEXT NOT NULL,'
        ' brandid INTEGER NOT NULL,'
        ' FOREIGN KEY(brandid) REFERENCES brand(id))',
      );

      await db.execute(
        'CREATE TABLE purchase_item('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        ' productcod TEXT NOT NULL,'
        ' value INTEGER NOT NULL,'
        ' discount INTEGER NOT NULL,'
        ' unities INTEGER NOT NULL,'
        ' unitmeasure VARCHAR(10) NOT NULL,'
        ' FOREIGN KEY(productcod) REFERENCES product(cod))',
      );

      await db.execute(
        'CREATE TABLE purchase('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        ' merchantid TEXT NOT NULL,'
        ' taxvalue INTEGER NOT NULL,'
        ' discount INTEGER NOT NULL,'
        ' datetime TEXT NOT NULL,'
        ' FOREIGN KEY(merchantid) REFERENCES merchant(id))',
      );

      await db.execute(
        'CREATE TABLE purchase_purchase_items('
        ' purchaseid INTEGER NOT NULL,'
        ' purchaseitemid INTEGER NOT NULL,'
        ' FOREIGN KEY(purchaseid) REFERENCES purchase(id),'
        ' FOREIGN KEY(purchaseitemid) REFERENCES purchase_item(id),'
        ' PRIMARY KEY (purchaseid, purchaseitemid))',
      );
    },
    version: 1,
  );
}

Future<Database> getUsersDatabase() async {
  final databasePath = await getDatabasesPath();

  final path = join(databasePath, 'users.db');

  return await openDatabase(
    path,
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NOT NULL, databasepath TEXT NOT NULL)',
      );
    },
    version: 1,
  );
}
