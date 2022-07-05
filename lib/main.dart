import 'package:flutter/material.dart';
import 'package:flutter_application_qr/providers/scan_list_provider.dart';
import 'package:flutter_application_qr/providers/ui_provider.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
        ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primaryColor: Colors.purple,
              appBarTheme: const AppBarTheme(color: Colors.purple),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.purple)),
          initialRoute: HomeScreen.routerName,
          routes: {
            HomeScreen.routerName: (context) => const HomeScreen(),
          }),
    );
  }
}
