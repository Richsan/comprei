import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.cod,
    required this.description,
    this.brand,
  });

  final String cod;
  final String description;
  final Brand? brand;

  @override
  List<Object?> get props => [
    cod,
    description,
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

  @override
  List<Object?> get props => [
    id,
    name,
    nickName,
  ];
}
