import 'dart:math';

import 'package:flutter_abb/abbimp/conjunto.dart';
import 'package:flutter_abb/abbimp/iterador.dart';

class ABB<T extends Comparable<int>> implements Conjunto<int> {
  Nodo? raiz;
  int largo;

  ABB()
      : raiz = null,
        largo = 0;

  @override
  int cardinal() {
    return largo;
  }

  List<int>? devolverNivel(int nivel) {
    if (raiz == null) return null;

    // Determinamos la cantidad exacta de nodos en este nivel (2^nivel)
    int cantidadNodosNivel = pow(2, nivel).toInt();
    List<int> devolver = List.filled(cantidadNodosNivel, 0);

    _devolverNivelRecursivo(raiz, nivel, devolver, 0);
    return devolver;
  }

// Función auxiliar recursiva para recorrer el nivel y colocar nodos en las posiciones correctas
  void _devolverNivelRecursivo(
      Nodo? nodo, int nivel, List<int> devolver, int index) {
    if (nivel == 0) {
      // En el nivel deseado, colocamos el valor del nodo en el índice adecuado o 0 si es nulo
      devolver[index] = nodo?.valor ?? 0;
    } else {
      // Si no estamos en el nivel deseado, avanzamos a los hijos izquierdo y derecho
      if (nodo != null) {
        _devolverNivelRecursivo(nodo.menor, nivel - 1, devolver, 2 * index);
        _devolverNivelRecursivo(nodo.mayor, nivel - 1, devolver, 2 * index + 1);
      } else {
        // Si el nodo es nulo, dejamos ceros en los índices de sus posiciones vacías
        int inicio = 2 * index;
        devolver[inicio] = 0;
        devolver[inicio + 1] = 0;
      }
    }
  }

  @override
  void eliminar(int elem) {
    if (!pertenece(elem) || cardinal() == 0) return;

    Nodo? actual = raiz;
    Nodo? padre;
    bool esIzq = false;

    while (actual != null && actual.valor != elem) {
      padre = actual;
      if (elem.compareTo(actual.valor) < 0) {
        esIzq = true;
        actual = actual.menor;
      } else {
        esIzq = false;
        actual = actual.mayor;
      }
    }

    if (actual != null) {
      if (actual.menor == null && actual.mayor == null) {
        if (actual == raiz) {
          raiz = null;
        } else if (esIzq) {
          padre!.menor = null;
        } else {
          padre!.mayor = null;
        }
      } else if (actual.mayor == null) {
        if (actual == raiz) {
          raiz = actual.menor;
        } else if (esIzq) {
          padre!.menor = actual.menor;
        } else {
          padre!.mayor = actual.menor;
        }
      } else if (actual.menor == null) {
        if (actual == raiz) {
          raiz = actual.mayor;
        } else if (esIzq) {
          padre!.menor = actual.mayor;
        } else {
          padre!.mayor = actual.mayor;
        }
      } else {
        Nodo sucesor = actual.mayor!;
        Nodo sucesorPadre = actual;
        while (sucesor.menor != null) {
          sucesorPadre = sucesor;
          sucesor = sucesor.menor!;
        }
        actual.valor = sucesor.valor;
        if (sucesorPadre != actual) {
          sucesorPadre.menor = sucesor.mayor;
        } else {
          sucesorPadre.mayor = sucesor.mayor;
        }
      }
      largo--;
    }
  }

  @override
  void insertar(int elem) {
    if (pertenece(elem)) return;
    Nodo insertar = Nodo(elem);
    if (cardinal() == 0) {
      raiz = insertar;
    } else {
      Nodo actual = raiz!;
      bool terminar = false;
      while (!terminar) {
        int comparacion = actual.valor.compareTo(elem);
        if (comparacion > 0) {
          if (actual.menor == null) {
            actual.menor = insertar;
            terminar = true;
          } else {
            actual = actual.menor!;
          }
        } else {
          if (actual.mayor == null) {
            actual.mayor = insertar;
            terminar = true;
          } else {
            actual = actual.mayor!;
          }
        }
      }
    }
    largo++;
  }

  @override
  dynamic maximo() {
    if (largo == 0) {
      return null;
    }
    Nodo actual = raiz!;
    while (actual.mayor != null) {
      actual = actual.mayor!;
    }
    return actual.valor;
  }

  @override
  dynamic minimo() {
    if (largo == 0) {
      return null;
    }
    Nodo actual = raiz!;
    while (actual.menor != null) {
      actual = actual.menor!;
    }
    return actual.valor;
  }

  @override
  bool pertenece(int elem) {
    if (cardinal() == 0) return false;
    Nodo? actual = raiz;
    while (actual != null) {
      int comparacion = actual.valor.compareTo(elem);
      if (comparacion == 0) return true;
      if (comparacion > 0) {
        actual = actual.menor;
      } else {
        actual = actual.mayor;
      }
    }
    return false;
  }

  @override
  String toString() {
    StringBuffer buffer = StringBuffer("{");
    Nodo? nodo = raiz;
    bool primero = true;

    void recorridoInorden(Nodo? nodo) {
      if (nodo == null) return;
      recorridoInorden(nodo.menor);
      if (!primero) buffer.write(", ");
      buffer.write(nodo.valor);
      primero = false;
      recorridoInorden(nodo.mayor);
    }

    recorridoInorden(nodo);
    buffer.write("}");
    return buffer.toString();
  }

  // Método para obtener los elementos en orden
  List<int> enOrden() {
    List<int> elementos = [];
    _recorrerEnOrden(raiz, elementos);
    return elementos;
  }

  void _recorrerEnOrden(Nodo? nodo, List<int> elementos) {
    if (nodo == null) return;
    _recorrerEnOrden(nodo.menor, elementos);
    elementos.add(nodo.valor);
    _recorrerEnOrden(nodo.mayor, elementos);
  }
}

// ignore: camel_case_types
class ABB_Iterador<int> implements Iterador<dynamic> {
  final List<int> _elementos = [];
  var _indiceActual = 0;

  // Constructor que realiza un recorrido en orden y almacena los elementos en una lista
  ABB_Iterador(raiz) {
    _inOrden(raiz);
  }

  // Método auxiliar para recorrer el árbol en orden y almacenar los elementos en _elementos
  void _inOrden(nodo) {
    if (nodo == null) return;
    _inOrden(nodo.menor);
    _elementos.add(nodo.valor);
    _inOrden(nodo.mayor);
  }

  @override
  bool haySiguiente() {
    return _elementos.length > _indiceActual;
  }

  @override
  int siguiente() {
    if (!haySiguiente()) {
      throw StateError("No hay más elementos en el iterador");
    }
    return _elementos[_indiceActual++];
  }
}

class Nodo {
  // ignore: prefer_typing_uninitialized_variables
  var valor;
  Nodo? menor;
  Nodo? mayor;

  Nodo(this.valor)
      : menor = null,
        mayor = null;
}
