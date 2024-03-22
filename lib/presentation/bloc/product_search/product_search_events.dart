part of 'product_search_bloc.dart';

class ProductSearchEvent extends Equatable {
  const ProductSearchEvent({
    required this.searchText,
  });

  final String searchText;

  @override
  List<Object> get props => [];
}
