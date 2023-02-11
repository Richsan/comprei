part of 'purchase_insertion_bloc.dart';

abstract class PurchaseInsertionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NewPurchase extends PurchaseInsertionEvent {
  NewPurchase({required this.purchase});

  final Purchase purchase;

  @override
  List<Object> get props => [purchase];
}

class UpdatePurchase extends PurchaseInsertionEvent {
  UpdatePurchase({required this.purchase});

  final Purchase purchase;

  @override
  List<Object> get props => [purchase];
}

class UpdatePurchaseItem extends PurchaseInsertionEvent {
  UpdatePurchaseItem({
    required this.purchase,
    required this.purchaseItem,
  });

  final Purchase purchase;
  final PurchaseItem purchaseItem;

  @override
  List<Object> get props => [
        purchase,
        purchaseItem,
      ];
}

class SavePurchase extends PurchaseInsertionEvent {
  SavePurchase({required this.purchase});

  final Purchase purchase;

  @override
  List<Object> get props => [purchase];
}
