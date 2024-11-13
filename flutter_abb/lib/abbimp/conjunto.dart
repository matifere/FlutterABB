abstract class Conjunto<int> {
  /// Devuelve la cantidad de elementos del conjunto.
  int cardinal();

  /// Devuelve el menor elemento del conjunto.
  dynamic minimo();

  /// Devuelve el mayor elemento del conjunto.
  dynamic maximo();

  /// Agrega un elemento al conjunto.
  void insertar(int elem);

  /// Devuelve verdadero si el elemento pertenece al conjunto.
  bool pertenece(int elem);

  /// Elimina el elemento del conjunto.
  void eliminar(int elem);

  /// Imprime el conjunto.
  @override
  String toString();

  /// Retorna un conjunto con los mismos elementos.
  // Conjunto<T> copiar(); // Comentado ya que `ABB<T>` no existe en este contexto.
}
