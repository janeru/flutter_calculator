import 'package:flutter/material.dart';

void main() => runApp(MyCalculatorApp());

class MyCalculatorApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyCalculatorPage(title: 'Flutter Calculator Page'),
    );
  }
}

class MyCalculatorPage extends StatefulWidget {
  MyCalculatorPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyCalculatorPageState createState() => _MyCalculatorPageState();
}

class _MyCalculatorPageState extends State<MyCalculatorPage> {
  String displayString = '0';
  String numberString = '0';
  // calculate output
  double result = 0;
  String operation;
  // 檢查重複用同一個數字來做運算的情形
  bool shouldCalculate;

  // 創建按鈕的function(還有因為要輸出這個東西，因此是個widget)
  Widget createButton(String title) {
    return Expanded(
        child: ButtonTheme(
            // 因為每個大小都一樣，但是按鈕與按鈕上下之間要沒有空隙
            height: double.infinity,
            child: OutlineButton(
              onPressed: () => pressButton(title),
              child: Text(title,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              borderSide: BorderSide(color: Colors.grey, width: 1),
              highlightedBorderColor: Colors.black,
            )));
  }

  Widget createRow(String title1, String title2, String title3, String title4) {
    return Expanded(
        child: Row(
      children: <Widget>[
        createButton(title1),
        createButton(title2),
        createButton(title3),
        createButton(title4)
      ],
    ));
  }

  pressButton(String title) {
    setState(() {
      if (title == '+' || title == '-' || title == '*' || title == '/') {
        if (shouldCalculate) {
          calculate();
        } else {
          // 字串轉double
          // 如果傳入的字像是 '+','-'...無法被轉成字串的，就給值0
          result = double.parse(numberString) ?? 0;
          shouldCalculate = true;
        }
        numberString = '';
        operation = title;
      } else if (title == '=') {
        calculate();
        shouldCalculate = false;
      } else if (title == 'CE') {
        numberString = '';
        displayString = '0';
        result = 0;
        shouldCalculate = false;
      } else {
        if (numberString == '0' || numberString == '0.0') {
          numberString = '';
        }
        numberString += title;
        displayString = numberString;
      }
    });
  }

  calculate() {
    switch (operation) {
      case '+':
        result += double.parse(numberString);
        break;
      case '-':
        result -= double.parse(numberString);
        break;
      case '*':
        result *= double.parse(numberString);
        break;
      case '/':
        result /= double.parse(numberString);
        break;
      default:
        break;
    }
    numberString = result.toString();
    displayString = numberString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Container(
                    color: Color.fromARGB(10, 0, 0, 0),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: Text(displayString,
                              style: TextStyle(fontSize: 80))),
                    ))),
            Expanded(
                child: Column(
              children: <Widget>[
                createRow('+', '-', '*', '/'),
                createRow('7', '8', '9', '0'),
                createRow('4', '5', '6', 'CE'),
                createRow('1', '2', '3', '='),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
