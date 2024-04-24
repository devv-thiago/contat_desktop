import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseController {
  late Database database;

  static final DatabaseController _instance = DatabaseController._internal();

  factory DatabaseController() {
    return _instance;
  }

  DatabaseController._internal();

  static Future<void> initDatabase({String path = ""}) async {
    try {
      _instance.database = await openDatabase(path, version: 1,
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
            jobTitle TEXT,
            idGrupo INTEGER,
            FOREIGN KEY (idGrupo) REFERENCES Grupos(idGrupo)
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

          CREATE TABLE Grupos (
            idGrupo INTEGER PRIMARY KEY AUTOINCREMENT,
            nomeGrupo TEXT
          );
        ''');
      });
      debugPrint("Banco criado com sucesso");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>> getAllRecords(String nomeTabela) async {
    List<Map<String, dynamic>> result =
        await database.rawQuery('SELECT * FROM $nomeTabela');

    return result;
  }

  Future deleteGroup(int idGrupo) async {
    try {
      await database
          .rawDelete("DELETE FROM Grupos WHERE Grupos.idGrupo = $idGrupo");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future insertNewGroup(String nomeTabela, String nomeGrupo) async {
    try {
      await database
          .rawInsert("INSERT INTO Grupos(nomeGrupo) VALUES ('$nomeGrupo');");
      debugPrint("Grupo cadastrado com sucesso");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future insertNewContact(String nomeTabela, String nomeGrupo) async {
    try {
      await database
          .rawInsert("INSERT INTO Contatos(nomeGrupo) VALUES ('$nomeGrupo');");
      debugPrint("Grupo cadastrado com sucesso");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
