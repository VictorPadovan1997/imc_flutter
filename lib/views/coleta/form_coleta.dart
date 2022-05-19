import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imc_flutter/controllers/coleta_controller.dart';
import 'package:imc_flutter/shared/constantes.dart';
import '../Inicio.dart';

class FormColeta extends StatefulWidget {
  @override
  _FormColetaState createState() => _FormColetaState();
}

class _FormColetaState extends State<FormColeta> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  double resultadoCalculoIMC = 0.0;
  String textoResultado = '';
  bool visibleResult = false;
  bool disabledFieldPeso = false;
  String nameButton = 'Calcular';

  @override
  Widget build(BuildContext context) {
    String userAltura = userList.altura.toString();
    alturaController.text = userAltura;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: LayoutBuilder(
        builder: (context, constaints) => SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 1.0, 30.0, 20.0),
                  child: Text(
                    'Nova Coleta',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40.0,
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
                        child: TextFormField(
                          readOnly: true,
                          controller: alturaController,
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 5.0),
                            labelText: 'Altura',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
                        child: TextFormField(
                          readOnly: disabledFieldPeso,
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          validator: validaCampoPeso,
                          controller: pesoController,
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 5.0),
                            labelText: 'Peso (KG)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: visibleResult,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(15.0, 1.0, 15.0, 30.0),
                          child: Card(
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Resultado: ' + textoResultado,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text(
                                    resultadoCalculoIMC.toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: InkWell(
          onTap: () async {
            if (nameButton == 'Calcular' && _formKey.currentState!.validate()) {
              double valorImc = calculoImc(
                alturaController.text,
                pesoController.text,
              );
              consultaUser.valorimc = valorImc;
              var resultadoTextImc = resultadoImc(valorImc);
              consultaUser.resultadoimc = resultadoTextImc;
              acionaSnackBar(
                context,
                'Clique em "Finalizar" para salvar no Historico.',
              );
              setState(() {
                visibleResult = true;
                resultadoCalculoIMC = valorImc;
                textoResultado = resultadoTextImc;
                disabledFieldPeso = true;
                nameButton = 'Finalizar';
              });
            } else {
              consultaUser.peso = pesoController.text;
              consultaUser.data = getDataAtual();
              await saveConsulta();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const InicioScreen()),
                (Route<dynamic> route) => false,
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
            child: Text(
              nameButton,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: nameButton == 'Finalizar'
                    ? Colors.green
                    : Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void acionaSnackBar(BuildContext context, mensagem) {
    snackBar(
      context,
      mensagem,
    );
  }
}
