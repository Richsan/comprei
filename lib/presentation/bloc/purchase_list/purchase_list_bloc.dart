import 'package:bloc/bloc.dart';
import 'package:comprei/components/purchase_repository.dart';
import 'package:comprei/models/purchase_summary.dart';
import 'package:equatable/equatable.dart';

part 'purchase_list_events.dart';
part 'purchase_list_states.dart';

class PurchaseListBloc extends Bloc<PurchaseListEvent, PurchaseListState> {
  PurchaseListBloc() : super(InitialPurchaseListState()) {
    on<PurchaseListLoadEvent>((event, emit) async {
      emit(const LoadingPurchaseListState());

      final purchaseSummaries =
          await event.purchaseRepository.getAllPurchasesSummary();

      emit(LoadedPurchaseListState(purchaseSummaries: purchaseSummaries));
    });
  }
}
