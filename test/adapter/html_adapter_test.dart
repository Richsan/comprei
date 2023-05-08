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
          product: const Product(
            cod: '1469349',
            description: 'SACOLA VERDE SP 48X5',
          ),
          unitMeasure: 'UN',
          unities: 2,
        ),
        PurchaseItem(
          value: 455,
          product: const Product(
            cod: '7630033',
            description: 'REGALIZ TUBO MORANGO',
          ),
          unitMeasure: 'UN',
        ),
        PurchaseItem(
          value: 2690,
          product: const Product(
            cod: '191739',
            description: 'LOMBO SUINO ATEN kg',
          ),
          unitMeasure: 'kg',
          unities: 0.292,
        ),
        PurchaseItem(
          value: 4629,
          product: const Product(
            cod: '77224',
            description: 'C MOLE BOV BIFE kg',
          ),
          unitMeasure: 'kg',
          unities: 0.5,
        ),
        PurchaseItem(
          value: 1190,
          product: const Product(
            cod: '1221285',
            description: 'OVO BCO MED C/ 20',
          ),
          unitMeasure: 'UN',
        ),
        PurchaseItem(
          value: 819,
          product: const Product(
            cod: '2155883',
            description: 'FEIJAO CARIOCA PANTE',
          ),
          unitMeasure: 'UN',
        ),
      ];
      final expectedPurchase = Purchase(
        items: expectedItems,
        discount: 200,
        taxValue: 1620,
        merchant: const Merchant(
          id: '47508411017555',
          name: 'CIA BRASILEIRA DE DISTRIBUICAO',
        ),
        date: DateTime.parse('2021-10-26T19:36:59-03:00'),
      );

      expect(htmlDoc.toPurchase(), expectedPurchase);
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
