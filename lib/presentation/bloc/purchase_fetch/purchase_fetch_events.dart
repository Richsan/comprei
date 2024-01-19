part of 'purchase_fetch_bloc.dart';

abstract class PurchaseFetchEvent extends Equatable {
  const PurchaseFetchEvent();

  @override
  List<Object> get props => [];
}

class PurchaseFetchLoadEvent extends PurchaseFetchEvent {
  const PurchaseFetchLoadEvent({
    required this.purchaseRepository,
    required this.purchaseId,
  });

  final PurchaseRepository purchaseRepository;
  final UuidValue purchaseId;

  @override
  List<Object> get props => [
        purchaseRepository,
        purchaseId,
      ];
}
