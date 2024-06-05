import 'package:calculadora/models/calculadora.dart';

class CalculadoraRepositorio {
  double realizarOperacao(Calculadora calculadora) {
    switch (calculadora.operador) {
      case '+':
        return calculadora.primeiroOperando! + calculadora.segundoOperando!;
      case '-':
        return calculadora.primeiroOperando! - calculadora.segundoOperando!;
      case '*':
        return calculadora.primeiroOperando! * calculadora.segundoOperando!;
      case '/':
        return calculadora.primeiroOperando! / calculadora.segundoOperando!;
      case '%':
        return calculadora.primeiroOperando! / 100 * calculadora.segundoOperando!;
      default:
        throw UnsupportedError('Operação não suportada');
    }
  }
}
