part of 'purchase_list_bloc.dart';

abstract class PurchaseListState extends Equatable {
  const PurchaseListState();

  @override
  List<Object> get props => [];
}

class InitialPurchaseListState extends PurchaseListState {
  @override
  List<Object> get props => [];
}

class LoadedPurchaseListState extends PurchaseListState {
  const LoadedPurchaseListState({
    required this.purchaseSummaries,
  });

  final List<PurchaseSummary> purchaseSummaries;

  @override
  List<Object> get props =>
      [
        purchaseSummaries,
      ];
}

class LoadingPurchaseListState extends PurchaseListState {
  const LoadingPurchaseListState();

  @override
  List<Object> get props => [];
}
