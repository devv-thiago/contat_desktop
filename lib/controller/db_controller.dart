import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseController {
  late Database database;

  static initDatabase({String path = ""}) async {
    try {
      await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Contatos (
            idContato INTEGER PRIMARY KEY AUTOINCREMENT, 
            displayName TEXT,
            givenName TEXT,
            middleName TEXT,
            prefix TEXT,
            suffix TEXT,
            familyName TEXT,
            company TEXT,
            jobTitle TEXT
          );

          CREATE TABLE Emails (
            idEmail INTEGER PRIMARY KEY AUTOINCREMENT,
            idContato INTEGER,
            emailAdress TEXT,
            FOREIGN KEY (idContato) REFERENCES Contatos(idContato)
          );

          CREATE TABLE Telefones (
            idTelefone INTEGER PRIMARY KEY AUTOINCREMENT,
            idContato INTEGER,
            Telefone TEXT,
            FOREIGN KEY (idContato) REFERENCES Contatos(idContato)
          );
          ''');
      }).whenComplete(() => debugPrint("Banco criado com sucesso"));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
