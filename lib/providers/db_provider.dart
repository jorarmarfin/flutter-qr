import 'dart:io';

import 'package:flutter_application_qr/models/scan_model.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database?
      _database; // el signo ? nos permite apuntar a una variable objeto o null:
  static final DBProvider db = DBProvider._();

  DBProvider._();
  Future<Database> get database async => _database ??= await initDB();
  //El ??=operador verificará si _databasees nully lo establecerá en el valor
  //de await _initiateDatabase()si ese es el caso y luego devolverá el nuevo
  //valor de _database. Si _databaseya tiene un valor, simplemente se devolverá.

  Future<Database> initDB() async {
    //Path donde almacenamos la DB
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = p.join(documentsDirectory.path, 'ScansDB.db');

    //crear DB
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT

        )
      ''');
    });
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;
    //verifica DB
    final db = await database;
    final res = await db.rawInsert('''
      INSERT INTO Scan(id,tipo,valor)
      VALUES($id,'$tipo','$valor')
     ''');
    return res;
  }

  nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());

    return res;
  }

  Future<ScanModel?> getScanById(int i) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id=?', whereArgs: [i]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getScanByType(String tipo) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipo=?', whereArgs: [tipo]);

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<List<ScanModel>> getScanAll() async {
    final db = await database;
    final res = await db.query(
      'Scans',
    );

    return res.isNotEmpty ? res.map((e) => ScanModel.fromJson(e)).toList() : [];
  }

  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id=?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');
    return res;
  }
}
