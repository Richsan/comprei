import 'package:comprei/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Logged session =
        BlocProvider.of<AuthenticationBloc>(context).state as Logged;
    final account = session.account;
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
