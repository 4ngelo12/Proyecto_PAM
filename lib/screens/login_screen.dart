import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key, this.title}):super(key:key);
  final String? title;

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Este es el login"),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'home');
          },
          child: Text("Ir a Home"),
        ),
      ),
    );
  }

}


