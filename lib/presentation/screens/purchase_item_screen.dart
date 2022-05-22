import 'package:comprei/adapters/number.dart';
import 'package:comprei/models/purchase.dart';
import 'package:comprei/widgets/outputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PurchaseItemScreen extends StatelessWidget {
  const PurchaseItemScreen({
    Key? key,
    required this.purchase,
  }) : super(key: key);
  final PurchaseItem purchase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.5),
      body: buildScreen(context, purchase),
    );
  }

  Widget buildScreen(BuildContext context, PurchaseItem purchase) {
    final product = purchase.product;
    const textStyle = TextStyle(fontSize: 20);
    return FullScreenCard(
      title: product.description,
      buttonName: AppLocalizations.of(context)!.saveButton,
      buttonOnPressed: () => Navigator.of(context).pop(purchase),
      children: [
        SizedBox(
          height: 150.0,
          child: Ink.image(
            image: const NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzIwwiBHtWLYReI0Ww8u7Ex_1rJpEN_o5C9Q&usqp=CAU'),
            fit: BoxFit.scaleDown,
          ),
        ),
        TextKeyValue(
          keyName: 'Codigo',
          value: product.cod,
        ),
        TextKeyValue(
          keyName: 'Marca',
          value: product.brand?.name ?? '',
        ),
        TextKeyValue(
          keyName: 'Valor por ${purchase.unitMeasure}',
          value: purchase.value.asCurrency(),
        ),
        TextKeyValue(
          keyName: 'Quantidade',
          value: '${purchase.unities} ${purchase.unitMeasure}',
        ),
        TextKeyValue(
          keyName: 'Desconto',
          value: purchase.discount.asCurrency(),
        ),
        TextKeyValue(
          keyName: 'Valor Total',
          value: purchase.totalValue.asCurrency(),
        ),
      ],
    );
  }
}
