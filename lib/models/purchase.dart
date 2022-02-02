import 'package:comprei/models/product.dart';
import 'package:collection/collection.dart';
import '../adapters/number.dart';
import 'package:equatable/equatable.dart';

class Purchase extends Equatable {
  const Purchase({
    required this.items,
    required this.merchant,
    required this.date,
    this.taxValue = 0,
    this.discount = 0,
  })  : assert(items != const []),
        assert(discount >= 0);

  final Merchant merchant;
  final List<PurchaseItem> items;
  final DateTime date;
  final int discount;
  final int taxValue;

  int get remainingDiscount => discount - items.map((e) => e.discount).sum;

  int get totalValue => items.map((e) => e.totalValue).sum - remainingDiscount;

  Purchase copyWith({
    List<PurchaseItem>? items,
    Merchant? merchant,
    DateTime? date,
    int? discount,
    int? taxValue,
  }) =>
      Purchase(
        items: items ?? this.items,
        merchant: merchant ?? this.merchant,
        date: date ?? this.date,
        discount: discount ?? this.discount,
        taxValue: taxValue ?? this.taxValue,
      );

  @override
  List<Object?> get props => [
        merchant,
        items,
        date,
        discount,
        taxValue,
      ];
}

class Merchant extends Equatable {
  const Merchant({
    required this.id,
    required this.name,
    this.nickName,
  });

  final String id;
  final String name;
  final String? nickName;

  @override
  List<Object?> get props => [id, name, nickName];
}

class PurchaseItem extends Equatable {
  const PurchaseItem({
    required this.value,
    this.discount = 0,
    required this.product,
    this.unities = 1,
    this.unitMeasure = "UN",
  })  : assert(unities > 0),
        assert(discount >= 0),
        assert(value > 0);

  final Product product;
  final int value;
  final int discount;
  final double unities;
  final String unitMeasure;

  int get totalValue => ((value * unities) - discount).round().toInt();

  @override
  List<Object?> get props => [
        product,
        value,
        discount,
        unities,
        unitMeasure,
      ];
}
