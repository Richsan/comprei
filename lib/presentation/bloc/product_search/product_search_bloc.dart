import 'package:bloc/bloc.dart';
import 'package:comprei/models/product.dart';
import 'package:equatable/equatable.dart';

part 'product_search_events.dart';
part 'product_search_states.dart';

class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
  ProductSearchBloc() : super(StartState()) {
    on<ProductSearchEvent>((event, emit) async {
      emit(SearchingProductState(searchText: event.searchText));
      // reads from repository
      // emits searched state
    });
  }

//final PurchaseRepository purchaseRepository;
}
