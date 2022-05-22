part of 'purchase_item_bloc.dart';

abstract class PurchaseItemEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NewPurchaseItem extends PurchaseItemEvent {
  NewPurchaseItem({required this.purchaseItem});

  final PurchaseItem purchaseItem;

  @override
  List<Object> get props => [purchaseItem];
}

class UpdatePurchaseItem extends PurchaseItemEvent {
  UpdatePurchaseItem({required this.purchaseItem});

  final PurchaseItem purchaseItem;

  @override
  List<Object> get props => [purchaseItem];
}

class EditPurchaseItem extends PurchaseItemEvent {
  EditPurchaseItem({required this.purchaseItem});

  final PurchaseItem purchaseItem;

  @override
  List<Object> get props => [purchaseItem];
}
