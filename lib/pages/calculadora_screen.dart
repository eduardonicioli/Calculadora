import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculadora/providers/calculadora_provider.dart';
import 'package:calculadora/widgets/buttons.dart';

class CalculadoraScreen extends StatefulWidget {
  @override
  _CalculadoraScreenState createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CalculadoraProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                provider.limparHistorico();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.bottomRight,
              color: Colors.grey[300],
              child: Text(
                provider.display,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            children: [
              CustomButton(value: '7', onPressed: () => setState(() => provider.input('7'))),
              CustomButton(value: '8', onPressed: () => setState(() => provider.input('8'))),
              CustomButton(value: '9', onPressed: () => setState(() => provider.input('9'))),
              CustomButton(value: '/', backgroundColor: Colors.orangeAccent, onPressed: () => setState(() => provider.input('/'))),
            ],
          ),
          Row(
            children: [
              CustomButton(value: '4', onPressed: () => setState(() => provider.input('4'))),
              CustomButton(value: '5', onPressed: () => setState(() => setState(() => provider.input('5')))),
              CustomButton(value: '6', onPressed: () => setState(() => setState(() => provider.input('6')))),
              CustomButton(value: '*', backgroundColor: Colors.orangeAccent, onPressed: () => setState(() => provider.input('*'))),
            ],
          ),
          Row(
            children: [
              CustomButton(value: '1', onPressed: () => setState(() => provider.input('1'))),
              CustomButton(value: '2', onPressed: () => setState(() => provider.input('2'))),
              CustomButton(value: '3', onPressed: () => setState(() => provider.input('3'))),
              CustomButton(value: '-', backgroundColor: Colors.orangeAccent, onPressed: () => setState(() => provider.input('-'))),
            ],
          ),
          Row(
            children: [
              CustomButton(value: '0', onPressed: () => setState(() => provider.input('0'))),
              CustomButton(value: '.', onPressed: () => setState(() => provider.input('.'))),
              CustomButton(value: '%', backgroundColor: Colors.orangeAccent, onPressed: () => setState(() => provider.input('%'))),
              CustomButton(value: '+', backgroundColor: Colors.orangeAccent, onPressed: () => setState(() => provider.input('+'))),
            ],
          ),
          Row(
            children: [
              CustomButton(value: 'C', backgroundColor: Colors.redAccent, onPressed: () => setState(() => provider.input('C'))),
              CustomButton(value: 'DEL', backgroundColor: Colors.redAccent, onPressed: () => setState(() => provider.input('DEL'))),
              CustomButton(value: '=', backgroundColor: Colors.green, onPressed: () => setState(() => provider.input('='))),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.topLeft,
              child: ListView.builder(
                itemCount: provider.historico.length,
                itemBuilder: (context, index) {
                  int reverseIndex = provider.historico.length - 1 - index;
                  return ListTile(
                    title: Text(provider.historico[reverseIndex]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
