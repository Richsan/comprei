part of 'qr_view_bloc.dart';

abstract class QRViewEvent extends Equatable {
  const QRViewEvent({required this.controller});
  final QRViewController controller;

  @override
  List<Object> get props => [controller];
}

class StartScan extends QRViewEvent {
  const StartScan({
    required QRViewController controller,
  }) : super(controller: controller);
}

class ScannedData extends QRViewEvent {
  const ScannedData({
    required this.scanData,
    required QRViewController controller,
  }) : super(controller: controller);

  final Barcode scanData;

  @override
  List<Object> get props => [
        scanData,
        controller,
      ];
}
