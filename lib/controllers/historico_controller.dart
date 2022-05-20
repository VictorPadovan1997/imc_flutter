import 'package:imc_flutter/models/consulta_user.dart';
import 'package:imc_flutter/shared/constantes.dart';

class RemoveHistoricoSqlite {
  void delete(List<ConsultaUser> listaHistorico, int index) {
    consultaDao.delete(listaHistorico[index].id);
  }
}

class RemoveHistocioList {
  void remove(List<ConsultaUser> listaHistorico, int index) {
    listaHistorico.remove(listaHistorico[index]);
  }
}
