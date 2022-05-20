import 'package:imc_flutter/repositories/local_data/dao/dados_do_user.dart';
import 'package:imc_flutter/shared/constantes.dart';

class AlturaController {
  void saveAltura(value) {
    DadosDoUserDao userDao = DadosDoUserDao();
    userList.altura = value;
    userDao.save(userList);
  }
}
