import 'package:comprei/adapters/date.dart';
import 'package:comprei/adapters/number.dart';
import 'package:comprei/components/database.dart';
import 'package:comprei/models/purchase.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class PurchaseRepository {
  PurchaseRepository({required this.database});

  final Database database;

  Future<void> _updateProductFrequency(
      Transaction txn, PurchaseItem purchaseItem) async {
    final product = purchaseItem.product;
    final purchases = (await txn.query(purchaseItemTableName,
            where: 'product_cod = ?', whereArgs: [product.cod]))
        .map((p) => p['date_time'] as String)
        .map(DateTime.parse)
        .toList();

    final buyFrequency = purchases.toDaysDiff().perc95();

    await txn.update(productTableName, {'buy_frequency': buyFrequency},
        where: 'cod = ?', whereArgs: [product.cod]);
  }

  Future<void> save(Purchase purchase) => database.transaction((txn) async {
        await txn.insert(merchantTableName, purchase.merchant.toMapEntity(),
            conflictAlgorithm: ConflictAlgorithm.replace);

        await txn.insert(purchaseTableName, purchase.toMapEntity());

        for (var purchaseItem in purchase.items) {
          final product = purchaseItem.product;
          final productBrand = product.brand;

          if (productBrand != null) {
            await txn.insert(brandTableName, productBrand.toMapEntity(),
                conflictAlgorithm: ConflictAlgorithm.replace);
          }

          await txn.insert(productTableName, product.toMapEntity(),
              conflictAlgorithm: ConflictAlgorithm.replace);

          await txn.insert(purchaseItemTableName, {
            ...purchaseItem.toMapEntity(),
            ...{
              'purchase_id': purchase.id.v4(),
              'date_time': purchase.date.toIso8601String(),
              'merchant_id': purchase.merchant.id,
            },
          });

          await _updateProductFrequency(txn, purchaseItem);
        }
      });
}
