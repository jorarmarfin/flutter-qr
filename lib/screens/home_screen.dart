import 'package:flutter/material.dart';
import 'package:flutter_application_qr/providers/ui_provider.dart';
import 'package:flutter_application_qr/screens/screens.dart';
import 'package:provider/provider.dart';

import '../components/components.dart';
import '../providers/scan_list_provider.dart';
import '../providers/ui_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routerName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial', ),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ScanListProvider>(context, listen: false)
                    .borarTodos();
              },
              icon: const Icon(Icons.delete_forever))
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
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (opcionSeleccionado) {
      case 0:
        scanListProvider.cargarScanPorTipo('geo');
        return const MapasScreen();
      case 1:
        scanListProvider.cargarScanPorTipo('http');
        return const DireccionesScreen();
      default:
        return const MapasScreen();
    }
  }
}
