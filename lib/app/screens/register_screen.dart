import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/app/services/cliente_service.dart';
import 'package:proyecto/app/theme/themes.dart';
import 'package:proyecto/app/widgets/notificaciones.dart';

class RegisterScreen extends StatefulWidget {

  const RegisterScreen({super.key});

  @override
  RegisterScreenS createState() => RegisterScreenS();
}

class RegisterScreenS extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController pass2Controller = TextEditingController();
  final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool _estado = true;

  void _validacion() {
    setState(() {
      if (_estado) {
        _estado = false;
      } else {
        _estado = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 75),
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container (
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                    ),
                    child: Image.asset("Assets/Images/logo.png"),
                  ),
                  const Padding(padding: EdgeInsets.all(30)),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: AdaptiveTheme.of(context).mode.isDark ? Login.containerDark : Login.container,
                    ),
                    width: 350,
                    child: Column(
                      children: [
                        Form(
                            key: keyForm,
                            autovalidateMode: _estado ? AutovalidateMode.disabled : AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(25, 35, 25, 10),
                                  child: TextFormField(
                                    controller: nameController,
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "Nombre",
                                        labelText: "Ingrese Su Nombre",
                                        prefixIcon: const Icon(Icons.account_circle),
                                        fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                        filled: true,
                                        border: InputBorder.none,
                                        labelStyle: TextStyle(
                                            color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                    validator: ( String? value ) {
                                      String exp = r'^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]';
                                      return RegExp(exp).hasMatch(value  ?? '')? null : 'No se admiten esos caracteres en el nombre';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: TextFormField(
                                    controller: lastNameController,
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Apellido',
                                      labelText: 'Ingrese Su Apellido',
                                      prefixIcon: const Icon(Icons.account_circle),
                                      fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                      filled: true,
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                          color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    validator: ( String? value ) {
                                      String exp = r'^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]';
                                      return RegExp(exp).hasMatch(value  ?? '')? null : 'No se admiten esos caracteres en el apellido';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: TextFormField(
                                    controller: phoneController,
                                    autocorrect: false,
                                    keyboardType: TextInputType.phone,
                                    style: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '998746321',
                                      labelText: 'Número de Teléfono',
                                      prefixIcon: const Icon(Icons.phone),
                                      fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                      filled: true,
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                          color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    validator: ( String? value ) {
                                      String exp = r'^[0-9]{9}$';
                                      if (value!.length == 9)
                                      {
                                        if (RegExp(exp).hasMatch(value)) {
                                          return null;
                                        } else {
                                          return 'No se admiten esos caracteres en el teléfono';
                                        }
                                      } else {
                                        return "Se requieren 9 digitos para el teléfono";
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: TextFormField(
                                    controller: emailController,
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: TextFormField(
                                    controller: passController,
                                    keyboardType: TextInputType.visiblePassword,
                                    autocorrect: false,
                                    obscureText: true,
                                    style: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '***********',
                                      labelText: 'Contraseña',
                                      prefixIcon: const Icon(Icons.lock_outline),
                                      fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                      filled: true,
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                          color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    validator: ( String? value ) {
                                      return ( value != null && value.length >= 10 )
                                          ? null
                                          : 'La contraseña debe de ser de 10 caracteres';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: TextFormField(
                                    controller: pass2Controller,
                                    autocorrect: false,
                                    obscureText: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    style: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark   : General.textInput,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '***********',
                                      labelText: 'Repetir Contraseña',
                                      prefixIcon: const Icon(Icons.lock_outline),
                                      fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                      filled: true,
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                          color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    validator: ( String? value ) {
                                      if ( value != null && value.length >= 10) {
                                        if (passController.value == pass2Controller.value) {
                                          return null;
                                        } else {
                                          return 'Las Contraseñas no coinciden';
                                        }
                                      } else {
                                        return 'La contraseña debe de ser de 10 caracteres';
                                      }
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: MaterialButton(
                                      onPressed: () async{
                                        _validacion();
                                        if (keyForm.currentState!.validate()) {
                                          if (passController.value == pass2Controller.value) {
                                            addCli(nameController.text, lastNameController.text, phoneController.text,
                                                emailController.text, passController.text);

                                            successfulMessage(context, "Registrado Correctamente");

                                            nameController.text = "";
                                            lastNameController.text = "";
                                            phoneController.text = "";
                                            emailController.text = "";
                                            passController.text = "";
                                            pass2Controller.text = "";
                                          }
                                        }
                                      },
                                      color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                                      disabledColor: AdaptiveTheme.of(context).mode.isDark ? Login.disableButtonDark : Login.disableButton,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 90,
                                          vertical: 18
                                      ),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)
                                          )
                                      ),
                                    child: const Text('Registrar',
                                      style: TextStyle(
                                          fontSize: 25
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10,
                                          horizontal: 0),
                                      child: Text("¿Ya estas registrado?"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10,
                                          horizontal: 0),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: TextButton.styleFrom(
                                          foregroundColor: AdaptiveTheme.of(context).mode.isDark ? Login.textButtonDark : Login.textButton,
                                        ),
                                        child: const Text("Inicie Sesión"),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 40))
                ],
              )
          ),
        )
    );
  }

}