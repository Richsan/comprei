import 'package:sqflite_sqlcipher/sqflite.dart';

class Account {
  const Account({
    required this.id,
    required this.userName,
    required this.database,
  });

  final int id;
  final String userName;
  final Database database;
}
