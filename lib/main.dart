import 'package:flutter/material.dart';

void main() {
  runApp(const BMICalculator());
}

class BMICalculator extends StatelessWidget {
  const BMICalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('BMI Calculator', style: TextStyle(color: Colors.yellowAccent)), // App bar text color
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.yellowAccent, Colors.pinkAccent])
          ),
          child: const BMICalculatorScreen(),
        ),
      ),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

enum Gender { male, female }

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  double _weight = 70.0;
  double _height = 170.0;
  int _age = 30;
  double _bmi = 0.0;
  String _result = '';
  Gender? _selectedGender;

  void _calculateBMI() {
    double heightInMeters = _height / 100;
    setState(() {
      _bmi = _weight / (heightInMeters * heightInMeters);
      if (_bmi < 18.5) {
        _result = 'Underweight';
      } else if (_bmi >= 18.5 && _bmi < 24.9) {
        _result = 'Normal';
      } else if (_bmi >= 25.0 && _bmi < 29.9) {
        _result = 'Overweight';
      } else {
        _result = 'Obese';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            'BMI Calculator',
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black), // Text color
          ),
          const SizedBox(height: 20.0),
          Row(
            children: <Widget>[
              Radio(
                value: Gender.male,
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value as Gender;
                  });
                },
              ),
              const Text('Male', style: TextStyle(color: Colors.black)), // Text color
              Radio(
                value: Gender.female,
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value as Gender;
                  });
                },
              ),
              const Text('Female', style: TextStyle(color: Colors.black)), // Text color
            ],
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Age',
              labelStyle: TextStyle(color: Colors.black), // Text color
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _age = int.tryParse(value) ?? 0;
              });
            },
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Weight (kg)',
              labelStyle: TextStyle(color: Colors.black), // Text color
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _weight = double.tryParse(value) ?? 0.0;
              });
            },
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Height (cm)',
              labelStyle: TextStyle(color: Colors.black), // Text color
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _height = double.tryParse(value) ?? 0.0;
              });
            },
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              _calculateBMI();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black), // Change to your desired color
            ),
            child: const Text('Calculate', style: TextStyle(color: Colors.orangeAccent)), // Text color
          ),
          const SizedBox(height: 20.0),
          Text(
            'Your BMI is: ${_bmi.toStringAsFixed(2)} kg/m^2',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black), // Text color
          ),
          const SizedBox(height: 20.0),
          Text(
            'Result: $_result',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black), // Text color
          ),
        ],
      ),
    );
  }
}
