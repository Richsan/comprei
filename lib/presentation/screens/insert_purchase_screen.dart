import 'package:comprei/models/purchase.dart';
import 'package:comprei/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:comprei/presentation/bloc/purchase_insertion/purchase_insertion_bloc.dart';
import 'package:comprei/presentation/screens/purchase_screen.dart';
import 'package:comprei/widgets/inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  Widget purchaseScreen(BuildContext context, PurchaseInsertionState state) {
    final Logged session =
        BlocProvider.of<AuthenticationBloc>(context).state as Logged;

    return Column(
      children: [
        buildPurchaseScreen(
          context,
          purchase: purchase,
          onEditItem: (purchaseItem) =>
              BlocProvider.of<PurchaseInsertionBloc>(context).add(
            UpdatePurchaseItem(
              purchase: state.purchase,
              purchaseItem: purchaseItem,
            ),
          ),
        ),
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
        ),
      ],
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
}
