class ProdutoDTO {
  final int id;
  final String nome;
  final String? marca;
  final String? categoria;

  ProdutoDTO({
    required this.id,
    required this.nome,
    required this.marca,
    required this.categoria,
  });

  factory ProdutoDTO.fromJson(Map<String, dynamic> json) {
    return ProdutoDTO(
      id: json['id'] as int,
      nome: json['nome'] as String,
      marca: json['marca'] as String,
      categoria: json['categoria'] as String,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'nome': nome,
    'marca': marca,
    'categoria': categoria,
  };
}
