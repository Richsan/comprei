import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:comprei/models/purchase.dart';

part 'purchase_insertion_events.dart';
part 'purchase_insertion_states.dart';

class PurchaseInsertionBloc
    extends Bloc<PurchaseInsertionEvent, PurchaseInsertionState> {
  PurchaseInsertionBloc(Purchase purchase)
      : super(NewPurchaseState(purchase: purchase)) {
    on<NewPurchase>(
        (event, emit) => emit(NewPurchaseState(purchase: event.purchase)));
    on<UpdatePurchase>(
        (event, emit) => emit(UpdatedPurchaseState(purchase: event.purchase)));
    on<SavePurchase>((event, emit) async {
      emit(SavingPurchaseState(purchase: event.purchase));

      //save in database

      //in case of error
      //emit(ErrorState());

      emit(SavedPurchaseState(purchase: event.purchase));
    });
  }
}
