import 'dart:io';

import 'package:comprei/adapters/html_document.dart';
import 'package:comprei/models/product.dart';
import 'package:comprei/models/purchase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/parser.dart' as html;

void main() {
  final htmlDocStr = File('test/resources/nfe.html').readAsStringSync();
  final googleImageshtmlDocStr =
      File('test/resources/google_search2.html').readAsStringSync();
  final htmlDoc = html.parse(htmlDocStr);

  group('Testing the nfe extractor', () {
    test('Extract to a Purchase correctly', () {
      final expectedItems = [
        PurchaseItem(
          value: 11,
          description: 'SACOLA VERDE SP 48X5',
          cod: '1469349',
          product: Product(
            name: 'SACOLA VERDE SP 48X5',
            unitMeasure: 'UN',
          ),
          unitMeasure: 'UN',
          unities: 2,
        ),
        PurchaseItem(
          value: 455,
          description: 'REGALIZ TUBO MORANGO',
          cod: '7630033',
          product: Product(
            name: 'REGALIZ TUBO MORANGO',
            unitMeasure: 'UN',
          ),
          unitMeasure: 'UN',
        ),
        PurchaseItem(
          description: 'LOMBO SUINO ATEN kg',
          value: 2690,
          cod: '191739',
          product: Product(
            name: 'LOMBO SUINO ATEN kg',
            unitMeasure: 'kg',
          ),
          unitMeasure: 'kg',
          unities: 0.292,
        ),
        PurchaseItem(
          value: 4629,
          description: 'C MOLE BOV BIFE kg',
          cod: '77224',
          product: Product(
            name: 'C MOLE BOV BIFE kg',
            unitMeasure: 'kg',
          ),
          unitMeasure: 'kg',
          unities: 0.5,
        ),
        PurchaseItem(
          value: 1190,
          description: 'OVO BCO MED C/ 20',
          cod: '1221285',
          product: Product(
            name: 'OVO BCO MED C/ 20',
            unitMeasure: 'UN',
          ),
          unitMeasure: 'UN',
        ),
        PurchaseItem(
          value: 819,
          description: 'FEIJAO CARIOCA PANTE',
          cod: '2155883',
          product: Product(
            name: 'FEIJAO CARIOCA PANTE',
            unitMeasure: 'UN',
          ),
          unitMeasure: 'UN',
        ),
      ];
      final expectedPurchase = Purchase(
        items: expectedItems,
        discount: 200,
        taxValue: 1620,
        merchant: Merchant(
          taxId: '47508411017555',
          name: 'CIA BRASILEIRA DE DISTRIBUICAO',
        ),
        date: DateTime.parse('2021-10-26T19:36:59-03:00'),
      );

      expect(
          htmlDoc.toPurchase(),
          predicate<Purchase>(
            (p0) =>
                p0.date == expectedPurchase.date &&
                p0.discount == expectedPurchase.discount &&
                p0.merchant.taxId == expectedPurchase.merchant.taxId &&
                p0.merchant.name == expectedPurchase.merchant.name &&
                expectedPurchase.items
                    .where(
                      (element) => p0.items
                          .where((item) =>
                              item.discount == element.discount &&
                              item.unitMeasure == element.unitMeasure &&
                              item.cod == element.cod &&
                              item.value == element.value &&
                              item.product?.name == element.product?.name &&
                              item.product?.unitMeasure ==
                                  element.product?.unitMeasure)
                          .isNotEmpty,
                    )
                    .isNotEmpty,
          ));
    });
  });

  group('Testing the google image extractor', () {
    test('Extract images correctly', () {
      final regex = RegExp('https?:/(?:/[^/]+)+\\.(?:jpg|gif|png)');

      final r = regex.allMatches(googleImageshtmlDocStr).map((m) => m.group(0));

      print(r);
    });
  });
}
