import 'package:comprei/models/purchase.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class PurchaseSummary extends Equatable {
  const PurchaseSummary({
    required this.id,
    required this.merchant,
    required this.date,
    required this.discount,
    this.taxValue,
    this.invoice,
  });

  final UuidValue id;
  final Merchant merchant;
  final DateTime date;
  final int discount;
  final int? taxValue;
  final String? invoice;

  @override
  List<Object?> get props => [
        id,
        date,
        merchant,
        discount,
        taxValue,
        invoice,
      ];
}
