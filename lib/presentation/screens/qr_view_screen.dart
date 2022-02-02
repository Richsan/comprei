import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comprei/presentation/bloc/qr_view/qr_view_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QRViewScreen extends StatelessWidget {
  Widget? qrViewWidget;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QRViewBloc(),
      child: BlocBuilder<QRViewBloc, QRViewState>(
        builder: (context, state) => Scaffold(
          body: _bodyBuilder(context, state),
        ),
      ),
    );
  }

  Widget _bodyBuilder(BuildContext context, QRViewState state) {
    if (state is InitializingState) {
      qrViewWidget = _buildQrView(context);
    }

    if (state is PurchaseExtracted) {
      state.controller
          ?.stopCamera()
          .then((value) => state.controller?.dispose())
          .then((value) => Navigator.pop(context, state.purchase));
    }

    return _scanScreen(
      qrCameraWidget: qrViewWidget!,
      context: context,
      state: state,
    );
  }

  Widget _scanScreen({
    required Widget qrCameraWidget,
    required BuildContext context,
    required QRViewState state,
  }) {
    return Column(
      children: <Widget>[
        Expanded(flex: 4, child: qrCameraWidget),
        Expanded(
          flex: 1,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (state is InvalidQRCodeScanned)
                  Text(AppLocalizations.of(context)!.invalidQRCode)
                else if (state is Scanned)
                  Text(AppLocalizations.of(context)!.qrCodeDetected)
                else if (state is PurchaseExtracted)
                  Text(AppLocalizations.of(context)!.purchaseRetrieved)
                else
                  Text(AppLocalizations.of(context)!.scanCode),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                          onPressed: () async {
                            await state.controller?.toggleFlash();
                          },
                          child: FutureBuilder(
                            future: state.controller?.getFlashStatus(),
                            builder: (context, snapshot) {
                              return Text('Flash: ${snapshot.data}');
                            },
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                          onPressed: () async {
                            await state.controller?.flipCamera();
                          },
                          child: FutureBuilder(
                            future: state.controller?.getCameraInfo(),
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                return Text(
                                    'Camera facing ${describeEnum(snapshot.data!)}');
                              } else {
                                return const Text('loading');
                              }
                            },
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: (controller) => _onQRViewCreated(context, controller),
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(BuildContext context, QRViewController controller) {
    BlocProvider.of<QRViewBloc>(context).add(
      StartScan(controller: controller),
    );

    controller.scannedDataStream.listen(
      (scanData) => BlocProvider.of<QRViewBloc>(context).add(
        ScannedData(scanData: scanData, controller: controller),
      ),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
