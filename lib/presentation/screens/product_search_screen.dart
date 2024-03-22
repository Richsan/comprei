import 'package:comprei/widgets/inputs.dart';
import 'package:comprei/widgets/outputs.dart';
import 'package:flutter/material.dart';

class ProductSearchList extends StatelessWidget {
  const ProductSearchList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.0,
      child: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) => CardInfo(
          heading: "product - ${index}",
          onTap: () {},
        ),
      ),
    );
  }
}

class ProductSearchScreen extends StatelessWidget {
  const ProductSearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextInputField searchField = TextInputField(
      suffixIcon: Icons.document_scanner_outlined,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('product search'),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              searchField,
              const SizedBox(
                height: 20,
              ),
              ProductSearchList(),
            ],
          ),
        ),
      ),
    );
  }
}
