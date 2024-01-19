import 'package:comprei/adapters/date.dart';
import 'package:comprei/adapters/entity.dart';
import 'package:comprei/adapters/number.dart';
import 'package:comprei/components/database.dart';
import 'package:comprei/models/product.dart';
import 'package:comprei/models/purchase.dart';
import 'package:comprei/models/purchase_summary.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:uuid/uuid.dart';

class PurchaseRepository {
  PurchaseRepository({required this.database});

  final Database database;

  Future<void> _updateProductFrequency(
      Transaction txn, PurchaseItem purchaseItem) async {
    final product = purchaseItem.product!;
    final purchases = (await txn.query(purchaseItemTableName,
            where: 'product_cod = ?', whereArgs: [product.id]))
        .map((p) => p['purchase_item_date_time'] as String)
        .map(DateTime.parse)
        .toList();

    final buyFrequency = purchases.toDaysDiff().perc95();

    await txn.update(productTableName, {'product_buy_frequency': buyFrequency},
        where: 'product_cod = ?', whereArgs: [product.id]);
  }

  Future<void> save(Purchase purchase) => database.transaction((txn) async {
        await txn.insert(merchantTableName, purchase.merchant.toMapEntity(),
            conflictAlgorithm: ConflictAlgorithm.replace);

        await txn.insert(purchaseTableName, purchase.toMapEntity());

        for (var purchaseItem in purchase.items) {
          final product = purchaseItem.product;
          final productBrand = product?.brand;

          if (productBrand != null) {
            await txn.insert(brandTableName, productBrand.toMapEntity(),
                conflictAlgorithm: ConflictAlgorithm.replace);
          }

          print("ID saving ${purchase.id.uuid}");

          if (product != null) {
            await txn.insert(productTableName, product.toMapEntity(),
                conflictAlgorithm: ConflictAlgorithm.replace);
          }

          await txn.insert(purchaseItemTableName, {
            ...purchaseItem.toMapEntity(),
            ...{
              'purchase_id': purchase.id.uuid,
              'purchase_item_date_time': purchase.date.toIso8601String(),
              'merchant_id': purchase.merchant.id,
            },
          });

          await _updateProductFrequency(txn, purchaseItem);
        }
      });

  Future<List<PurchaseSummary>> getAllPurchasesSummary() async {
    return await database
        .rawQuery('SELECT * FROM $purchaseTableName purchase'
            ' JOIN $merchantTableName merchant'
            ' ON merchant.merchant_id = purchase.merchant_id'
            ' ORDER BY purchase_date_time DESC')
        .then((rows) => rows
            .map((row) => PurchaseSummary(
                  id: UuidValue(row['purchase_id'] as String),
                  merchant: Merchant(
                    id: UuidValue(row['merchant_id'] as String),
                    taxId: row['merchant_tax_id'].toString(),
                    name: row['merchant_name'] as String,
                    nickName: row['merchant_nickname'] as String?,
                  ),
                  date: DateTime.parse(row['purchase_date_time'] as String),
                  discount: row['purchase_discount'] as int,
                ))
            .toList());
  }

  Future<Purchase> getPurchaseById(UuidValue purchaseId) async {
    print(purchaseId);
    return await database.rawQuery(
        'SELECT purchase.*, item.*, merchant.*, product.* FROM $purchaseItemTableName item'
        ' LEFT JOIN $purchaseTableName purchase  ON purchase.purchase_id = item.purchase_id'
        ' LEFT JOIN $merchantTableName merchant ON merchant.merchant_id = purchase.merchant_id'
        ' LEFT JOIN $productPurchaseItemTableName product_purchase_item ON item.purchase_item_cod = product_purchase_item.purchase_item_cod AND product_purchase_item.merchant_id = merchant.merchant_id'
        ' LEFT JOIN $productTableName product ON product.product_id = product_purchase_item.product_id'
        ' WHERE item.purchase_id = ? AND merchant.merchant_id is not null',
        [purchaseId.uuid]).then((rows) {
      final items = rows
          .map((itemRow) => PurchaseItem(
                cod: itemRow['purchase_item_cod'].toString(),
                value: itemRow['purchase_item_value'] as int,
                description: itemRow['purchase_item_description'].toString(),
                product: itemRow['product_id'] != null
                    ? Product(
                        id: UuidValue(itemRow['product_id'].toString()),
                        unitMeasure:
                            itemRow['purchase_item_unit_measure'] as String,
                        name: (itemRow['product_name'] ??
                                itemRow['purchase_item_description'])
                            .toString(),
                        nickName: itemRow['product_nickname'] as String?,
                        brand: itemRow['brand_id'] != null
                            ? Brand(
                                id: UuidValue(itemRow['brand_id'] as String),
                                name: itemRow['brand_name'] as String,
                                nickName: itemRow['brand_nickname'] as String?,
                              )
                            : null)
                    : null,
                unities: itemRow['purchase_item_unities'] as double,
                unitMeasure: itemRow['purchase_item_unit_measure'] as String,
                id: UuidValue(itemRow['purchase_item_id'] as String),
                discount: itemRow['purchase_item_discount'] as int,
              ))
          .toList();

      print(rows);

      return Purchase(
        id: UuidValue(rows.first['purchase_id'].toString()),
        merchant: Merchant(
          id: UuidValue(rows.first['merchant_id'].toString()),
          taxId: rows.first['merchant_tax_id'].toString(),
          name: rows.first['merchant_name'] as String,
          nickName: rows.first['merchant_nickname'] as String?,
        ),
        items: items,
        date: DateTime.parse(rows.first['purchase_date_time'] as String),
        discount: rows.first['purchase_discount'] as int,
        invoice: rows.first['purchase_invoice'].toString(),
      );
    });
  }
}
