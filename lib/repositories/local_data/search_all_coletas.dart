import 'package:flutter/material.dart';
import 'package:imc_flutter/models/consulta_user.dart';
import 'package:imc_flutter/shared/components/progress.dart';
import 'package:imc_flutter/shared/constantes.dart';
import 'package:imc_flutter/views/historico/lista_coleta.dart';

class SearchAllColetas extends StatelessWidget {
  const SearchAllColetas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ConsultaUser>>(
        future: consultaDao.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Progress(mensagem: 'Carregando...');
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  var data = snapshot.data!;

                  return ListaColetaHistorico(data);
                }
              }
          }
          return ListaColetaHistorico([]);
        },
      ),
    );
  }
}
