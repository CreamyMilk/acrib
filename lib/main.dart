import 'package:acrib/routes_page.dart';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ACrib',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/login',
      navigatorKey: navigatorKey,
    );
  }
}
