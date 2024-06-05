import 'package:flutter/foundation.dart';
import 'package:calculadora/models/calculadora.dart';
import 'package:calculadora/repositories/calculadora_repositorio.dart';

class CalculadoraProvider extends ChangeNotifier {
  String _display = '';
  List<String> _historico = [];

  String get display => _display;
  List<String> get historico => _historico;

  void input(String value) {
    if (value == 'C') {
      _display = '';
    } else if (value == 'DEL') {
      _display = _display.isNotEmpty ? _display.substring(0, _display.length - 1) : '';
    } else if (value == '=') {
      try {
        final calculadora = _parseInput(_display);
        final resultado = CalculadoraRepositorio().realizarOperacao(calculadora);
        _historico.add('$_display = $resultado');
        _display = resultado.toString();
      } catch (e) {
        _display = 'Erro';
      }
    } else {
      _display += value;
    }
    notifyListeners();
  }

  void limparHistorico() {
    _historico.clear();
    notifyListeners();
  }

  Calculadora _parseInput(String input) {
    final regex = RegExp(r'(\d+\.?\d*)([\+\-\*\/\%])(\d+\.?\d*)');
    final match = regex.firstMatch(input);
    if (match != null) {
      final primeiroOperando = double.parse(match.group(1)!);
      final operador = match.group(2)!;
      final segundoOperando = double.parse(match.group(3)!);
      return Calculadora(
        primeiroOperando: primeiroOperando,
        segundoOperando: segundoOperando,
        operador: operador,
      );
    } else {
      throw FormatException('Entrada inválida');
    }
  }
}
