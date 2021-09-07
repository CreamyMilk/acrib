import 'dart:io';

import 'package:acrib/constants.dart';
import 'package:acrib/main.dart';
import 'package:acrib/pages/login/loginFuture.dart';
import 'package:acrib/utils/sizedMargins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hasBiometrics = false;
  bool isFirstTimeLogin = false;
  bool userWantsBiometrics = true;
  @override
  void initState() {
    if (Platform.isAndroid && Constants.hasStoredCreds()) {
      print("Checking if the user has biometrics stuff");
      final LocalAuthentication lauth = LocalAuthentication();
      lauth
          .isDeviceSupported()
          .then((deviceSupports) => {
                setState(() => {
                      hasBiometrics = deviceSupports &&
                          ((!isFirstTimeLogin) && userWantsBiometrics)
                    })
              })
          .onError((error, stackTrace) => {
                setState(() => {hasBiometrics = false})
              },);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    String? isValidPhone(dynamic s) {
      return (s.length < 10) ? "Enter A Valid Phonenumber" : null;
    }

    void submitLogin() async {
      if (_formKey.currentState!.validate()) {
        await sendLoginRequest(LoginStruct(phoneNumber: phoneController.text));
      }
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const YMargin(10),
                  Align(
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.house_siding,
                      color: Colors.amber,
                      size: 60,
                    ),
                  ),
                  const YMargin(40),
                  const Text(
                    "Welcome To ICRIB",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const YMargin(10),
                  const Text(
                    "The future of housing",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const YMargin(40),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '07xxxx',
                          labelText: "Phone Number"),
                      controller: phoneController,
                      validator: isValidPhone,
                    ),
                  ),
                  const YMargin(60),
                  Row(
                    children: [
                      hasBiometrics
                          ? IconButton(
                              iconSize: 30,
                              onPressed: () {
                                localAuthenticate();
                              },
                              icon: Icon(Icons.fingerprint_outlined))
                          : SizedBox(),
                      Spacer(),
                      MaterialButton(
                          elevation: 0,
                          color: Colors.amber[300],
                          child: Text("Login"),
                          onPressed: submitLogin),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> localAuthenticate() async {
  final LocalAuthentication lauth = LocalAuthentication();
  bool authenticated = false;

  try {
    authenticated = await lauth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        useErrorDialogs: true,
        androidAuthStrings: AndroidAuthMessages(
          signInTitle: "Biometrics Required",
          biometricHint: "Verify identity",
          biometricSuccess: "Login was successful",
        ),
        stickyAuth: true);
  } on PlatformException catch (e) {
    print(e);
    return;
  }
  if (authenticated) {
    Navigator.of(navigatorKey.currentContext!).pushNamed("/");
  }
}
