import 'package:imc_flutter/models/consulta_user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../app_database.dart';

class ConsultaDao {
  final String tableSql = 'CREATE TABLE consulta('
      'id TEXT,'
      'data TEXT,'
      'peso TEXT,'
      'valorimc double,'
      'resultadoimc TEXT)';

  static const String _tableName = 'consulta';
  static const String _id = 'id';
  static const String _data = 'data';
  static const String _peso = 'peso';
  static const String _valorimc = 'valorimc';
  static const String _resultadoimc = 'resultadoimc';

  Future<List<ConsultaUser>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> consultaDbs =
        await db.rawQuery('SELECT * FROM $_tableName');
    List<ConsultaUser> consulta = toListFind(consultaDbs);

    return consulta;
  }

  List<ConsultaUser> toListFind(List<dynamic> consultaDbs) {
    final List<ConsultaUser> consultasList = [];
    for (Map<String, dynamic> consultaDb in consultaDbs) {
      final ConsultaUser estado = ConsultaUser(
        consultaDb[_id],
        consultaDb[_data],
        consultaDb[_peso],
        consultaDb[_valorimc],
        consultaDb[_resultadoimc],
      );
      consultasList.add(estado);
    }

    return consultasList;
  }

  Future<ConsultaUser> save(ConsultaUser consulta) async {
    var uuid = Uuid();
    final Database db = await getDatabase();
    Map<String, dynamic> consultaMap = _toMap(consulta);
    db.insert(
      _tableName,
      consultaMap,
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    consulta.id = uuid.v4();

    return consulta;
  }

  void delete(id) async {
    final Database db = await getDatabase();
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Map<String, dynamic> _toMap(ConsultaUser consulta) {
    final Map<String, dynamic> consultaMap = {};
    consultaMap[_id] = consulta.id;
    consultaMap[_data] = consulta.data;
    consultaMap[_peso] = consulta.peso;
    consultaMap[_valorimc] = consulta.valorimc;
    consultaMap[_resultadoimc] = consulta.resultadoimc;

    return consultaMap;
  }
}
