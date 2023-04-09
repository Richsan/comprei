import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:sqflite_sqlcipher/sqlite_api.dart';

const String merchantTableName = 'merchant';
const String brandTableName = "brand";
const String productTableName = "product";
const String purchaseItemTableName = "purchase_item";
const String purchaseTableName = "purchase";
const String purchasePurchaseItemsTableName = "purchase_purchase_items";

Future<Database> getDatabase(
    String user, String databasePath, String password) async {
  final databaseFileName =
      user.replaceAll('/', '_').replaceAll('.db', '') + '.db';

  final path = join(databasePath, databaseFileName);

  print('user=$user | path=$path | filename=$databaseFileName');

  return await openDatabase(
    path,
    password: password,
    singleInstance: false,
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE $merchantTableName(id TEXT PRIMARY KEY,'
        ' name TEXT NOT NULL,'
        ' nickname TEXT)',
      );

      await db.execute(
        'CREATE TABLE $brandTableName(id TEXT PRIMARY KEY,'
        ' name TEXT NOT NULL,'
        ' nickname TEXT)',
      );

      await db.execute(
        'CREATE TABLE $productTableName(cod TEXT PRIMARY KEY, '
        ' description TEXT NOT NULL,'
        ' brand_id TEXT,'
        ' nickname TEXT,'
        ' buy_frequency INTEGER,'
        ' FOREIGN KEY(brand_id) REFERENCES $brandTableName(id))',
      );

      await db.execute(
        'CREATE TABLE $purchaseTableName('
        ' id TEXT PRIMARY KEY,'
        ' invoice TEXT UNIQUE,'
        ' merchant_id TEXT NOT NULL,'
        ' tax_value INTEGER NOT NULL,'
        ' discount INTEGER NOT NULL,'
        ' date_time TEXT NOT NULL,'
        ' FOREIGN KEY(merchant_id) REFERENCES $merchantTableName(id))',
      );

      await db.execute(
        'CREATE TABLE $purchaseItemTableName('
        ' id TEXT PRIMARY KEY,'
        ' product_cod TEXT NOT NULL,'
        ' value INTEGER NOT NULL,'
        ' discount INTEGER NOT NULL,'
        ' unities INTEGER NOT NULL,'
        ' unit_measure VARCHAR(10) NOT NULL,'
        ' date_time TEXT NOT NULL,'
        ' merchant_id TEXT NOT NULL,'
        ' purchase_id TEXT NOT NULL,'
        ' FOREIGN KEY(product_cod) REFERENCES $productTableName(cod),'
        ' FOREIGN KEY(purchase_id) REFERENCES $purchaseTableName(id),'
        ' FOREIGN KEY(merchant_id) REFERENCES $merchantTableName(id))',
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
