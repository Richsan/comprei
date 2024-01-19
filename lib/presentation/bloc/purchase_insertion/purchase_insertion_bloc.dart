import 'package:bloc/bloc.dart';
import 'package:comprei/components/purchase_repository.dart';
import 'package:comprei/models/purchase.dart';
import 'package:equatable/equatable.dart';

part 'purchase_insertion_events.dart';
part 'purchase_insertion_states.dart';

class PurchaseInsertionBloc
    extends Bloc<PurchaseInsertionEvent, PurchaseInsertionState> {
  PurchaseInsertionBloc(Purchase purchase)
      : super(NewPurchaseState(purchase: purchase)) {
    on<NewPurchase>(
        (event, emit) => emit(NewPurchaseState(purchase: event.purchase)));
    on<UpdatePurchaseItem>((event, emit) async {
      final purchase = event.purchase;
      final purchaseItem = event.purchaseItem;
      final purchaseItems = purchase.items;
      final newPurchaseItems = purchaseItems
          .map((e) =>
              e.product?.id == purchaseItem.product?.id ? purchaseItem : e)
          .toList();

      emit(
        NewPurchaseState(
          purchase: purchase.copyWith(
            items: newPurchaseItems,
          ),
        ),
      );
    });
    on<SavePurchase>((event, emit) async {
      emit(SavingPurchaseState(purchase: event.purchase));

      //save in database

      await event.purchaseRepository.save(event.purchase);
      //in case of error
      //emit(ErrorState());

      emit(SavedPurchaseState(purchase: event.purchase));
    });
  }
}
