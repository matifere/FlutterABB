abstract class Iterador<int> {
  /// Devuelve true si hay un elemento siguiente en la colección.
  bool haySiguiente();

  /// Devuelve el elemento siguiente en la colección y avanza el iterador.
  dynamic siguiente();
}
