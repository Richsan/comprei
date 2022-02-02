import 'package:equatable/equatable.dart';

class Invoice extends Equatable {
  const Invoice({
    required this.url,
    required this.number,
    required this.series,
    required this.emissionMoment,

});

  final Uri url;
  final int number;
  final int series;
  final DateTime emissionMoment;

  @override
  List<Object?> get props => [
    url,
    number,
    series,
    emissionMoment,
  ];
}