import 'package:flutter/material.dart';
import 'package:proyecto/app/theme/themes.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyecto/app/screens/screens.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const ContactApp({
    super.key,
    this.savedThemeMode,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme.lightTheme,
      dark: AppTheme.darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Contacto',
        theme: theme,
        darkTheme: darkTheme,
        home: ContactScreen(),
      ),
    );
  }
}

class ContactScreen extends StatefulWidget {

  const ContactScreen({super.key});

  @override
  _ContactScreen createState() => _ContactScreen();
}

class _ContactScreen extends State<ContactScreen> {

  void sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'destinatario@example.com',
      queryParameters: {
        'subject': 'Asunto del correo',
        'body': 'Contenido del correo',
      },
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'No se pudo abrir el correo.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) =>
                        HomeApp()));
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: AdaptiveTheme.of(context).mode.isDark ? General.generalBlueDark : General.generalBlue,
                ),
                child:Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Text(
                        "¿Necestias Ayuda?",
                        style: TextStyle(fontSize: 35),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Puedes comunicarte con nosotros por estos medios",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
            ),
            Link(
              uri: Uri.parse('https://wa.me/993412022'),
              target: LinkTarget.blank,
              builder: (BuildContext ctx, FollowLink? openLink) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: ElevatedButton(
                        onPressed: openLink,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        backgroundColor: AdaptiveTheme.of(context).mode.isDark ? General.botonContactoDark : General.botonContacto,
                        foregroundColor: AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                      ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                             Text(
                                "Comunicarse por Whatsapp",
                               style: TextStyle(
                                 fontSize: 20
                               ),
                             ),
                            Icon(FontAwesomeIcons.whatsapp)
                          ],
                        ),
                    ),
                  ),
                );
                },
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 95),
              child: ElevatedButton(
                onPressed: () {
                  sendEmail();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  backgroundColor: AdaptiveTheme.of(context).mode.isDark ? General.botonContactoDark : General.botonContacto,
                  foregroundColor:   AdaptiveTheme.of(context).mode.isDark ? General.textInputDark : General.textInput,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Text(
                      "Enviar correo",
                      style: TextStyle(
                          fontSize: 20
                      ),
                    ),
                    Icon(FontAwesomeIcons.envelope)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


