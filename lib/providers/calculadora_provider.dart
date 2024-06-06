import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:calculadora/models/calculadora.dart';
import 'package:calculadora/repositories/calculadora_repositorio.dart';

class CalculadoraProvider extends ChangeNotifier {
  String _display = '';
  String _currentOperator = '';
  double? _currentResult;
  List<String> _historico = [];

  String get display => _display;
  List<String> get historico => _historico;

  CalculadoraProvider() {
    _loadHistorico();
  }

  void input(String value) {
    if (value == 'C') {
      _display = '';
      _currentOperator = '';
      _currentResult = null;
    } else if (value == 'DEL') {
      _display = _display.isNotEmpty ? _display.substring(0, _display.length - 1) : '';
    } else if (value == '=') {
      try {
        final calculadora = _parseInput(_display);
        final resultado = CalculadoraRepositorio().realizarOperacao(calculadora);
        _historico.add('$_display = $resultado');
        _display = resultado.toString();
        _currentResult = resultado;
        _currentOperator = '';
        _saveHistorico();
      } catch (e) {
        _display = 'Erro';
      }
    } else if (isOperator(value)) {
      if (_currentResult != null && _currentOperator.isNotEmpty) {
        try {
          final calculadora = Calculadora(
            primeiroOperando: _currentResult!,
            operador: _currentOperator,
            segundoOperando: double.parse(_display.split(_currentOperator).last),
          );
          _currentResult = CalculadoraRepositorio().realizarOperacao(calculadora);
          _historico.add('$_currentResult $_currentOperator ${double.parse(_display.split(_currentOperator).last)} = $_currentResult');
          _display = _currentResult.toString() + value;
        } catch (e) {
          _display = 'Erro';
        }
      } else {
        _currentResult = double.tryParse(_display);
        _display += value;
      }
      _currentOperator = value;
    } else {
      _display += value;
    }
    notifyListeners();
  }

  void limparHistorico() {
    _historico.clear();
    _saveHistorico();
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

  bool isOperator(String value) {
    return ['+', '-', '*', '/', '%'].contains(value);
  }

  Future<void> _loadHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    _historico = prefs.getStringList('historico') ?? [];
    notifyListeners();
  }

  Future<void> _saveHistorico() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('historico', _historico);
  }
}
