part of 'purchase_insertion_bloc.dart';

abstract class PurchaseInsertionState extends Equatable {
  @override
  List<Object> get props => [];
}

class NewPurchaseState extends PurchaseInsertionState {
  final Purchase purchase;

  NewPurchaseState({required this.purchase});

  @override
  List<Object> get props => [purchase];
}

class SavingPurchaseState extends PurchaseInsertionState {
  final Purchase purchase;

  SavingPurchaseState({required this.purchase});

  @override
  List<Object> get props => [purchase];
}

class SavedPurchaseState extends PurchaseInsertionState {
  final Purchase purchase;

  SavedPurchaseState({required this.purchase});

  @override
  List<Object> get props => [purchase];
}

class ErrorState extends PurchaseInsertionState {
  ErrorState();

  @override
  List<Object> get props => [];
}
