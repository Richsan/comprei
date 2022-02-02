import 'package:flutter_test/flutter_test.dart';
import 'package:comprei/adapters/html_document.dart';
import 'package:html/parser.dart' as html;
import 'package:comprei/models/product.dart';

import 'dart:io';

import 'package:comprei/models/purchase.dart';

void main() {
  final htmlDocStr = File('test/resources/nfe.html').readAsStringSync();
  final htmlDoc = html.parse(htmlDocStr);

  group('Testing the nfe extractor', () {
    test('Extracto to a Purchase correctly', () {
      final expectedItems = [
        const PurchaseItem(
          value: 11,
          product: Product(
            cod: '1469349',
            description: 'SACOLA VERDE SP 48X5',
          ),
          unitMeasure: 'UN',
          unities: 2,
        ),
        const PurchaseItem(
          value: 455,
          product: Product(
            cod: '7630033',
            description: 'REGALIZ TUBO MORANGO',
          ),
          unitMeasure: 'UN',
        ),
        const PurchaseItem(
          value: 2690,
          product: Product(
            cod: '191739',
            description: 'LOMBO SUINO ATEN kg',
          ),
          unitMeasure: 'kg',
          unities: 0.292,
        ),
        const PurchaseItem(
          value: 4629,
          product: Product(
            cod: '77224',
            description: 'C MOLE BOV BIFE kg',
          ),
          unitMeasure: 'kg',
          unities: 0.5,
        ),
        const PurchaseItem(
          value: 1190,
          product: Product(
            cod: '1221285',
            description: 'OVO BCO MED C/ 20',
          ),
          unitMeasure: 'UN',
        ),
        const PurchaseItem(
          value: 819,
          product: Product(
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
}
