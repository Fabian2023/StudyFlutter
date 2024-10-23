import 'package:flutter/material.dart';

void main() => runApp(const MiApp());

class MiApp extends StatelessWidget {
  const MiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "mi App",
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("my first apk"),
      ),
      body: ListView(
        children: [
          Container(
            padding:  const EdgeInsets.all(80.0),
            child:Image.asset("assets/images/man.jpg"),
          ),
          Container( padding:  const EdgeInsets.all(80.0),
            child:Image.asset("assets/images/man.jpg"),
            )
        ],
      )
    );
  }
}
