import 'package:acrib/pages/home/homePage.dart';
import 'package:acrib/pages/login/loginPage.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    print(args);
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (ctx) => SmallerTextFactor(HomePage()));
      case '/login':
        return MaterialPageRoute(builder: (ctx) => LoginPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}

class SmallerTextFactor extends StatelessWidget {
  const SmallerTextFactor(this.child, {Key? key}) : super(key: key);
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      child: child!,
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
    );
  }
}
