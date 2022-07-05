import 'package:flutter/material.dart';
import 'package:flutter_application_qr/models/scan_model.dart';
import 'package:flutter_application_qr/providers/db_provider.dart';
import 'package:flutter_application_qr/providers/ui_provider.dart';
import 'package:flutter_application_qr/screens/screens.dart';
import 'package:provider/provider.dart';

import '../components/components.dart';
import '../providers/ui_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routerName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial 2'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete_forever))
        ],
      ),
      bottomNavigationBar: const CustomNavigatorBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: const _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final opcionSeleccionado = uiProvider.selectedMenuOpt;
    //Leer la DB
    final tempScan = ScanModel(valor: 'http://google.com');
    DBProvider.db.getScanAll().then((resp) => print(resp));

    switch (opcionSeleccionado) {
      case 0:
        return const MapasScreen();
      case 1:
        return const DireccionesScreen();
      default:
        return const MapasScreen();
    }
  }
}
