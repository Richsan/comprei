part of 'purchase_item_bloc.dart';

abstract class PurchaseItemEvent extends Equatable {
  @override
  List<Object?> get props => [];
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
  EditPurchaseItem({
    required this.purchaseItem,
    this.productNickName,
    this.productValue,
    this.productDiscount,
    this.productUnities,
  });

  final String? productNickName;
  final int? productValue;
  final int? productDiscount;
  final double? productUnities;
  final PurchaseItem purchaseItem;

  @override
  List<Object?> get props => [
        purchaseItem,
        productNickName,
        productValue,
        productDiscount,
        productUnities,
      ];
}
