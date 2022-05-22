import 'package:bloc/bloc.dart';
import 'package:comprei/models/purchase.dart';
import 'package:equatable/equatable.dart';

part 'purchase_item_events.dart';
part 'purchase_item_states.dart';

class PurchaseItemBloc extends Bloc<PurchaseItemEvent, PurchaseItemState> {
  PurchaseItemBloc(PurchaseItem purchaseItem)
      : super(NewPurchaseItemState(purchaseItem: purchaseItem)) {
    on<NewPurchaseItem>((event, emit) =>
        emit(NewPurchaseItemState(purchaseItem: event.purchaseItem)));
    on<UpdatePurchaseItem>((event, emit) =>
        emit(UpdatedPurchaseItemState(purchaseItem: event.purchaseItem)));
    on<EditPurchaseItem>((event, emit) =>
        emit(EditingPurchaseItemState(purchaseItem: event.purchaseItem)));
  }
}
