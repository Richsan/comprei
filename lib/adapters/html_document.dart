import 'package:html/dom.dart';
import 'package:comprei/models/product.dart';
import 'package:comprei/models/purchase.dart';
import 'string.dart';

extension HtmlDocumentAdapter on Document {
  Purchase toPurchase() {
    final content = getElementById('conteudo');
    final totalSection = getElementById('totalNota');
    final infoSection = getElementById('infos');
    final emissionMoment = infoSection
            ?.getElementsByTagName('li')
            .first
            .text
            .split('\n')
            .where((element) => element.contains('Emissão:'))
            .single
            .split('Emissão:')[1]
            .trim()
            .split(' ')
            .reduce((dateStr, time) {
          final dateSplitted = dateStr.split('/');

          return '${dateSplitted[2]}-${dateSplitted[1]}-${dateSplitted[0]}T${time}-03:00';
        }) ??
        DateTime.now().toIso8601String();

    final discount = totalSection
            ?.getElementsByTagName('div')
            .where((element) => element.innerHtml.contains('Descontos'))
            .single
            .innerHtml
            .asMoney() ??
        0;
    final taxes = totalSection
            ?.getElementsByClassName('totalNumb txtObs')
            .single
            .innerHtml
            .onlyNumbers() ??
        "0";
    final header = content?.getElementsByClassName('txtCenter').single;
    final merchantName = header?.children.first.innerHtml;
    final merchantId = header?.children[1].innerHtml.onlyNumbers();

    final tabResultRows =
        getElementById('tabResult')?.getElementsByTagName('tr');

    final items = tabResultRows?.map((e) {
          final productDescription =
              e.getElementsByClassName('txtTit').first.innerHtml;
          final productCod =
              e.getElementsByClassName('RCod').first.innerHtml.onlyNumbers();
          final productUnit = e
              .getElementsByClassName('RUN')
              .single
              .innerHtml
              .split('</strong>')[1]
              .trim();
          final productValue =
              e.getElementsByClassName('RvlUnit').single.innerHtml.asMoney();
          final productUnities = e
              .getElementsByClassName('Rqtd')
              .single
              .innerHtml
              .split('</strong>')[1]
              .trim()
              .replaceAll(',', '.');

          return PurchaseItem(
            value: productValue,
            product: Product(
              cod: productCod,
              description: productDescription,
            ),
            unities: double.parse(productUnities),
            unitMeasure: productUnit,
          );
        }).toList() ??
        [];

    return Purchase(
        items: items,
        merchant: Merchant(
          id: merchantId ?? "unkown",
          name: merchantName ?? "unknown",
        ),
        taxValue: int.parse(taxes),
        date: DateTime.parse(emissionMoment),
        discount: discount);
  }
}
