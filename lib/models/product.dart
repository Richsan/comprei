import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Product extends Equatable {
  const Product({
    required this.cod,
    required this.description,
    this.nickName,
    this.brand,
  });

  final String cod;
  final String description;
  final String? nickName;
  final Brand? brand;

  Product copyWith({
    String? nickName,
    Brand? brand,
  }) {
    return Product(
      cod: cod,
      description: description,
      nickName: nickName ?? this.nickName,
      brand: brand ?? this.brand,
    );
  }

  @override
  List<Object?> get props => [
        cod,
        description,
        nickName,
        brand,
      ];
}

class Brand extends Equatable {
  Brand({
    UuidValue? id,
    required this.name,
    this.nickName,
  }) : id = id ?? const Uuid().v4obj();

  final UuidValue id;
  final String name;
  final String? nickName;

  Brand copyWith({
    String? nickName,
  }) {
    return Brand(
      id: id,
      name: name,
      nickName: nickName ?? this.nickName,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        nickName,
      ];
}

class ProductPurchases extends Equatable {
  const ProductPurchases({
    required this.product,
    required this.purchasesDate,
  });

  final Product product;
  final List<DateTime> purchasesDate;

  @override
  List<Object> get props => [
        product,
        purchasesDate,
      ];
}
