import 'package:path/path.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

const String merchantTableName = 'merchant';
const String brandTableName = "brand";
const String productTableName = "product";
const String categoryTableName = "category";
const String categoryProductTableName = "category_product";
const String purchaseItemTableName = "purchase_item";
const String purchaseTableName = "purchase";
const String productPurchaseItemTableName = "product_purchase_item";

Future<Database> getDatabase(
    String user, String databasePath, String password) async {
  print('user=$user | path=$databasePath');

  return await openDatabase(
    databasePath,
    singleInstance: false,
    /*onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE $merchantTableName('
        ' merchant_id TEXT PRIMARY KEY,'
        ' merchant_tax_id string UNIQUE NOT NULL,'
        ' merchant_name TEXT NOT NULL,'
        ' merchant_nickname TEXT)',
      );

      await db.execute(
        'CREATE TABLE $brandTableName('
        ' brand_id TEXT PRIMARY KEY,'
        ' brand_name TEXT NOT NULL,'
        ' brand_nickname TEXT)',
      );

      await db.execute(
        'CREATE TABLE $purchaseTableName('
        ' purchase_id TEXT PRIMARY KEY,'
        ' purchase_invoice_ref TEXT NOT NULL UNIQUE,'
        ' merchant_id TEXT NOT NULL,'
        ' purchase_tax_value INTEGER NOT NULL,'
        ' purchase_discount INTEGER NOT NULL,'
        ' purchase_date_time TEXT NOT NULL,'
        ' FOREIGN KEY(merchant_id) REFERENCES $merchantTableName(merchant_id))',
      );

      await db.execute('CREATE TABLE $categoryTableName('
          ' category_id TEXT PRIMARY KEY,'
          ' category_name TEXT)');

      await db.execute(
        'CREATE TABLE $productTableName('
        ' product_id TEXT PRIMARY KEY, '
        ' product_name TEXT NOT NULL,'
        ' product_barcode TEXT,'
        ' brand_id TEXT,'
        ' labels TEXT,'
        ' product_image_url TEXT,'
        ' product_unit_measure VARCHAR(10),'
        ' last_bought_at TEXT,'
        ' last_paid_price INTEGER,'
        ' avg_paid_price INTEGER,'
        ' perc95_paid_price INTEGER,'
        ' min_paid_price INTEGER,'
        ' max_paid_price INTEGER,'
        ' FOREIGN KEY(brand_id) REFERENCES brand(brand_id))',
      );

      await db.execute('CREATE TABLE $categoryProductTableName('
          ' category_id TEXT,'
          ' product_id TEXT,'
          ' PRIMARY KEY (category_id, product_id),'
          ' FOREIGN KEY(product_id) REFERENCES product(product_id),'
          ' FOREIGN KEY(category_id) REFERENCES category(category_id))');

      await db.execute(
        'CREATE TABLE $purchaseItemTableName('
        ' purchase_item_id TEXT PRIMARY KEY,'
        ' purchase_item_cod TEXT NOT NULL,'
        ' purchase_item_description TEXT NOT NULL,'
        ' purchase_item_value INTEGER NOT NULL,'
        ' purchase_item_discount INTEGER NOT NULL,'
        ' purchase_item_unities REAL NOT NULL,'
        ' purchase_item_unit_measure VARCHAR(10) NOT NULL,'
        ' purchase_item_date_time TEXT NOT NULL,'
        ' merchant_id TEXT NOT NULL,'
        ' purchase_id TEXT NOT NULL,'
        ' FOREIGN KEY(merchant_id) REFERENCES $merchantTableName(merchant_id),'
        ' FOREIGN KEY(purchase_id) REFERENCES $purchaseTableName(purchase_id))',
      );

      await db.execute(
        'CREATE TABLE $productPurchaseItemTableName('
        ' product_id TEXT NOT NULL,'
        ' purchase_item_cod TEXT NOT NULL,'
        ' merchant_id TEXT NOT NULL,'
        ' PRIMARY KEY (product_id, purchase_item_cod, merchant_id),'
        ' FOREIGN KEY(product_id) REFERENCES product(product_id),'
        ' FOREIGN KEY(merchant_id) REFERENCES merchant(merchant_id),'
        ' FOREIGN KEY(purchase_item_cod) REFERENCES purchase_item(purchase_item_cod)',
      );
    },*/
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
