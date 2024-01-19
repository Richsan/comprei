import 'package:comprei/adapters/input_masks.dart';
import 'package:comprei/adapters/number.dart';
import 'package:comprei/adapters/string.dart';
import 'package:comprei/models/purchase.dart';
import 'package:comprei/presentation/bloc/inputs/text_field.dart';
import 'package:comprei/presentation/bloc/purchase_item/purchase_item_bloc.dart';
import 'package:comprei/widgets/inputs.dart';
import 'package:comprei/widgets/outputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class _NickNameInputField extends Cubit<String> with ITextFieldCubit {
  _NickNameInputField({String initialValue = ''}) : super(initialValue);
}

class _ValueInputField extends Cubit<String> with ITextFieldCubit {
  _ValueInputField({String initialValue = ''}) : super(initialValue);
}

class _DiscountInputField extends Cubit<String> with ITextFieldCubit {
  _DiscountInputField({String initialValue = ''}) : super(initialValue);
}

class _UnitiesInputField extends Cubit<String> with ITextFieldCubit {
  _UnitiesInputField({String initialValue = ''}) : super(initialValue);
}

class PurchaseItemScreen extends StatelessWidget {
  const PurchaseItemScreen({
    Key? key,
    required this.purchase,
    this.editable = false,
  }) : super(key: key);
  final PurchaseItem purchase;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<_NickNameInputField>(
          create: (context) => _NickNameInputField(
            initialValue: purchase.product?.nickName ?? '',
          ),
        ),
        BlocProvider<_ValueInputField>(
          create: (context) => _ValueInputField(
            initialValue: purchase.value.asCurrency(),
          ),
        ),
        BlocProvider<_DiscountInputField>(
          create: (context) => _DiscountInputField(
            initialValue: purchase.discount.asCurrency(),
          ),
        ),
        BlocProvider<_UnitiesInputField>(
          create: (context) => _UnitiesInputField(
            initialValue: purchase.unities.toString(),
          ),
        ),
        BlocProvider<PurchaseItemBloc>(
            create: (context) => PurchaseItemBloc(purchase)),
      ],
      child: BlocBuilder<PurchaseItemBloc, PurchaseItemState>(
        builder: (context, state) => Scaffold(
          backgroundColor: Colors.white.withOpacity(0.5),
          body: buildScreen(context, state),
        ),
      ),
    );
  }

  Widget buildEditScreen(BuildContext context, EditingPurchaseItemState state) {
    final product = state.purchaseItem.product;
    final ITextFieldCubit nickNameFieldBloc =
        BlocProvider.of<_NickNameInputField>(context);
    final ITextFieldCubit valueFieldBloc =
        BlocProvider.of<_ValueInputField>(context);
    final ITextFieldCubit discountFieldBloc =
        BlocProvider.of<_DiscountInputField>(context);
    final ITextFieldCubit unitiesFieldBloc =
        BlocProvider.of<_UnitiesInputField>(context);

    final l10n = AppLocalizations.of(context)!;

    return FullScreenCard(
      title: product?.name ?? state.purchaseItem.description,
      buttonName: l10n.editButton,
      buttonOnPressed: () {
        final item = state.purchaseItem.copyWith(
            value: int.parse(
                BlocProvider.of<_ValueInputField>(context).state.onlyNumbers()),
            discount: int.parse(BlocProvider.of<_DiscountInputField>(context)
                .state
                .onlyNumbers()),
            unities: double.parse(
                BlocProvider.of<_UnitiesInputField>(context).state),
            product: product?.copyWith(
                nickName: BlocProvider.of<_NickNameInputField>(context).state));
        BlocProvider.of<PurchaseItemBloc>(context)
            .add(UpdatePurchaseItem(purchaseItem: item));
      },
      children: [
        BlocProvider.value(
          value: nickNameFieldBloc,
          child: TextInputField(
            mask: masks["alphabetic"],
            labelText: l10n.productNicknameHint,
          ),
        ),
        BlocProvider.value(
          value: valueFieldBloc,
          child: TextInputField(
            labelText: l10n.value,
            mask: masks["currency"],
          ),
        ),
        BlocProvider.value(
          value: discountFieldBloc,
          child: TextInputField(
            labelText: l10n.discount,
            mask: masks["currency"],
          ),
        ),
        BlocProvider.value(
          value: unitiesFieldBloc,
          child: TextInputField(
            labelText: l10n.unities,
            mask: masks["decimal"],
          ),
        ),
      ],
    );
  }

  Widget buildInfoScreen(BuildContext context, PurchaseItemState state) {
    final product = state.purchaseItem.product;
    final l10n = AppLocalizations.of(context)!;

    return FullScreenCard(
      title:
          product?.nickName ?? product?.name ?? state.purchaseItem.description,
      buttonName: editable
          ? AppLocalizations.of(context)!.saveButton
          : AppLocalizations.of(context)!.okButton,
      buttonOnPressed: () => Navigator.of(context).pop(state.purchaseItem),
      onEdit: editable
          ? () => BlocProvider.of<PurchaseItemBloc>(context).add(
                EditPurchaseItem(purchaseItem: state.purchaseItem),
              )
          : () => Navigator.of(context).pop(),
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
          keyName: l10n.id,
          value: product?.id.uuid ?? '',
        ),
        TextKeyValue(
          keyName: l10n.brand,
          value: product?.brand?.name ?? '',
        ),
        TextKeyValue(
          keyName: l10n.valuePerUnit(purchase.unitMeasure),
          value: state.purchaseItem.value.asCurrency(),
        ),
        TextKeyValue(
          keyName: l10n.quantity,
          value: '${state.purchaseItem.unities} ${purchase.unitMeasure}',
        ),
        TextKeyValue(
          keyName: l10n.discount,
          value: state.purchaseItem.discount.asCurrency(),
        ),
        TextKeyValue(
          keyName: l10n.totalValue,
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
