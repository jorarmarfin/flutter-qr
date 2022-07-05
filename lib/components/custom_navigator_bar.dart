import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ui_provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  const CustomNavigatorBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final opcionSeleccionado = uiProvider.selectedMenuOpt;
    return BottomNavigationBar(
        currentIndex: opcionSeleccionado,
        onTap: (int i) => uiProvider.selectedMenuOpt = i,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.map,
              ),
              label: 'Mapa'),
          BottomNavigationBarItem(
              icon: Icon(Icons.compass_calibration), label: 'Direcciones'),
        ]);
  }
}
