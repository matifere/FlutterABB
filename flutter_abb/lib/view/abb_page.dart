import 'package:flutter/material.dart';

// ignore: camel_case_types
class abbPage extends StatefulWidget {
  const abbPage({super.key});

  @override
  State<abbPage> createState() => _abbPageState();
}

// ignore: camel_case_types
class _abbPageState extends State<abbPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('hola'),
      ),
    );
  }
}
