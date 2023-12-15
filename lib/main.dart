import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'presentation/screens/app.dart';

void main() async {
  Permission.manageExternalStorage.request();
  Permission.storage.request();
  runApp(const App());
}
