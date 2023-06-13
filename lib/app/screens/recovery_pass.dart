import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/app/screens/login_screen.dart';
import 'package:proyecto/app/theme/themes.dart';
import 'package:proyecto/app/services/services.dart';
import 'package:proyecto/app/widgets/notificaciones.dart';

class RecoveryScreen extends StatefulWidget {

  const RecoveryScreen({super.key});

  @override
  _RecoveryScreen createState() => _RecoveryScreen();
}

class _RecoveryScreen extends State<RecoveryScreen> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool estado = true;

  void _validacion() {
    setState(() {
      if (estado) {
        estado = false;
      } else {
        estado = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new)
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: AdaptiveTheme.of(context).mode.isDark ? Login.containerDark : Login.container,
                  borderRadius: BorderRadius.circular(5)
              ),
              margin: const EdgeInsets.all(40),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Text(
                      "Recuperación de contraseña",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Text(
                      'Ingrese su dirección de correo electrónico para recuperar su contraseña. En unos instantes recibirá un correo con los pasos para obtener una nueva contraseña',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Form(
                      key: keyForm,
                      autovalidateMode: estado ? AutovalidateMode.disabled : AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 10
                            ),
                            child: TextFormField(
                              controller: emailController,
                              autocorrect: false,
                              style: TextStyle(
                                color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                              ),
                              decoration: InputDecoration(
                                  hintText: "username@correo.com",
                                  labelText: "Correo",
                                  prefixIcon: const Icon(Icons.mail),
                                  fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                  filled: true,
                                  border: InputBorder.none,
                                  labelStyle: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                              validator: ( String? value ) {
                                String exp = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                return RegExp(exp).hasMatch(value  ?? '')? null : 'El texto no parece un correo';
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextButton(
                              onPressed: () {
                                if (keyForm.currentState!.validate()) {
                                  recoveryPassword(emailController.text);
                                  emailController.text = "";
                                  successfulMessage(context, "Correo enviado correctamente");
                                } else {
                                  _validacion();
                                }
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                                backgroundColor: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                                foregroundColor: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),
                              child: const Text(
                                "Enviar E-mail",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}


