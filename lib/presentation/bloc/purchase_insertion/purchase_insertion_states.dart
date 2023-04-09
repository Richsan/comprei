part of 'purchase_insertion_bloc.dart';

abstract class PurchaseInsertionState extends Equatable {
  const PurchaseInsertionState(this.purchase);

  final Purchase purchase;

  @override
  List<Object> get props => [purchase];

}

class NewPurchaseState extends PurchaseInsertionState {

  const NewPurchaseState({required Purchase purchase })
      : super(purchase);

  @override
  List<Object> get props => [purchase];
}

class SavingPurchaseState extends PurchaseInsertionState {
  const SavingPurchaseState({required Purchase purchase})
      : super(purchase);

  @override
  List<Object> get props => [purchase];
}

class SavedPurchaseState extends PurchaseInsertionState {

  const SavedPurchaseState({required Purchase purchase})
      : super(purchase);

  @override
  List<Object> get props => [purchase];
}

class ErrorState extends PurchaseInsertionState {
  const ErrorState({required Purchase purchase})
  : super(purchase);

  @override
  List<Object> get props => [purchase];
}
