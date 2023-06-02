import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/app/services/cliente_service.dart';
import 'package:proyecto/app/theme/theme_constants.dart';
import 'package:proyecto/app/theme/theme_colors.dart';
import 'package:proyecto/app/screens/screens.dart';

class RegisterApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final VoidCallback onChanged;

  const RegisterApp({
    super.key,
    this.savedThemeMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.lightTheme,
      dark: AppTheme.darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inicio',
        theme: theme,
        darkTheme: darkTheme,
        home: RegisterScreen(onChanged: onChanged),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  final VoidCallback onChanged;

  const RegisterScreen({super.key, required this.onChanged});

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController pass2Controller = TextEditingController();

  bool _estado = true;
  bool _exito = false;

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
    final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

    return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 40),
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
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "Nombre",
                                        labelText: "Ingrese Su Nombre",
                                        prefixIcon: const Icon(Icons.account_circle),
                                        fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                        filled: true,
                                        border: InputBorder.none,
                                        labelStyle: TextStyle(
                                            color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                    validator: ( String? value ) {
                                      String exp = r'^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]+(?:\s+[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]+){1,5}(?<!\s)$';
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
                                    style: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Apellido',
                                      labelText: 'Ingrese Su Apellido',
                                      prefixIcon: const Icon(Icons.account_circle),
                                      fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                      filled: true,
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                          color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    validator: ( String? value ) {
                                      String exp = r'^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]+(?:\s+[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]+){1,5}(?<!\s)$';
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
                                    style: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '998746321',
                                      labelText: 'Número de Teléfono',
                                      prefixIcon: const Icon(Icons.phone),
                                      fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                      filled: true,
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                          color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    validator: ( String? value ) {
                                      String exp = r'^[0-9]{9}$';
                                      if (value!.length == 9)
                                      {
                                        if (RegExp(exp).hasMatch(value  ?? '')) {
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
                                    style: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "username@correo.com",
                                        labelText: "Correo",
                                        prefixIcon: const Icon(Icons.mail),
                                        fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                        filled: true,
                                        border: InputBorder.none,
                                        labelStyle: TextStyle(
                                            color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
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
                                    autocorrect: false,
                                    obscureText: true,
                                    style: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '***********',
                                      labelText: 'Contraseña',
                                      prefixIcon: const Icon(Icons.lock_outline),
                                      fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                      filled: true,
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                          color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
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
                                    style: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark   : Login.textInput,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '***********',
                                      labelText: 'Repetir Contraseña',
                                      prefixIcon: const Icon(Icons.lock_outline),
                                      fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                      filled: true,
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                          color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
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
                                _exito ? Container(
                                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: const Text(
                                    "Registrado Correctamente",
                                    style: TextStyle(
                                        fontSize: 20
                                    ),
                                  ),
                                ) : const Text(""),
                                Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: MaterialButton(
                                      onPressed: () async{
                                        _validacion();
                                        if (keyForm.currentState!.validate()) {
                                          if (passController.value == pass2Controller.value) {
                                            addCli(nameController.text, lastNameController.text, phoneController.text,
                                                emailController.text, passController.text);

                                            setState(() {
                                              if (_exito) {
                                                _exito = false;
                                              } else {
                                                _exito = true;
                                              }
                                            });

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
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) =>
                                                  LoginApp(onChanged: widget.onChanged)));
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