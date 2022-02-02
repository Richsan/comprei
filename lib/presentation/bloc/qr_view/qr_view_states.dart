part of 'qr_view_bloc.dart';

abstract class QRViewState extends Equatable {
  const QRViewState({this.controller});

  final QRViewController? controller;

  @override
  List<Object?> get props => [controller];
}

class InitializingState extends QRViewState {}

class Scanning extends QRViewState {
  const Scanning({
    required QRViewController controller,
  }) : super(controller: controller);
}

class Scanned extends QRViewState {
  const Scanned({
    required this.scanData,
  });

  final Barcode scanData;

  @override
  List<Object> get props => [scanData];
}

class PurchaseExtracted extends QRViewState {
  const PurchaseExtracted({
    required this.purchase,
    required this.scanData,
    required QRViewController controller,
  }) : super(controller: controller);

  final Barcode scanData;
  final Purchase purchase;

  @override
  List<Object> get props => [
        scanData,
        purchase,
      ];
}

class InvalidQRCodeScanned extends QRViewState {
  const InvalidQRCodeScanned({
    required this.scanData,
    required QRViewController controller,
  }) : super(controller: controller);

  final Barcode scanData;

  @override
  List<Object> get props => [
        scanData,
      ];
}
