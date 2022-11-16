import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rasil_whatsapp/State/home_page_provider.dart';
import 'package:rasil_whatsapp/State/send_from_file_provider.dart';
import 'package:rasil_whatsapp/screens/home_page.dart';
import 'package:rasil_whatsapp/screens/send_from_file.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowManager.instance.setMinimumSize(const Size(1200, 750));

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomePageProvider(),
          builder: (context, _) => MyApp(),
        ),
        ChangeNotifierProvider(
          create: (context) => SendMessageFromFileProvider(),
          builder: (context, _) => SendFromFile(),
        )
      ],
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageProvider(),
      child: MaterialApp(
        title: 'جيبي',
        // ignore: prefer_const_literals_to_create_immutables
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', ''),
        ],
        home: HomePage(),
      ),
    );
  }
}
