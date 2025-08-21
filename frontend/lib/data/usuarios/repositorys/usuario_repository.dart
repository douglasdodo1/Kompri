import 'dart:convert';

import 'package:frontend/data/usuarios/models/usuario_model.dart';
import 'package:frontend/domain/usuarios/entities/usuarios_entity.dart';
import 'package:frontend/domain/usuarios/repositorys/usuarios_repository.dart';
import 'package:http/http.dart' as http;

class UsuariosRepositoryImpl extends UsuariosRepository {
  final http.Client client;

  UsuariosRepositoryImpl({required this.client});

  @override
  Future<bool> criarUsuario(UsuarioEntity usuario) async {
    final UsuarioModel usuarioModel = usuario.toModel();

    print(usuarioModel.toJson());

    final url = Uri.parse('http://10.0.2.2:3000/usuarios');

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'usuario': usuarioModel.toJson()}),
    );

    print(response.body);
    return Future.value(true);
  }
}
