import 'package:collection/collection.dart';
import 'package:comprei/models/product.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum BuyFrequency {
  daily,
  weekly,
  biweekly,
  monthly,
  bimonthly,
  semiannually,
  annually,
}

class Purchase extends Equatable {
  Purchase({
    UuidValue? id,
    required this.items,
    required this.merchant,
    required this.date,
    this.taxValue = 0,
    this.discount = 0,
    this.invoice,
  })  : assert(items != const []),
        assert(discount >= 0),
        id = id ?? const Uuid().v4obj();

  final Merchant merchant;
  final List<PurchaseItem> items;
  final DateTime date;
  final int discount;
  final int taxValue;
  final UuidValue id;
  final String? invoice;

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
        id: id,
        items: items ?? this.items,
        merchant: merchant ?? this.merchant,
        date: date ?? this.date,
        discount: discount ?? this.discount,
        taxValue: taxValue ?? this.taxValue,
      );

  @override
  List<Object?> get props => [
        id,
        merchant,
        items,
        date,
        discount,
        taxValue,
        invoice,
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
  PurchaseItem({
    UuidValue? id,
    required this.value,
    this.discount = 0,
    required this.product,
    this.unities = 1,
    this.unitMeasure = "UN",
  })  : assert(unities > 0),
        assert(discount >= 0),
        assert(value > 0),
        id = id ?? const Uuid().v4obj();

  final Product product;
  final int value;
  final int discount;
  final double unities;
  final String unitMeasure;
  final UuidValue id;

  PurchaseItem copyWith({
    Product? product,
    int? value,
    int? discount,
    double? unities,
    String? unitMeasure,
    DateTime? dateTime,
    Merchant? merchant,
  }) {
    return PurchaseItem(
      id: id,
      product: product ?? this.product,
      value: value ?? this.value,
      discount: discount ?? this.discount,
      unities: unities ?? this.unities,
      unitMeasure: unitMeasure ?? this.unitMeasure,
    );
  }

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
