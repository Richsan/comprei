import 'package:equatable/equatable.dart';

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
  const Brand({
    required this.id,
    required this.name,
    this.nickName,
  });

  final int id;
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
