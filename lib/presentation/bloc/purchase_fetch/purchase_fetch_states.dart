part of 'purchase_fetch_bloc.dart';

abstract class PurchaseFetchState extends Equatable {
  const PurchaseFetchState();

  @override
  List<Object> get props => [];
}

class LoadedPurchaseFetchState extends PurchaseFetchState {
  const LoadedPurchaseFetchState({
    required this.purchase,
  });

  final Purchase purchase;

  @override
  List<Object> get props => [
        purchase,
      ];
}

class FetchingPurchaseState extends PurchaseFetchState {
  const FetchingPurchaseState({
    required this.purchaseId,
  });

  final UuidValue purchaseId;

  @override
  List<Object> get props => [];
}
