import 'package:flutter/material.dart';
import 'package:proyecto/app/screens/screens.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/app/theme/themes.dart';
import 'package:proyecto/app/providers/form_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final VoidCallback onChanged;

  const LoginApp({
    super.key,
    this.savedThemeMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.lightTheme,
      dark: AppTheme.darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login',
        theme: theme,
        darkTheme: darkTheme,
        home: ChangeNotifierProvider(
            create: ( _ ) => FormProvider(),
            child:_LoginSreenPri(onChanged: onChanged)
        )
      ),
    );
  }
}

class _LoginSreenPri extends StatefulWidget {
  final VoidCallback onChanged;

  const _LoginSreenPri({required this.onChanged});

  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<_LoginSreenPri> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool _estado = true;
  bool _error = false;
  String _mensaje = '';

  void _validacion() {
    setState(() {
      if (_estado) {
        _estado = false;
      } else {
        _estado = true;
      }
    });
  }

  //final controller = LoginController();
  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<FormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 75, bottom: 20),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                        key: loginForm.formKey,
                        autovalidateMode: _estado ? AutovalidateMode.disabled : AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 40
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
                                onChanged: ( value ) => FormProvider().email = value,
                                validator: ( value ) {
                                  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regExp  = RegExp(pattern);

                                  return regExp.hasMatch(value ?? '')
                                      ? null
                                      : 'El valor ingresado no luce como un correo';
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 25),
                              child: TextFormField(
                                controller: passController,
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
                                onChanged: ( value ) => FormProvider().password = value,
                                validator: ( value ) {
                                  return ( value != null && value.length >= 10 )
                                      ? null
                                      : 'La contraseña debe de ser de 10 caracteres';
                                },
                              ),
                            ),

                            _error ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 25
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 15
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red
                                ),
                                child: Text(
                                  _mensaje,
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ): const Text(""),
                            Container(
                              alignment: AlignmentDirectional.centerEnd,
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          RecoveryApp(onChanged: widget.onChanged)));
                                } ,
                                style: TextButton.styleFrom(
                                  foregroundColor: AdaptiveTheme.of(context).mode.isDark ? Login.textButtonDark : Login.textButton,
                                ),
                                child: const Text(
                                  "Olvide mi contraseña",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: MaterialButton(
                                  onPressed:loginForm.isLoading ? null : () async {
                                      _validacion();
                                      FocusScope.of(context).unfocus();

                                      if (!loginForm.isValidForm()) return;
                                      loginForm.isLoading = true;
                                      await Future.delayed(
                                          const Duration(seconds: 2));
                                      loginForm.isLoading = false;

                                      try {

                                        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passController.text
                                        );
                                        if (credential != null) {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HomeApp(onChanged: widget
                                                          .onChanged)));
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        setState(() {
                                          if (e.code == 'user-not-found') {
                                            _mensaje = 'El correo ingresado no esta registrado';
                                            _error = true;
                                          } else if (e.code == 'wrong-password') {
                                            _mensaje = 'La contraseña es incorrecta';
                                            _error = true;
                                          } else {
                                            _mensaje = '';
                                            _error = false;
                                          }
                                        });
                                      }
                                  },
                                  color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                                  disabledColor: AdaptiveTheme.of(context).mode.isDark ? Login.disableButtonDark : Login.disableButton,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 55,
                                      vertical: 18
                                  ),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10)
                                      )
                                  ),
                                child: Text(
                                  loginForm.isLoading
                                      ? 'Verificando..'
                                      : 'Iniciar Sesión',
                                  style: const TextStyle(
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
                                  child: Text("¿No tiene una cuenta?"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10,
                                      horizontal: 0),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) =>
                                              RegisterApp(onChanged: widget.onChanged)));
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: AdaptiveTheme.of(context).mode.isDark ? Login.textButtonDark : Login.textButton,
                                    ),
                                    child: const Text("Registrarse"),
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
            ],
          ),
        )
      )
    );
  }
}


