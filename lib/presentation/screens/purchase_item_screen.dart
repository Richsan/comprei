import 'package:comprei/adapters/input_masks.dart';
import 'package:comprei/adapters/number.dart';
import 'package:comprei/models/purchase.dart';
import 'package:comprei/presentation/bloc/purchase_item/purchase_item_bloc.dart';
import 'package:comprei/widgets/inputs.dart';
import 'package:comprei/widgets/outputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PurchaseItemScreen extends StatelessWidget {
  const PurchaseItemScreen({
    Key? key,
    required this.purchase,
  }) : super(key: key);
  final PurchaseItem purchase;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PurchaseItemBloc(purchase),
      child: BlocBuilder<PurchaseItemBloc, PurchaseItemState>(
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.white.withOpacity(0.5),
          body: buildScreen(context, state),
        ),
      ),
    );
  }

  //TODO make a function to build the edit form screen
  Widget buildEditScreen(BuildContext context, EditingPurchaseItemState state) {
    final product = state.purchaseItem.product;
    return FullScreenCard(
      title: product.description,
      buttonName: 'Editar',
      buttonOnPressed: () => BlocProvider.of<PurchaseItemBloc>(context).add(
        UpdatePurchaseItem(purchaseItem: state.purchaseItem),
      ),
      children: [
        TextInputField(
          mask: masks["alphabetic"],
          onChanged: (value) {
            BlocProvider.of<PurchaseItemBloc>(context).add(
              //TODO change to construct a new purchaseItem with copy method
              EditPurchaseItem(
                purchaseItem: state.purchaseItem,
                productNickName: value,
              ),
            );
          },
          hintText: 'Product nick name',
        ),
        TextInputField(
          initialValue: state.purchaseItem.value.asCurrency(),
          onChanged: (value) {
            BlocProvider.of<PurchaseItemBloc>(context).add(
              //TODO change to construct a new purchaseItem with copy method
              EditPurchaseItem(
                purchaseItem: state.purchaseItem,
                productNickName: value,
              ),
            );
          },
          hintText: 'value',
          mask: masks["currency"],
        ),
      ],
    );
  }

  Widget buildInfoScreen(BuildContext context, PurchaseItemState state) {
    final product = state.purchaseItem.product;
    return FullScreenCard(
      title: product.description,
      buttonName: AppLocalizations.of(context)!.saveButton,
      buttonOnPressed: () => Navigator.of(context).pop(purchase),
      onEdit: () => BlocProvider.of<PurchaseItemBloc>(context).add(
        EditPurchaseItem(purchaseItem: state.purchaseItem),
      ),
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
          value: state.purchaseItem.value.asCurrency(),
        ),
        TextKeyValue(
          keyName: 'Quantidade',
          value: '${state.purchaseItem.unities} ${purchase.unitMeasure}',
        ),
        TextKeyValue(
          keyName: 'Desconto',
          value: state.purchaseItem.discount.asCurrency(),
        ),
        TextKeyValue(
          keyName: 'Valor Total',
          value: state.purchaseItem.totalValue.asCurrency(),
        ),
      ],
    );
  }

  Widget buildScreen(BuildContext context, PurchaseItemState state) {
    if (state is NewPurchaseItemState || state is UpdatedPurchaseItemState) {
      return buildInfoScreen(context, state);
    } else if (state is EditingPurchaseItemState) {
      return buildEditScreen(context, state);
    }
    throw Exception('screen not implemented for state=${state}');
  }
}
