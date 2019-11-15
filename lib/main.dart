import 'package:flutter/material.dart';
//Servicios Dart
import 'package:flutter/services.dart';
// Servicios
import 'package:itunes/src/bloc/provider.dart';
import 'package:itunes/src/shared/preferencias.dart';
import 'package:itunes/src/settings/routes.dart';
// Pages
import 'package:itunes/src/pages/home/home_page.dart';
import 'package:itunes/src/pages/detail/detail_page.dart';

Future main() async {

  final prefs = new Preferencias();
  await prefs.initPrefs();

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Color(0xFF0F0F0F), // navigation bar color
      statusBarColor: Color(0xFF0F0F0F), // status bar color
    ));
    return Provider(
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: pagina_home,
        routes: {
          pagina_home   : (BuildContext context) => HomePage(),
          pagina_detalle: (BuildContext context) => DetailPage(),
        },
        theme: ThemeData(
          primaryColor: Color(0xFF1E1E1E),
        ),
      ),
    );
  }
}