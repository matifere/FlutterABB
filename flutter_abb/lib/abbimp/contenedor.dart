import 'package:flutter/material.dart';

class contenedor extends StatelessWidget {
  contenedor({super.key, required this.numero, required this.dimension});
  int numero;
  double dimension;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: const Color.fromARGB(255, 58, 90, 59),
      ),
      child: Center(
        child: Text(
          numero.toString(),
          style: const TextStyle(
              fontFamily: 'Pacifico', fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
