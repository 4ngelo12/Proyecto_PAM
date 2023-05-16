import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/theme/theme_constants.dart';
import 'package:proyecto/theme/theme_colors.dart';
import 'package:proyecto/screens/screens.dart';

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

  RegisterScreen({super.key, required this.onChanged});

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 40),
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container (
                    child: Image.asset("Assets/Images/logo.png"),
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                    ),
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
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(25, 35, 25, 10),
                                  child: TextFormField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
                                    ),

                                    decoration: InputDecoration(
                                        hintText: "Nombre",
                                        labelText: "Ingrese Su Nombre",
                                        prefixIcon: Icon(Icons.account_circle),
                                        fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                        filled: true,
                                        border: InputBorder.none,
                                        labelStyle: TextStyle(
                                            color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                    validator: ( value ) {
                                      String pattern = r'^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]+(?:\s+[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]+){1,5}(?<!\s)$';
                                      RegExp regExp  = new RegExp(pattern);

                                      return regExp.hasMatch(value ?? '')
                                          ? null
                                          : 'No se admiten esos caracteres en el nombre';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: TextFormField(
                                    autocorrect: false,
                                    style: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Apellido',
                                      labelText: 'Ingrese Su Apellido',
                                      prefixIcon: Icon(Icons.account_circle),
                                      fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                      filled: true,
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                          color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    validator: ( value ) {
                                      String pattern = r'^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]+(?:\s+[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]+){1,5}(?<!\s)$';
                                      RegExp regExp  = new RegExp(pattern);

                                      return regExp.hasMatch(value ?? '')
                                          ? null
                                          : 'No se admiten esos caracteres en el apellido';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: TextFormField(
                                    autocorrect: false,
                                    style: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '998746321',
                                      labelText: 'Número de Teléfono',
                                      prefixIcon: Icon(Icons.phone),
                                      fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                      filled: true,
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                          color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    validator: ( value ) {
                                      String pattern = '[0-9]{9}';
                                      RegExp regExp  = new RegExp(pattern);

                                      return regExp.hasMatch(value ?? '')
                                          ? null
                                          : 'No se admiten esos caracteres en el apellido';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: TextFormField(
                                    autocorrect: false,
                                    style: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
                                    ),
                                    decoration: InputDecoration(
                                        hintText: "username@correo.com",
                                        labelText: "Correo",
                                        prefixIcon: Icon(Icons.mail),
                                        fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                        filled: true,
                                        border: InputBorder.none,
                                        labelStyle: TextStyle(
                                            color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                    validator: ( value ) {
                                      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regExp  = new RegExp(pattern);

                                      return regExp.hasMatch(value ?? '')
                                          ? null
                                          : 'El valor ingresado no luce como un correo';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: TextFormField(
                                    autocorrect: false,
                                    obscureText: true,
                                    style: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '***********',
                                      labelText: 'Contraseña',
                                      prefixIcon: Icon(Icons.lock_outline),
                                      fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                      filled: true,
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                          color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    validator: ( value ) {
                                      return ( value != null && value.length >= 10 )
                                          ? null
                                          : 'La contraseña debe de ser de 10 caracteres';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10
                                  ),
                                  child: TextFormField(
                                    autocorrect: false,
                                    obscureText: true,
                                    style: TextStyle(
                                      color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '***********',
                                      labelText: 'Repetir Contraseña',
                                      prefixIcon: Icon(Icons.lock_outline),
                                      fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                      filled: true,
                                      border: InputBorder.none,
                                      labelStyle: TextStyle(
                                          color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    validator: ( value ) {
                                      return ( value != null && value.length >= 10 )
                                          ? null
                                          : 'La contraseña debe de ser de 10 caracteres';
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(30),
                                  child: MaterialButton(
                                      onPressed: () {},
                                      child: Text('Registrar',
                                        style: TextStyle(
                                            fontSize: 25
                                        ),
                                      ),
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
                                      )
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10,
                                          horizontal: 0),
                                      child: Text("¿Ya estas registrado?"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10,
                                          horizontal: 0),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) =>
                                                  LoginApp(onChanged: widget.onChanged)));
                                        },
                                        child: Text("Inicie Sesión"),
                                        style: TextButton.styleFrom(
                                          foregroundColor: AdaptiveTheme.of(context).mode.isDark ? Login.textButtonDark : Login.textButton,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                        )
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