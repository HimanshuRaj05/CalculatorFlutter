import 'package:calculator_application/utils/my_button.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(brightness: Brightness.dark),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool inputDone = false;
  double resultPrev = -1;
  String inputString = 'Calculator...';
  String outputString = '';
  bool firstRun = true;
  bool equalsPressed = false;
  bool firstResultCalculated = false;
  String inputString2 = '';

  bool _isDigit(String character) {
    return character.codeUnitAt(0) >= 48 && character.codeUnitAt(0) <= 57;
  }

  double calcNewResult(double n1, double n2, String op) {
    double result = 0;

    switch (op) {
      case '+':
        result = n1 + n2;
        break;

      case '-':
        result = n1 - n2;
        break;

      case 'x':
        result = n1 * n2;
        break;

      case '/':
        result = n1 / n2;

      default:
        result = -1;
    }
    String resultString = result.toStringAsFixed(2);

    return double.parse(resultString);
  }

  double calcResultFirst() {
    String n1 = '';
    String n2 = '';
    String op = '';
    bool selectFirst = true;

    for (int i = 0; i < inputString.length; i++) {
      if (selectFirst) {
        if (_isDigit(inputString[i])) {
          n1 += inputString[i];
        } else {
          op = inputString[i];
          selectFirst = false;
        }
      } else {
        n2 += inputString[i];
      }
    }

    double result = -1;

    switch (op) {
      case '+':
        result = double.parse(n1) + double.parse(n2);
        break;

      case '-':
        result = double.parse(n1) - double.parse(n2);
        break;

      case 'x':
        result = double.parse(n1) * double.parse(n2);
        break;

      case '/':
        result = double.parse(n1) / double.parse(n2);

      default:
        result = -1;
    }

    String formattedResult = result.toStringAsFixed(2);

    firstResultCalculated = true;
    return double.parse(formattedResult);
  }

  void appendToCalc(String s) {
    if (firstRun) {
      inputString = '';
      firstRun = false;
    }

    if (s == '=') {
      if (firstResultCalculated) {
        String presentOp = '';
        int nextNumIndex = 0;
        //Now find just the operator and the second num
        for (int i = 0; i < inputString.length; i++) {
          if (!_isDigit(inputString[i])) {
            presentOp = inputString[i];
            nextNumIndex = i + 1;
            break;
          }
        }

        String secondNum = '';

        for (int i = nextNumIndex; i < inputString.length; i++) {
          secondNum += inputString[i];
        }

        double newResult =
            calcNewResult(resultPrev, double.parse(secondNum), presentOp);

        resultPrev = newResult;

        setState(() {
          inputString = newResult.toString();
        });
      } else {
        double result = calcResultFirst();
        resultPrev = result;
        inputString = result.toString();
        setState(() {});
      }
    } else {
      setState(() {
        inputString += s;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(10),
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(8)),
            child: Text(
              inputDone ? outputString : inputString,
              style: TextStyle(fontSize: 25),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  MyButton(
                    buttonText: '0',
                    onTap: () => appendToCalc('0'),
                  ),
                  MyButton(
                    buttonText: '1',
                    onTap: () => appendToCalc('1'),
                  ),
                  MyButton(
                    buttonText: '2',
                    onTap: () => appendToCalc('2'),
                  ),
                ],
              ),
              Row(
                children: [
                  MyButton(
                    buttonText: '3',
                    onTap: () => appendToCalc('3'),
                  ),
                  MyButton(
                    buttonText: '4',
                    onTap: () => appendToCalc('4'),
                  ),
                  MyButton(
                    buttonText: '5',
                    onTap: () => appendToCalc('5'),
                  ),
                ],
              ),
              Row(
                children: [
                  MyButton(
                    buttonText: '6',
                    onTap: () => appendToCalc('6'),
                  ),
                  MyButton(
                    buttonText: '7',
                    onTap: () => appendToCalc('7'),
                  ),
                  MyButton(
                    buttonText: '8',
                    onTap: () => appendToCalc('8'),
                  ),
                ],
              ),
              Row(
                children: [
                  MyButton(
                    buttonText: '9',
                    onTap: () => appendToCalc('9'),
                  ),
                  MyButton(
                    buttonText: '+',
                    onTap: () => appendToCalc('+'),
                  ),
                  MyButton(
                    buttonText: '-',
                    onTap: () => appendToCalc('-'),
                  ),
                ],
              ),
              Row(
                children: [
                  MyButton(
                    buttonText: 'x',
                    onTap: () => appendToCalc('x'),
                  ),
                  MyButton(
                    buttonText: '/',
                    onTap: () => appendToCalc('/'),
                  ),
                  MyButton(
                    buttonText: '=',
                    onTap: () => appendToCalc('='),
                  ),
                ],
              )
            ],
          )
        ]),
      ),
    );
  }
}
