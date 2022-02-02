import 'package:flutter/material.dart';
import 'package:comprei/models/account.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
    required this.account,
  }) : super(key: key);

  final Account account;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(account.userName),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            title: Text('test $index'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/insert-option'),
      ),
    );
  }
}
