import 'package:flutter/material.dart';
import 'package:imc_flutter/models/dados_do_usuario.dart';
import 'package:imc_flutter/shared/components/progress.dart';
import 'package:imc_flutter/shared/constantes.dart';
import 'package:imc_flutter/views/informar_altura.dart';
import 'package:imc_flutter/views/inicio.dart';

class CheckUserInsetHeight extends StatelessWidget {
  const CheckUserInsetHeight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<DadosDoUsuario>>(
        future: usuarioDao.findAll(),
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
                  var data = snapshot.data![0].altura;
                  userList.altura = data;

                  return const InicioScreen();
                }
              }
          }
          return const InformarAltura();
        },
      ),
    );
  }
}
