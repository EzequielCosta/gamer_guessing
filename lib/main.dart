import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(const GamerGuess());
}

class GamerGuess extends StatelessWidget {
  const GamerGuess({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Gamer"),
          ),
          body: Container(
            margin: const EdgeInsets.only(top: 80),
            child: const Games(),
          )),
    );
  }
}

class Games extends StatefulWidget {
  const Games({Key? key}) : super(key: key);
  @override
  GamesState createState() => GamesState();
}

class GamesState extends State<Games> {
  int _numberRandom = Random().nextInt(100) + 1;
  int _number = 1;
  String info = "";
  TextStyle _styleFindNumber = TextStyle();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          const Text(
            "Escolha um número de 1 a 100",
            style: TextStyle(fontSize: 20, color: Colors.deepPurple),
          ),
          NumberPicker(
            minValue: 1,
            maxValue: 100,
            value: _number,
            onChanged: (int value) => {onChange(value)},
            axis: Axis.horizontal,
            selectedTextStyle: _styleFindNumber,
          ),
          Text(info),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: IconButton(
                iconSize: 30,
                onPressed: () {
                  setState(() {
                    _numberRandom = Random().nextInt(100) + 1;
                    checkHits();
                  });
                },
                icon: const Icon(
                  Icons.restart_alt,
                  size: 30,
                )),
          )
        ]));
  }

  void onChange(int value) {
    setState(() {
      _number = value;
    });
    checkHits();
  }

  void checkHits() {
    final String text;
    TextStyle textStyle = const TextStyle();
    if (_number > _numberRandom) {
      text = "O número é menor";
    } else if (_number < _numberRandom) {
      text = "O número é maior";
    } else {
      textStyle =
          const TextStyle(color: Colors.green, fontWeight: FontWeight.bold);
      text = "Número correto!";
    }
    setState(() {
      info = text;
      _styleFindNumber = textStyle;
    });
  }
}
