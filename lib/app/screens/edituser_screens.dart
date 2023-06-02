import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:proyecto/app/services/cliente_service.dart';
import 'package:proyecto/app/theme/theme_constants.dart';
import 'package:proyecto/app/theme/theme_colors.dart';
import 'package:proyecto/app/screens/screens.dart';

class EditUserApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final VoidCallback onChanged;

  const EditUserApp({
    super.key,
    this.savedThemeMode,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.lightTheme,
      dark: AppTheme.darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Editar Usuario',
        theme: theme,
        darkTheme: darkTheme,
        home: EditUserScreen(onChanged: onChanged),
      ),
    );
  }
}

class EditUserScreen extends StatefulWidget {
  final VoidCallback onChanged;

  const EditUserScreen({super.key, required this.onChanged});

  @override
  _EditUserScreen createState() => _EditUserScreen();
}

class _EditUserScreen extends State<EditUserScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
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
    final GlobalKey<FormState> keyForm = GlobalKey<FormState>();

    return Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 40),
          child: Center(
              child: FutureBuilder(
                  future: getClientesId(user!.uid),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      nameController.text = snapshot.data?[0]['nombre'];
                      lastNameController.text = snapshot.data?[0]['apellido'];
                      phoneController.text = snapshot.data?[0]['telefono'];
                      emailController.text = snapshot.data?[0]['email'];

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) =>
                                            HomeApp(onChanged: widget.onChanged, pocision: 2)));
                                  },
                                  icon: Icon(Icons.arrow_back_ios_new)
                              )
                            ],
                          ),
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
                                              color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
                                            ),
                                            decoration: InputDecoration(
                                                hintText: "Nombre",
                                                labelText: "Ingrese Su Nombre",
                                                prefixIcon: const Icon(Icons.account_circle),
                                                fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                                filled: true,
                                                border: InputBorder.none,
                                                labelStyle: TextStyle(
                                                    color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
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
                                              color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: 'Apellido',
                                              labelText: 'Ingrese Su Apellido',
                                              prefixIcon: const Icon(Icons.account_circle),
                                              fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                              filled: true,
                                              border: InputBorder.none,
                                              labelStyle: TextStyle(
                                                  color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
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
                                              color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
                                            ),
                                            decoration: InputDecoration(
                                              hintText: '998746321',
                                              labelText: 'Número de Teléfono',
                                              prefixIcon: const Icon(Icons.phone),
                                              fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                              filled: true,
                                              border: InputBorder.none,
                                              labelStyle: TextStyle(
                                                  color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
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
                                              color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
                                            ),
                                            decoration: InputDecoration(
                                                hintText: "username@correo.com",
                                                labelText: "Correo",
                                                prefixIcon: const Icon(Icons.mail),
                                                fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                                                filled: true,
                                                border: InputBorder.none,
                                                labelStyle: TextStyle(
                                                    color: AdaptiveTheme.of(context).mode.isLight ? Login.textInput : Login.textInputDark,
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
                                          padding: const EdgeInsets.all(30),
                                          child: MaterialButton(
                                            onPressed: () async{

                                              _validacion();
                                              if (keyForm.currentState!.validate()) {
                                                await editData(user!.uid, nameController.text, lastNameController.text, phoneController.text,
                                                    emailController.text);
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
                                            child: const Text('Guardar',
                                              style: TextStyle(
                                                  fontSize: 25
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                )
                              ],
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 40))
                        ],
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })
              )
          ),
        )
    );
  }

}