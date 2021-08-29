import 'package:acrib/utils/sizedMargins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    String? isValidPhone(dynamic s) {
      return (s.length < 10) ? "Enter A Valid Phonenumber" : null;
    }

    void submitLogin() {
      if (_formKey.currentState!.validate()) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Sending Api Data")));
      }
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
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
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '07xxxxx',
                          labelText: "Phone Number"),
                      controller: phoneController,
                      validator: isValidPhone,
                    ),
                  ),
                  const YMargin(60),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: MaterialButton(
                        elevation: 0,
                        color: Colors.amber[300],
                        child: Text("Login"),
                        onPressed: submitLogin),
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
