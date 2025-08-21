import 'dart:convert';
import 'package:frontend/domain/auth/repositorys/auth_repository.dart';
import 'package:http/http.dart' as http;

class AuthRepositoryImpl extends AuthRepository {
  final http.Client client;

  AuthRepositoryImpl({required this.client});

  @override
  Future<void> logar(String cpf, String senha) async {
    final url = Uri.parse('http://localhost:3000/login');

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'cpf': cpf, 'senha': senha}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Login sucesso: $data');
    } else {
      throw Exception('Falha no login: ${response.statusCode}');
    }
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }
}
