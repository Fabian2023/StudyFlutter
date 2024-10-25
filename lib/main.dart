import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const TriviaApp());
}

class TriviaApp extends StatelessWidget {
  const TriviaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trivia App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 35, 43, 85),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Usuario',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu usuario';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu contraseña';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal:
                              50.0), // Aumenta el padding para hacer el botón más grande
                      minimumSize: const Size(
                          200, 60), // Tamaño mínimo del botón (ancho x alto)
                      textStyle:
                          const TextStyle(fontSize: 18), // Tamaño de fuente
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Radio de borde reducido
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TriviaPage()),
                        );
                      }
                    },
                    child: const Text('Ingresar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
  int _score = 0;
  Timer? _timer; // Declaramos el Timer como una variable de instancia

  final List<Map<String, Object>> _questions = [
    {
      'question': '¿Qué widget se usa para agrupar varios widgets en Flutter?',
      'options': ['Row', 'Column', 'Stack', 'todas las anteriores'],
      'correctOption': 'Column',
    },
    {
      'question':
          '¿Cuál es el lenguaje de programación principal utilizado en Flutter?',
      'options': ['Java', 'Dart', 'Kotlin', 'javascript'],
      'correctOption': 'Dart',
    },
    {
      'question':
          '¿Cómo se llama el archivo de configuración que contiene las dependencias en Flutter?',
      'options': ['pubspec.yaml', 'gradle.build', 'package.json', 'lock.json'],
      'correctOption': 'pubspec.yaml',
    },
  ];

  void _answerQuestion(String selectedOption) {
    setState(() {
      if (selectedOption ==
          _questions[_currentQuestionIndex]['correctOption']) {
        _score += 10;
      }

      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _showFinalScore();
      }
    });
  }

  void _showFinalScore() {
    _timer = Timer(const Duration(seconds: 5), () {
      _navigateToLogin();
    });

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Trivia Completada'),
        content: Text('Tu puntaje final es: $_score'),
        actions: [
          TextButton(
            onPressed: () {
              if (_timer != null && _timer!.isActive) {
                _timer!.cancel(); // Cancela el Timer si está activo
              }
              Navigator.of(ctx).pop();
              _navigateToLogin(); // Navega al login manualmente
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const WelcomePage()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel(); // Cancela el Timer si existe
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
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
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 35, 43, 85),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ...(_questions[_currentQuestionIndex]['options'] as List<String>)
                  .map((option) {
                return ElevatedButton(
                  onPressed: () => _answerQuestion(option),
                  child: Text(option),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
