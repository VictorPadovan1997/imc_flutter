import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imc_flutter/controllers/altura_controller.dart';
import 'package:imc_flutter/shared/constantes.dart';
import 'package:imc_flutter/views/Inicio.dart';
import 'package:lottie/lottie.dart';

class InformarAltura extends StatelessWidget {
  const InformarAltura({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController alturaController = TextEditingController();

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
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(90.0, 1, 90.0, 10.0),
                  child: Lottie.asset('assets/height.json'),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 2.0, 30.0, 20.0),
                  child: Text(
                    'Informe sua Altura para continuarmos.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
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
                            const EdgeInsets.fromLTRB(16.0, 18.0, 16.0, 16.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          maxLength: 3,
                          controller: alturaController,
                          textInputAction: TextInputAction.done,
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
            if (alturaController.text == '') {
              snackBar(
                context,
                'É obrigatorio informar sua altura para continuarmos',
              );
            }
            if (_formKey.currentState!.validate()) {
              saveAltura(alturaController.text);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const InicioScreen()),
                (Route<dynamic> route) => false,
              );
            }
          },
          child: const Padding(
            padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
            child: Text(
              'Continuar',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
