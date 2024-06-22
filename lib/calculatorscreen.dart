import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calculator/button_values.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorscreenState();
}

class _CalculatorscreenState extends State<CalculatorScreen> {
  String number1 = "";
  String number2 = "";
  String operator = "";
  
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
          //result
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16.0),
                  child: Text('$number1$operator$number2'.isEmpty?'0':'$number1$operator$number2',
                   style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
          //buttons
            Wrap(
              children: Btn.buttonValues.map(
                (value) => SizedBox(
                  width: (screenSize.width/4),
                  height: (screenSize.width/5),
                  child: buildButton(value)),)
                .toList()
            )          
          ],
        ),
      ),
    );
  }

  Widget buildButton(value) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white24),
          borderRadius: BorderRadius.circular(0)),
        child: InkWell(
          onTap: () => onBtnTap(value),
          child: 
          Center(
          child: 
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)
          )
          ),
      ),
    );
  }


void onBtnTap(String value) {
if(value == Btn.del){
  delete();
  return;
}

if(value == Btn.clr){
  clearAll();
  return;
}

if(value == Btn.per){
  convertToPercentage();
  return;

}

if(value == Btn.calculate){
  calculate();
  return;
}
if(value == Btn.copy){
  copytoClipboard();
  return;
}
appendValue(value);
  
}

void copytoClipboard() async {
  await Clipboard.setData(ClipboardData(text: number1));
}
void calculate() {
  if(number1.isEmpty){
    return;
  }
  if(operator.isEmpty){
    return;
  }
  if(number2.isEmpty){
    return;
  }

  final double num1 = double.parse(number1);
  final double num2 = double.parse(number2);

  var result = 0.0;

  switch(operator){
    case Btn.add:
      result = num1 + num2;
      break;
    case Btn.subtract:
      result = num1 - num2;
      break;
    case Btn.multiply:
      result = num1 * num2;
      break;
    case Btn.divide:
      result = num1 / num2;
      break;
    default:

  }
  setState(() {
    number1 = "$result";

    if(number1.endsWith('.0')){
      number1 = number1.substring(0, number1.length-2);
    }

    operator = "";
    number2 = "";
  });
}
void convertToPercentage(){
  if(number1.isNotEmpty && operator.isNotEmpty && number2.isNotEmpty){
      calculate();
  }

  if(operator.isNotEmpty){
    return;
  }

  final number = double.parse(number1);
  setState(() {
    number1 = "${(number / 100)}";
    operator = "";
    number2 = "";
  });
}

void clearAll() {

  setState(() {
    number1 = "";
    operator = '';
    number2 = '';
  });
}


void delete() {
  if(number2.isNotEmpty){
      number2 = number2.substring(0, number2.length -1);
  }
  else if(operator.isNotEmpty){
    operator = "";
  }
  else if(number1.isNotEmpty){
    number1 = number1.substring(0, number1.length -1);
  }

  setState(() {
    
  });
}

void appendValue(String value) {
  if (value != Btn.dot && int.tryParse(value) == null) {
    
      if (operator.isNotEmpty && number2.isNotEmpty) {
        
        calculate();
      }
      operator = value;
    }

    else if (number1.isEmpty || operator.isEmpty) {
     
      if (value == Btn.dot && number1.contains(Btn.dot)) return;
      if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)) {
        
        value = "0.";
      }
      number1 += value;
    }

    else if (number2.isEmpty || operator.isNotEmpty) {
    
      if (value == Btn.dot && number2.contains(Btn.dot)) return;
      if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)) {
        
        value = "0.";
      }
      number2 += value;
    }

  setState(() {

  });
}

  Color getBtnColor(value) {
    return [Btn.del, Btn.clr].contains(value)
        ?Colors.blueGrey:
        [
          Btn.per,
          Btn.multiply,
          Btn.add,
          Btn.subtract,
          Btn.divide,
          Btn.calculate,
        ].contains(value)?Colors.orange:
        Colors.black87;
  }
}