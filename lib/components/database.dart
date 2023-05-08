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
        'CREATE TABLE $merchantTableName(merchant_id TEXT PRIMARY KEY,'
        ' merchant_name TEXT NOT NULL,'
        ' merchant_nickname TEXT)',
      );

      await db.execute(
        'CREATE TABLE $brandTableName(brand_id TEXT PRIMARY KEY,'
        ' brand_name TEXT NOT NULL,'
        ' brand_nickname TEXT)',
      );

      await db.execute(
        'CREATE TABLE $productTableName(product_cod TEXT PRIMARY KEY, '
        ' product_description TEXT NOT NULL,'
        ' brand_id TEXT,'
        ' product_nickname TEXT,'
        ' product_buy_frequency INTEGER,'
        ' FOREIGN KEY(brand_id) REFERENCES $brandTableName(brand_id))',
      );

      await db.execute(
        'CREATE TABLE $purchaseTableName('
        ' purchase_id TEXT PRIMARY KEY,'
        ' purchase_invoice TEXT UNIQUE,'
        ' merchant_id TEXT NOT NULL,'
        ' purchase_tax_value INTEGER NOT NULL,'
        ' purchase_discount INTEGER NOT NULL,'
        ' purchase_date_time TEXT NOT NULL,'
        ' FOREIGN KEY(merchant_id) REFERENCES $merchantTableName(merchant_id))',
      );

      await db.execute(
        'CREATE TABLE $purchaseItemTableName('
        ' purchase_item_id TEXT PRIMARY KEY,'
        ' product_cod TEXT NOT NULL,'
        ' purchase_item_value INTEGER NOT NULL,'
        ' purchase_item_discount INTEGER NOT NULL,'
        ' purchase_item_unities REAL NOT NULL,'
        ' purchase_item_unit_measure VARCHAR(10) NOT NULL,'
        ' purchase_item_date_time TEXT NOT NULL,'
        ' merchant_id TEXT NOT NULL,'
        ' purchase_id TEXT NOT NULL,'
        ' FOREIGN KEY(product_cod) REFERENCES $productTableName(product_cod),'
        ' FOREIGN KEY(purchase_id) REFERENCES $purchaseTableName(purchase_id),'
        ' FOREIGN KEY(merchant_id) REFERENCES $merchantTableName(merchant_id))',
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
