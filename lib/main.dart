import 'package:calculator/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double firstnum = 0.0;
  double secondnum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  var hideinput = false;
  var outputsize = 34.0;
  onButtonClick(value) {
    if (value == "AC") {
      input = '';
      output = '';
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
      input = input.substring(0, input.length - 1);
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        userInput = input.replaceAll("x", "*");
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith("0.")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideinput = true;
        outputsize = 52;
      }
    } else {
      input = input + value;
      hideinput = false;
      outputsize = 34;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            //input output
            Expanded(
                child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideinput ? '' : input,
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                        fontSize: outputsize,
                        color: Colors.white.withOpacity(0.7)),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            )),
            Container(
              child: Row(
                children: [
                  button(
                      digit: "AC",
                      buttonBgColor: operatorColor,
                      tcolor: orangeColor),
                  button(
                      digit: "<",
                      buttonBgColor: operatorColor,
                      tcolor: orangeColor),
                  button(
                      digit: "",
                      buttonBgColor: Colors.transparent,
                      tcolor: orangeColor),
                  button(
                      digit: "/",
                      buttonBgColor: operatorColor,
                      tcolor: orangeColor),
                ],
              ),
            ),
            Row(
              children: [
                button(
                  digit: "7",
                ),
                button(
                  digit: "8",
                ),
                button(
                  digit: "9",
                ),
                button(
                    digit: "x",
                    tcolor: orangeColor,
                    buttonBgColor: operatorColor),
              ],
            ),
            Row(
              children: [
                button(
                  digit: "4",
                ),
                button(
                  digit: "5",
                ),
                button(
                  digit: "6",
                ),
                button(
                    digit: "-",
                    tcolor: orangeColor,
                    buttonBgColor: operatorColor),
              ],
            ),
            Row(
              children: [
                button(
                  digit: "1",
                ),
                button(
                  digit: "2",
                ),
                button(
                  digit: "3",
                ),
                button(
                    digit: "+",
                    tcolor: orangeColor,
                    buttonBgColor: operatorColor),
              ],
            ),
            Row(
              children: [
                button(
                  digit: "%",
                ),
                button(
                  digit: "0",
                ),
                button(
                  digit: ".",
                ),
                button(digit: "=", buttonBgColor: orangeColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget button({digit, tcolor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
      child: Container(
          margin: EdgeInsets.all(8),
          child: Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    backgroundColor: buttonBgColor),
                onPressed: () => onButtonClick(digit),
                child: Text(
                  digit,
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold, color: tcolor),
                )),
          )),
    );
  }
}
