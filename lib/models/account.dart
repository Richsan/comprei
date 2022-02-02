import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:uuid/uuid.dart';

class Account {
  const Account({
    required this.id,
    required this.userName,
    this.database,
  });

  final int id;
  final String userName;
  final Database? database;
}
