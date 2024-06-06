import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String value;
  final VoidCallback onPressed;
  final Color backgroundColor;

  CustomButton({
    required this.value,
    required this.onPressed,
    this.backgroundColor = Colors.white, // Valor padrão se não for fornecido
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0), // Define o padding aqui
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(backgroundColor), // Cor de fundo do botão personalizada
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black), // Cor do texto do botão
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(vertical: 20)), // Padding do botão
            textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(fontSize: 28)), // Tamanho do texto
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Bordas arredondadas
              ),
            ),
          ),
          child: Text(value),
        ),
      ),
    );
  }
}
