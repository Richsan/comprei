import 'package:comprei/adapters/number.dart';
import 'package:comprei/models/purchase.dart';
import 'package:comprei/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:comprei/presentation/bloc/purchase_fetch/purchase_fetch_bloc.dart';
import 'package:comprei/presentation/screens/purchase_item_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

import '../../widgets/outputs.dart';

Widget _header(BuildContext context, Purchase purchase) {
  final merchant = purchase.merchant;

  return Column(
    children: [
      BoldText(text: merchant.name),
      TextKeyValue(
        keyName: AppLocalizations.of(context)!.merchantID,
        value: merchant.id.uuid,
      ),
      TextKeyValue(
        keyName: AppLocalizations.of(context)!.date,
        value: '${purchase.date}',
      ),
    ],
  );
}

Widget _summaryFooter(BuildContext context, Purchase purchase) {
  return Align(
    alignment: Alignment.center,
    child: Column(
      children: [
        TextKeyValue(
          keyName: AppLocalizations.of(context)!.tax,
          value: purchase.taxValue.asCurrency(),
        ),
        TextKeyValue(
          keyName: AppLocalizations.of(context)!.discount,
          value: purchase.discount.asCurrency(),
        ),
        TextKeyValue(
          keyName: AppLocalizations.of(context)!.total,
          value: purchase.totalValue.asCurrency(),
        ),
      ],
    ),
  );
}

Widget buildPurchaseScreen(
  BuildContext context, {
  required Purchase purchase,
  Function(PurchaseItem)? onEditItem,
}) {
  final items = purchase.items;
  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        const SizedBox(height: 25.0),
        _header(context, purchase),
        const Divider(),
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 35.0,
            maxHeight: 380.0,
          ),
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final product = items[index].product;
                final item = items[index];

                return CardInfo(
                  onTap: () async {
                    final purchaseItem = await Navigator.of(context).push(
                      PageRouteBuilder(
                          opaque: false, // set to false
                          pageBuilder: (_, __, ___) => PurchaseItemScreen(
                                purchase: item,
                                editable: onEditItem != null,
                              )),
                    );

                    if (onEditItem != null) {
                      await onEditItem(purchaseItem);
                    }
                  },
                  heading:
                      product?.nickName ?? product?.name ?? item.description,
                  subHeading: product?.id.uuid,
                  supportingText:
                      '${item.value.asCurrency()} x ${item.unities} = ${item.totalValue.asCurrency()}',
                );
              }),
        ),
        const Divider(),
        _summaryFooter(context, purchase),
      ]),
    ),
  );
}

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({
    Key? key,
    required this.purchaseId,
    this.onEditItem,
  }) : super(key: key);

  final UuidValue purchaseId;

  final Function(PurchaseItem)? onEditItem;

  @override
  Widget build(BuildContext context) {
    final Logged session =
        BlocProvider.of<AuthenticationBloc>(context).state as Logged;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(AppLocalizations.of(context)!.insertPurchaseScreenTitle),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => PurchaseFetchBloc(
          purchaseRepository: session.purchaseRepository,
          purchaseId: purchaseId,
        ),
        child: BlocBuilder<PurchaseFetchBloc, PurchaseFetchState>(
          builder: (context, state) {
            if (state is LoadedPurchaseFetchState) {
              return buildPurchaseScreen(
                context,
                purchase: state.purchase,
                onEditItem: onEditItem,
              );
            }

            return const LoadingWidget();
          },
        ),
      ),
    );
  }
}
