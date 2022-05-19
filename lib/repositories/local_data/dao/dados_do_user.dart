import 'package:imc_flutter/models/dados_do_usuario.dart';
import 'package:sqflite/sqflite.dart';
import '../app_database.dart';

class DadosDoUserDao {
  final String tableSql = 'CREATE TABLE user('
      'id TEXT,'
      'altura TEXT)';

  static const String _tableName = 'user';
  static const String _id = 'id';
  static const String _altura = 'altura';

  Future<List<DadosDoUsuario>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> userDbs =
        await db.rawQuery('SELECT * FROM $_tableName');
    List<DadosDoUsuario> findUser = toListFind(userDbs);

    return findUser;
  }

  List<DadosDoUsuario> toListFind(List<dynamic> findUser) {
    final List<DadosDoUsuario> userList = [];
    for (Map<String, dynamic> userDb in findUser) {
      final DadosDoUsuario user = DadosDoUsuario(
        userDb[_id],
        userDb[_altura],
      );
      userList.add(user);
    }

    return userList;
  }

  Future save(DadosDoUsuario user) async {
    final Database db = await getDatabase();
    Map<String, dynamic> userMap = _toMap(user);
    List<DadosDoUsuario> checkExiste = await verificaSeExiste();
    if (checkExiste.isNotEmpty) {
      return db.update(
        _tableName,
        userMap,
        where: 'id = ?',
        whereArgs: [user.id],
      );
    } else {
      return db.insert(_tableName, userMap);
    }
  }

  Future<List<DadosDoUsuario>> verificaSeExiste() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> aitDBs = await db.rawQuery(
      'SELECT * FROM user',
    );

    List<DadosDoUsuario> users = toListFind(aitDBs);

    return users;
  }

  Map<String, dynamic> _toMap(DadosDoUsuario user) {
    final Map<String, dynamic> userMap = {};
    userMap[_id] = user.id;
    userMap[_altura] = user.altura;

    return userMap;
  }
}
