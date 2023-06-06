import 'dart:io';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyecto/app/theme/themes.dart';
import 'package:proyecto/app/screens/screens.dart';
import 'package:image/image.dart' as imga;
import 'package:proyecto/app/services/firebase_service.dart';

class RegisProdApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  final VoidCallback onChanged;

  const RegisProdApp({
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
        title: 'Comprar',
        theme: theme,
        darkTheme: darkTheme,
        home: RegisProdScreen(onChanged: onChanged),
      ),
    );
  }
}

class RegisProdScreen extends StatefulWidget {
  final VoidCallback onChanged;

  const RegisProdScreen({super.key, required this.onChanged});

  @override
  _RegisProdScreen createState() => _RegisProdScreen();
}

class _RegisProdScreen extends State<RegisProdScreen> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController descController = TextEditingController();
  File? img;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: nombreController,
                  autocorrect: false,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
                  ),
                  decoration: InputDecoration(
                      hintText: "username@correo.com",
                      labelText: "Nombre",
                      prefixIcon: const Icon(FontAwesomeIcons.font),
                      fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                      filled: true,
                      border: InputBorder.none,
                      labelStyle: TextStyle(
                          color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: precioController,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
                  ),
                  decoration: InputDecoration(
                      hintText: "55.5",
                      labelText: "Precio",
                      prefixIcon: const Icon(FontAwesomeIcons.font),
                      fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                      filled: true,
                      border: InputBorder.none,
                      labelStyle: TextStyle(
                          color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  maxLines: 10,
                  controller: descController,
                  autocorrect: false,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(
                    color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
                  ),
                  decoration: InputDecoration(
                      hintText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam id vulputate nibh.",
                      labelText: "Descipcion",
                      prefixIcon: const Icon(FontAwesomeIcons.font),
                      fillColor: AdaptiveTheme.of(context).mode.isDark ? General.containerDark : General.container,
                      filled: true,
                      border: InputBorder.none,
                      labelStyle: TextStyle(
                          color: AdaptiveTheme.of(context).mode.isDark ? Login.textInputDark : Login.textInput,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ),
              ),
              Column(
                children: [
                  img != null ? Image.file(img!) : Container(
                    margin: const EdgeInsets.all(20),
                    height: 200,
                    width: double.infinity,
                    color: Colors.red,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: ElevatedButton(
                      onPressed: () async {

                        final image = await getImage();
                        setState(() {
                          img = File(image!.path);
                        });
                      },
                      child: const Text("Selecciona una imagen"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () async{
                        if (img == null) {
                          return;
                        }

                        final uploaded = await uploadImg(img!, nombreController.text,double.parse(precioController.text), descController.text);

                        if(uploaded) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Imagen subida correctamente"))
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Hubo en error"))
                          );
                        }
                      },
                      child: const Text("Subir a FireStore"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}