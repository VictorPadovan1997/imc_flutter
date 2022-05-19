import 'package:flutter/material.dart';
import 'package:imc_flutter/models/consulta_user.dart';
import 'package:imc_flutter/models/dados_do_usuario.dart';
import 'package:imc_flutter/repositories/local_data/dao/consulta_dao.dart';
import 'package:imc_flutter/repositories/local_data/dao/dados_do_user.dart';
import 'package:intl/intl.dart';

void snackBar(context, titulo, {seconds}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(titulo),
      duration: const Duration(
        seconds: 5,
      ),
    ),
  );
}

final DadosDoUserDao usuarioDao = DadosDoUserDao();
final ConsultaDao consultaDao = ConsultaDao();
DadosDoUsuario userList = DadosDoUsuario(
  '',
  '',
);
ConsultaUser consultaUser = ConsultaUser(
  '',
  '',
  '',
  0.0,
  '',
);

getDataAtual() {
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final String formatted = formatter.format(now);

  return formatted;
}
