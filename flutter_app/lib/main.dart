import 'package:app1/config/theme.dart';
import 'package:app1/home.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: appTheme,
    home: Home(),
  ));
}
