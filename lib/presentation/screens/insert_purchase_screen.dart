import 'package:comprei/adapters/number.dart';
import 'package:comprei/models/purchase.dart';
import 'package:comprei/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:comprei/presentation/bloc/purchase_insertion/purchase_insertion_bloc.dart';
import 'package:comprei/presentation/screens/purchase_item_screen.dart';
import 'package:comprei/widgets/inputs.dart';
import 'package:comprei/widgets/outputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//TODO: we're gonna need split the view of a purchase from the edition of a purchase
class InsertPurchaseScreen extends StatelessWidget {
  const InsertPurchaseScreen({
    Key? key,
    required this.purchase,
  }) : super(key: key);

  final Purchase purchase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PurchaseInsertionBloc(purchase),
      child: BlocBuilder<PurchaseInsertionBloc, PurchaseInsertionState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title:
                Text(AppLocalizations.of(context)!.insertPurchaseScreenTitle),
            centerTitle: true,
          ),
          body: buildScreen(context, state),
        ),
      ),
    );
  }

  Widget buildScreen(BuildContext context, PurchaseInsertionState state) {
    if (state is NewPurchaseState || state is SavingPurchaseState) {
      return purchaseScreen(context, state);
    }

    if (state is SavedPurchaseState) {
      return insertedPurchaseScreen(context);
    }

    return errorScreen(context);
  }

  //TODO: maybe transform this in a class?
  Widget purchaseScreen(BuildContext context, PurchaseInsertionState state) {
    final Logged session =
        BlocProvider.of<AuthenticationBloc>(context).state as Logged;

    final items = state.purchase.items;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          const SizedBox(height: 25.0),
          header(context, state),
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
                            pageBuilder: (_, __, ___) =>
                                PurchaseItemScreen(purchase: item)),
                      );

                      BlocProvider.of<PurchaseInsertionBloc>(context).add(
                        UpdatePurchaseItem(
                          purchase: state.purchase,
                          purchaseItem: purchaseItem,
                        ),
                      );
                    },
                    heading: product.nickName ?? product.name,
                    subHeading: product.id.uuid,
                    supportingText:
                        '${item.value.asCurrency()} x ${item.unities} = ${item.totalValue.asCurrency()}',
                  );
                }),
          ),
          const Divider(),
          summaryFooter(context, state),
          const Divider(),
          Align(
            alignment: Alignment.bottomCenter,
            child: ActionButton(
              enabled: state is! SavingPurchaseState,
              isLoading: state is SavingPurchaseState,
              onPressed: () =>
                  BlocProvider.of<PurchaseInsertionBloc>(context).add(
                SavePurchase(
                  purchase: purchase,
                  purchaseRepository: session.purchaseRepository,
                ),
              ),
              text: AppLocalizations.of(context)!.saveButton,
            ),
          )
        ]),
      ),
    );
  }

  Widget errorScreen(BuildContext context) {
    return const Text('Erro');
  }

  Widget insertedPurchaseScreen(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            children: [
              Text(AppLocalizations.of(context)!.purchaseSavedSuccessfully),
              const SizedBox(height: 35.0),
              ActionButton(
                onPressed: () => Navigator.pop(context),
                text: AppLocalizations.of(context)!.okButton,
              )
            ],
          ),
        ),
      );

  Widget header(BuildContext context, PurchaseInsertionState state) {
    final merchant = state.purchase.merchant;
    final purchase = state.purchase;

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

  Widget summaryFooter(BuildContext context, PurchaseInsertionState state) {
    final purchase = state.purchase;

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
}
