import 'package:elegant_notification/elegant_notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:provider/provider.dart';
import 'package:proyecto/app/screens/principal_screen.dart';
import 'package:proyecto/app/theme/themes.dart';
import 'package:intl/intl.dart';
import '../providers/pago_provider.dart';
import '../services/ventas_service.dart';

class PagoApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final double total;

  const PagoApp({
    super.key,
    this.savedThemeMode,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.lightTheme,
      dark: AppTheme.darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pago',
          theme: theme,
          darkTheme: darkTheme,
          home: ChangeNotifierProvider(
              create: ( _ ) => PagoProvider(),
              child: PagoSreen(total: total)
          )
      ),
    );
  }
}

class PagoSreen extends StatefulWidget {
  final double total;

  const PagoSreen({super.key, required this.total});

  @override
  _PagoSreen createState() => _PagoSreen();
}

class _PagoSreen extends State<PagoSreen> {
  TextEditingController controllerTitular = TextEditingController();
  TextEditingController controllerCard = TextEditingController();
  TextEditingController controllerFecha = TextEditingController();
  TextEditingController controllerCVV = TextEditingController();

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
    DateTime now = DateTime.now();
    final _user = FirebaseAuth.instance.currentUser;

    // Formatea la fecha usando el paquete intl
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    final PayForm = Provider.of<PagoProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                            const HomeApp()));
                      },
                      padding: const EdgeInsets.only(left: 30),
                      icon: const Icon(Icons.arrow_back_ios_new))
                ],
              ),
            ),
            Container (
              width: 350,
              margin: const EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
              ),
              child: Image.asset("Assets/Images/logo.png"),
            ),
            Form(
              key: PayForm.formKey,
              autovalidateMode: _estado ? AutovalidateMode.disabled : AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      controller: controllerTitular,
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                      ),
                      decoration: InputDecoration(
                          hintText: "Ej. Miguel Castro",
                          labelText: "Títular de la Tarjeta",
                          prefixIcon: const Icon(Icons.account_circle),
                          fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                          filled: true,
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                              color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      onChanged: ( value ) => PagoProvider().titular = value,
                      validator: ( String? value ) {
                        String exp = r'^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ]';
                        return RegExp(exp).hasMatch(value  ?? '')? null : 'No se admiten esos caracteres en el nombre';
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    child: TextFormField(
                      controller: controllerCard,
                      autocorrect: false,
                      keyboardType: TextInputType.number,
                      maxLength: 16,
                      style: TextStyle(
                        color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                      ),
                      decoration: InputDecoration(
                          hintText: "XXXX XXXX XXXX XXXX",
                          labelText: "Número de Tarjeta",
                          prefixIcon: const Icon(Icons.payment),
                          fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                          filled: true,
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                              color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      onChanged: ( value ) => PagoProvider().numTarjeta = value,
                      validator: ( String? value ) {
                        String exp = r'[0-9]{15,16}|(([0-9]{4}\s){3}[0-9]{3,4})';
                        return RegExp(exp).hasMatch(value  ?? '')? null : 'Número de Tarjeta Invalido';
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: const EdgeInsets.only(left: 30),
                        child: TextFormField(
                          controller: controllerFecha,
                          autocorrect: false,
                          keyboardType: TextInputType.datetime,
                          maxLength: 7,
                          style: TextStyle(
                            color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                          ),
                          decoration: InputDecoration(
                              hintText: "MM/YYYY",
                              labelText: "Fecha de vencimiento",
                              prefixIcon: const Icon(Icons.date_range),
                              fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                              filled: true,
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                  color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                          onChanged: ( value ) => PagoProvider().fecha = value,
                          validator: ( String? value ) {
                            String exp = r'^([0-1][0-2]|0[0-1]|1[0-1])(\/)([2-9][0-9][2-9][4-9])$';
                            return RegExp(exp).hasMatch(value  ?? '')? null : 'Fecha invalida';
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          controller: controllerCVV,
                          autocorrect: false,
                          keyboardType: TextInputType.datetime,
                          maxLength: 3,
                          style: TextStyle(
                            color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                          ),
                          decoration: InputDecoration(
                              hintText: "Ej. 123",
                              labelText: "CVV",
                              prefixIcon: const Icon(Icons.password),
                              fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                              filled: true,
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                  color: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                                  fontWeight: FontWeight.bold
                              )
                          ),
                          onChanged: ( value ) => PagoProvider().cvv = value,
                          validator: ( String? value ) {
                            String exp = r'^[0-9]{3}';
                            return RegExp(exp).hasMatch(value  ?? '')? null : 'CVV Invalido';
                          },
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  ElevatedButton(
                    onPressed: PayForm.isLoading ? null : () async{
                      _validacion();
                      FocusScope.of(context).unfocus();

                      if (!PayForm.isValidForm()) return;
                      PayForm.isLoading = true;

                      await Future.delayed(
                          const Duration(seconds: 4));
                      PayForm.isLoading = false;
                      crearVenta(_user!.uid, widget.total, formattedDate);
                      ElegantNotification.success(
                          background: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                          title: const Text(
                              "Operación Completada"
                          ),
                          description: const Text("Tu pago se ha completado"),
                          toastDuration:const Duration(seconds: 8)).show(context);
                      },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 70),
                      backgroundColor: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                    ),
                    child: Text(
                      PayForm.isLoading
                          ? 'Verificando...'
                          : 'Realizar Pago',
                      style: const TextStyle(
                        fontSize: 20
                      ),
                    ),
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
