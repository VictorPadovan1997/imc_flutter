import 'package:flutter/material.dart';
import 'package:imc_flutter/controllers/historico_controller.dart';
import 'package:imc_flutter/models/consulta_user.dart';

class ListaColetaHistorico extends StatefulWidget {
  final List<ConsultaUser> consultaUserListHistorico;
  ListaColetaHistorico(
    this.consultaUserListHistorico,
  );
  @override
  _ListaColetaHistoricoState createState() => _ListaColetaHistoricoState();
}

class _ListaColetaHistoricoState extends State<ListaColetaHistorico> {
  RemoveHistoricoSqlite removeHistoricoSqlite = RemoveHistoricoSqlite();
  RemoveHistocioList removeHistocioList = RemoveHistocioList();
  @override
  Widget build(BuildContext context) {
    var listaHistorico = widget.consultaUserListHistorico;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Historico',
        ),
      ),
      body: Container(
        child: listaHistorico.length == 0
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(
                      80.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                      child: Text(
                        'Historico Vazio',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listaHistorico.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey[300]!,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              trailing: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    removeHistoricoSqlite.delete(
                                      listaHistorico,
                                      index,
                                    );
                                    removeHistocioList.remove(
                                      listaHistorico,
                                      index,
                                    );
                                  });
                                },
                                child: Wrap(
                                  children: <Widget>[
                                    Icon(
                                      Icons.delete_forever_rounded,
                                      color: Colors.red,
                                      size: 35,
                                    ),
                                  ],
                                ),
                              ),
                              title: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Data: " + listaHistorico[index].data,
                                      style: TextStyle(
                                        color: Color(0xff595757),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "Peso: " + listaHistorico[index].peso,
                                      style: TextStyle(
                                        color: Color(0xff595757),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "IMC: " +
                                          listaHistorico[index]
                                              .valorimc
                                              .toString(),
                                      style: TextStyle(
                                        color: Color(0xff595757),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                    Text(
                                      "Resultado: " +
                                          listaHistorico[index].resultadoimc,
                                      style: TextStyle(
                                        color: Color(0xff595757),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
