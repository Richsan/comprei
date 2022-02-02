import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comprei/presentation/screens/insert_purchase_screen.dart';
import 'package:comprei/presentation/screens/qr_view_screen.dart';
import 'package:comprei/widgets/inputs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InsertOptionScreen extends StatelessWidget {
  const InsertOptionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(AppLocalizations.of(context)!.insertOptionsScreenTitle),
        centerTitle: true,
      ),
      body: buildScreen(context),
    );
  }

  Widget buildScreen(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          children: [
            ActionButton(
              text: AppLocalizations.of(context)!.insertByQRCode,
              onPressed: () async {
                final purchase =
                    await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QRViewScreen(),
                ));

                if (purchase != null) {
                  final finished =
                      await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => InsertPurchaseScreen(
                      purchase: purchase,
                    ),
                  ));

                  if (finished == true) {
                    Navigator.of(context).pop();
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
