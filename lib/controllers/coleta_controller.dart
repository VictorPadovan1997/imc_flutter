import 'package:imc_flutter/shared/constantes.dart';

class CalculoImcColeta {
  double calculoImc(altura, peso) {
    double? pesoConvert = double.tryParse(peso);
    double? alturaConvert = double.tryParse(altura);
    alturaConvert = alturaConvert! / 100.0;
    double imc =
        (pesoConvert! / (alturaConvert * alturaConvert)).roundToDouble();

    return imc;
  }
}

class RetornaTipoEmTexto {
  resultadoImc(valorImc) {
    if (valorImc <= 18.8) {
      return 'Abaixo do Peso';
    } else if (valorImc >= 18.5 && valorImc <= 24.9) {
      return 'Peso Normal';
    } else if (valorImc >= 25.0 && valorImc <= 29.9) {
      return "Excesso de Peso";
    } else if (valorImc >= 30) {
      return 'Obeso';
    }
  }
}

class ValidaFormulario {
  String? validaCampoPeso(String? value) {
    var cleanSpace = value!.trim().isEmpty;
    if (cleanSpace) {
      return 'Campo Obrigatorio.';
    }

    return null;
  }
}

class SalvarConsulta {
  save() {
    consultaDao.save(consultaUser);
  }
}
