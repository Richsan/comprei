part of 'purchase_list_bloc.dart';

abstract class PurchaseListEvent extends Equatable {
  const PurchaseListEvent();

  @override
  List<Object> get props => [];
}

class PurchaseListLoadEvent extends PurchaseListEvent {
  const PurchaseListLoadEvent({required this.purchaseRepository});

  final PurchaseRepository purchaseRepository;

  @override
  List<Object> get props => [
        purchaseRepository,
      ];
}
