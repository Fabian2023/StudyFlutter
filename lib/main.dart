import 'package:flutter/material.dart';
import 'dart:async'; // Para usar el Timer

void main() {
  runApp(TriviaApp());
}

class TriviaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TriviaPage(),
    );
  }
}

class TriviaPage extends StatefulWidget {
  const TriviaPage({super.key});

  @override
  _TriviaPageState createState() => _TriviaPageState();
}

class _TriviaPageState extends State<TriviaPage> {
  int _currentQuestionIndex = 0;
  int _score = 0; // Variable para llevar el puntaje

  final List<Map<String, Object>> _questions = [
    {
      'question': '¿Qué widget se usa para agrupar varios widgets en Flutter?',
      'options': ['Row', 'Column', 'Stack','todas las anteriores'],
      'correctOption': 'Column',
    },
    {
      'question': '¿Cuál es el lenguaje de programación principal utilizado en Flutter?',
      'options': ['Java', 'Dart', 'Kotlin','javascript'],
      'correctOption': 'Dart',
    },
    {
      'question': '¿Cómo se llama el archivo de configuración que contiene las dependencias en Flutter?',
      'options': ['pubspec.yaml', 'gradle.build', 'package.json', 'lock.json'],
      'correctOption': 'pubspec.yaml',
    },
  ];

  void _answerQuestion(String selectedOption) {
    setState(() {
      // Verifica si la respuesta es correcta
      if (selectedOption == _questions[_currentQuestionIndex]['correctOption']) {
        _score += 10; // Sumar 10 puntos por respuesta correcta
      }

      // Avanzar a la siguiente pregunta o mostrar resultados si es la última
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        // Mostrar el puntaje final y reiniciar el cuestionario después de 5 segundos
        _showFinalScore();
      }
    });
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Trivia Completada'),
        content: Text('Tu puntaje final es: $_score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              _resetTrivia(); // Reiniciar después de cerrar el diálogo
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );

    // Después de 5 segundos, reinicia automáticamente el cuestionario
    Timer(const Duration(seconds: 5), () {
      _resetTrivia();
    });
  }

  void _resetTrivia() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Trivia Flutter'),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _questions[_currentQuestionIndex]['question'] as String,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ...(_questions[_currentQuestionIndex]['options'] as List<String>)
                  .map((option) {
                return ElevatedButton(
                  onPressed: () => _answerQuestion(option),
                  child: Text(option),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
