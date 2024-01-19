import 'package:bloc/bloc.dart';
import 'package:comprei/components/purchase_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../models/purchase.dart';

part 'purchase_fetch_events.dart';
part 'purchase_fetch_states.dart';

class PurchaseFetchBloc extends Bloc<PurchaseFetchEvent, PurchaseFetchState> {
  PurchaseFetchBloc({
    required this.purchaseId,
    required this.purchaseRepository,
  }) : super(FetchingPurchaseState(purchaseId: purchaseId)) {
    on<PurchaseFetchLoadEvent>((event, emit) async {
      final purchase =
          await event.purchaseRepository.getPurchaseById(event.purchaseId);

      emit(LoadedPurchaseFetchState(purchase: purchase));
    });

    add(PurchaseFetchLoadEvent(
        purchaseRepository: purchaseRepository, purchaseId: purchaseId));
  }

  final UuidValue purchaseId;
  final PurchaseRepository purchaseRepository;
}
