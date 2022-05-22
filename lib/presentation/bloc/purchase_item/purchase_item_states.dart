part of 'purchase_item_bloc.dart';

abstract class PurchaseItemState extends Equatable {
  const PurchaseItemState({required this.purchaseItem});

  final PurchaseItem purchaseItem;

  @override
  List<Object> get props => [purchaseItem];
}

class NewPurchaseItemState extends PurchaseItemState {
  const NewPurchaseItemState({required PurchaseItem purchaseItem})
      : super(purchaseItem: purchaseItem);
}

class UpdatedPurchaseItemState extends PurchaseItemState {
  const UpdatedPurchaseItemState({required PurchaseItem purchaseItem})
      : super(purchaseItem: purchaseItem);
}

class EditingPurchaseItemState extends PurchaseItemState {
  const EditingPurchaseItemState({required PurchaseItem purchaseItem})
      : super(purchaseItem: purchaseItem);
}
