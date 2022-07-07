import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/scan_list_provider.dart';

class MapasScreen extends StatelessWidget {
  const MapasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (BuildContext context, int i) {
        return Dismissible(
          key: UniqueKey(),
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (DismissDirection direction) {
            int id = scans[i].id?.toInt() ?? 0;
            Provider.of<ScanListProvider>(context, listen: false)
                .borrarScanPorId(id);
          },
          child: ListTile(
            leading: const Icon(Icons.map),
            title: Text(scans[i].valor),
            subtitle: Text(scans[i].id.toString()),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.pushNamed(context, 'mapa');
            },
          ),
        );
      },
    );
  }
}
