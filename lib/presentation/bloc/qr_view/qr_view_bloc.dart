import 'package:bloc/bloc.dart';
import 'package:comprei/models/purchase.dart';
import 'package:comprei/services/nfe_extractor.dart';
import 'package:equatable/equatable.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

part 'qr_view_events.dart';
part 'qr_view_states.dart';

class QRViewBloc extends Bloc<QRViewEvent, QRViewState> {
  QRViewBloc() : super(InitializingState()) {
    on<StartScan>(
      (event, emit) => emit(
        Scanning(
          controller: event.controller,
        ),
      ),
    );
    on<ScannedData>((event, emit) async {
      event.controller.pauseCamera();
      //TODO: check in the database if we already imported this url
      final Purchase? purchase =
          await extractFromUrl(event.scanData.code!).catchError((_) => null);

      if (purchase != null) {
        emit(
          PurchaseExtracted(
            purchase: purchase,
            scanData: event.scanData,
            controller: event.controller,
          ),
        );
      } else {
        event.controller.resumeCamera();
        emit(
          InvalidQRCodeScanned(
            scanData: event.scanData,
            controller: event.controller,
          ),
        );
      }
    });
  }
}
