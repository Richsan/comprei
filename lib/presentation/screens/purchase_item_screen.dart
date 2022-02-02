import 'package:flutter/material.dart';
import 'package:comprei/models/purchase.dart';

class PurchaseItemScreen extends StatelessWidget {
  const PurchaseItemScreen({
    Key? key,
    required this.purchase,
  }) : super(key: key);
  final PurchaseItem purchase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Purchase Screen'),
        centerTitle: true,
      ),
      body: buildScreen(context, purchase),
    );
  }

  Widget buildScreen(BuildContext context, PurchaseItem purchase) {
    return Text('to Implement');
  }
}
