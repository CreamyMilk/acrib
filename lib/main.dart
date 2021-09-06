import 'package:acrib/constants.dart';
import 'package:acrib/routes_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(Constants.UserBoxName);
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
