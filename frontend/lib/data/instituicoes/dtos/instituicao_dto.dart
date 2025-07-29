class InstituicaoDTO {
  final int id;
  final String nome;

  InstituicaoDTO({required this.id, required this.nome});

  factory InstituicaoDTO.fromJson(Map<String, dynamic> json) {
    return InstituicaoDTO(id: json['id'], nome: json['nome']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'nome': nome};
}
