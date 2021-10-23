import 'package:flutter/material.dart';
import 'navbar/navbar.dart';
import 'sign_up.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() => initializeDateFormatting().then((_) => runApp(const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const SignUp(),
      '/sign_up': (context) => const Navbar()
    }
  );
}