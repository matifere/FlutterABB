import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_abb/abbimp/abb.dart';
import 'package:flutter_abb/abbimp/contenedor.dart';

// ignore: camel_case_types
class abbPage extends StatefulWidget {
  const abbPage({super.key});

  @override
  State<abbPage> createState() => _abbPageState();
}

// ignore: camel_case_types
class _abbPageState extends State<abbPage> {
  List<Widget> mostrar = arbolGrafico();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  Column(
                    children: mostrar,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      mostrar = arbolGrafico();
                      setState(() {});
                    },
                    child: const Text(
                      'recargar',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<Widget> arbolGrafico() {
  ABB arbol = ABB();
  List<Widget> arbolDev = [];
  int largoTotal = 10;
  double dimension = 200;

  for (int i = 0; i < largoTotal; i++) {
    //inserto elementos en el ABB
    int random = Random().nextInt(50) + 4;
    arbol.insertar(random);
  }
  for (int i = 0; i < largoTotal; i++) {
    List<Widget> rowActual = [];
    int contador = 0;

    for (int j = 0; j < arbol.devolverNivel(i)!.length; j++) {
      if (arbol.devolverNivel(i)?[j] == 0) {
        rowActual.add(Container(
          height: dimension,
          width: dimension,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.grey),
        ));
        contador++;
      } else {
        rowActual.add(contenedor(
          numero: arbol.devolverNivel(i)![j],
          dimension: dimension,
        ));
      }
    }
    if (contador == arbol.devolverNivel(i)!.length) {
      rowActual = [];
    }
    arbolDev.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: rowActual,
    ));
    dimension = dimension / 2;
  }

  return arbolDev;
}
