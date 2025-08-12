int proximoElemento(int indexAtual, int tamanho) {
  if (indexAtual < tamanho - 1) {
    return indexAtual + 1;
  } else {
    return indexAtual;
  }
}
