part of 'product_search_bloc.dart';

abstract class ProductSearchState extends Equatable {
  const ProductSearchState({
    this.searchText = "",
  });

  final String searchText;

  @override
  List<Object> get props => [searchText];
}

class StartState extends ProductSearchState {
  const StartState({String searchText = ""})
      : super(
          searchText: searchText,
        );
}

class SearchingProductState extends ProductSearchState {
  const SearchingProductState({
    String searchText = "",
  }) : super(searchText: searchText);
}

class SearchedProductState extends ProductSearchState {
  const SearchedProductState({
    String searchText = "",
    required this.products,
  }) : super(searchText: searchText);

  final List<Product> products;

  @override
  List<Object> get props => [
        searchText,
        products,
      ];
}
