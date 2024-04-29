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
          CREATE TABLE Grupos (
            idGrupo INTEGER PRIMARY KEY AUTOINCREMENT,
            nomeGrupo TEXT
          );

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
	          emailAdress TEXT PRIMARY KEY UNIQUE NOT NULL,
            idContato INTEGER,
            FOREIGN KEY (idContato) REFERENCES Contatos(idContato)
          );

          CREATE TABLE Telefones (
            Telefone TEXT PRIMARY KEY UNIQUE NOT NULL,
	          idContato INTEGER,
            FOREIGN KEY (idContato) REFERENCES Contatos(idContato)
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

  Future<List<Map<String, dynamic>>> getAllContacts(String nomeTabela) async {
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

  Future insertNewGroup(String nomeGrupo) async {
    try {
      await database
          .rawInsert("INSERT INTO Grupos(nomeGrupo) VALUES ('$nomeGrupo');");
      debugPrint("Grupo cadastrado com sucesso");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future insertNewContact(
    String displayName,
    String company,
    String jobTitle,
  ) async {
    try {
      await database.rawInsert(
          "INSERT INTO Contatos(displayName, company, jobTitle) VALUES ('$displayName', '$company', '$jobTitle');");
      debugPrint("Contato cadastrado com sucesso");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
