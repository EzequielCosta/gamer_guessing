import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(const Game());
}

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Game Guess"),
          ),
          body: Container(
            margin: const EdgeInsets.only(top: 80),
            child: const GamerGuess(),
          )),
    );
  }
}

class GamerGuess extends StatefulWidget {
  const GamerGuess({Key? key}) : super(key: key);
  @override
  State<GamerGuess> createState() => GamerGuessState();
}

class GamerGuessState extends State<GamerGuess> {
  int _numberRandom = Random().nextInt(100) + 1;
  int _number = 1;
  bool _numberRight = false;
  String info = "";

  final TextStyle? styleLabel = const TextStyle(
      fontSize: 20, color: Colors.blueAccent, fontWeight: FontWeight.w500);

  void changeNumber(int value) {
    setState(() {
      _number = value;
    });
    checkHits();
  }

  void checkHits() {
    final String text;
    bool numberRight = false;
    if (_number > _numberRandom) {
      text = "O número é menor";
    } else if (_number < _numberRandom) {
      text = "O número é maior";
    } else {
      text = "Número correto!";
      numberRight = true;
    }
    setState(() {
      info = text;
      _numberRight = numberRight;
    });
  }

  void resetNumberRandom() {
    setState(() {
      _numberRandom = Random().nextInt(100) + 1;
      checkHits();
    });
  }

  @override
  Widget build(BuildContext context) {
    //checkHits();
    return Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
          Text(_numberRandom.toString()),
          Text("Escolha um número de 1 a 100", style: styleLabel),
          NumberPickerInput(_number, changeNumber, _numberRight),
          Text(info),
          Container(
              margin: const EdgeInsets.only(top: 30),
              child: ButtonReset(resetNumberRandom))
        ]));
  }
}

// ignore: must_be_immutable
class NumberPickerInput extends StatelessWidget {
  int number;
  ValueChanged<int> changeNumber;
  // ignore: non_constant_identifier_names
  bool number_right;

  NumberPickerInput(this.number, this.changeNumber, this.number_right,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NumberPicker(
        minValue: 1,
        maxValue: 100,
        value: number,
        onChanged: changeNumber,
        axis: Axis.horizontal,
        selectedTextStyle: number_right
            ? const TextStyle(color: Colors.green, fontSize: 30)
            : const TextStyle());
  }
}

// ignore: must_be_immutable
class TextInfo extends StatelessWidget {
  String message;

  TextInfo(this.message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(message);
  }
}

// ignore: must_be_immutable
class ButtonReset extends StatelessWidget {
  VoidCallback resetNumber;
  ButtonReset(this.resetNumber, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: 30,
        onPressed: resetNumber,
        icon: const Icon(
          Icons.restart_alt,
          size: 30,
        ));
  }
}
