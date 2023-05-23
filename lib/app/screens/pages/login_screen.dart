import 'package:flutter/material.dart';
import 'package:proyecto/app/screens/screens.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/app/theme/theme_constants.dart';
import 'package:proyecto/app/theme/theme_colors.dart';
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
        home: LoginScreen(onChanged: onChanged),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final VoidCallback onChanged;

  const LoginScreen({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
          create: ( _ ) => FormProvider(),
          child:_LoginSreenPri(onChanged: onChanged)
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
  //final controller = LoginController();
  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<FormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 60),
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 40
                              ),
                              child: TextFormField(
                                autocorrect: false,
                                keyboardType: TextInputType.emailAddress,
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
                                onChanged: ( value ) => FormProvider().password = value,
                                validator: ( value ) {
                                  return ( value != null && value.length >= 10 )
                                      ? null
                                      : 'La contraseña debe de ser de 10 caracteres';
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                alignment: AlignmentDirectional.centerEnd,
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: TextButton(
                                  onPressed: () {} ,
                                  style: TextButton.styleFrom(
                                    foregroundColor: AdaptiveTheme.of(context).mode.isDark ? Login.textButtonDark : Login.textButton,
                                  ),
                                  child: const Text(
                                    "Olvide mi contraseña",
                                  ),
                                ),
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: MaterialButton(
                                  onPressed: () =>
                                  loginForm.isLoading ? null : () async {
                                    FocusScope.of(context).unfocus();

                                    if( !loginForm.isValidForm() ) return;
                                    loginForm.isLoading = true;
                                    await Future.delayed(const Duration(seconds: 5 ));
                                    loginForm.isLoading = false;

                                    try {
                                      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                          email: emailAddress,
                                          password: password
                                      );
                                    } on FirebaseAuthException catch (e) {
                                      if (e.code == 'user-not-found') {
                                        print('No user found for that email.');
                                      } else if (e.code == 'wrong-password') {
                                        print('Wrong password provided for that user.');
                                      }
                                    }

                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => HomeApp(onChanged: widget.onChanged)));
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


