import 'package:imc_flutter/repositories/local_data/dao/consulta_dao.dart';
import 'package:imc_flutter/repositories/local_data/dao/dados_do_user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'banco_sqlite.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(ConsultaDao().tableSql);
      db.execute(DadosDoUserDao().tableSql);
    },
    version: 1,
  );
}
