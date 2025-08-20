import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/presentation/auth/bloc/auth_bloc.dart';
import 'package:frontend/presentation/auth/bloc/auth_state.dart';
import 'package:frontend/presentation/usuarios/bloc/usuarios_bloc.dart';
import 'package:frontend/presentation/usuarios/bloc/usuarios_state.dart';
import 'package:go_router/go_router.dart';

class CadastroWidget extends StatefulWidget {
  const CadastroWidget({super.key});

  @override
  State<CadastroWidget> createState() => _CadastroWidgetState();
}

class _CadastroWidgetState extends State<CadastroWidget> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController =
      TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsuariosBloc, UsuariosState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Criar conta",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Text(
              "Crie sua conta para começar o Kompri",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20.h),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),

              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 22.h,
                    children: [
                      TextFormField(
                        controller: _nomeController,
                        decoration: const InputDecoration(
                          labelText: "nome",
                          hintText: "nome",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                          ),
                          isDense: true,
                          prefixIcon: Icon(Icons.person),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),

                      TextFormField(
                        controller: _cpfController,
                        decoration: const InputDecoration(
                          labelText: "cpf",
                          hintText: "somente digitos",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                          ),
                          isDense: true,
                          prefixIcon: Icon(Icons.pin),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),

                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: "email",
                          hintText: "example@ex.com",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                          ),
                          isDense: true,
                          prefixIcon: Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),

                      TextFormField(
                        controller: _senhaController,
                        decoration: const InputDecoration(
                          labelText: "Senha",
                          hintText: "Digite sua senha",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                          ),
                          isDense: true,
                          prefixIcon: Icon(Icons.lock),
                        ),
                        obscureText: true,
                      ),

                      TextFormField(
                        controller: _confirmarSenhaController,
                        decoration: const InputDecoration(
                          labelText: "confirmar senha",
                          hintText: "digite sua senha novamente",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(14)),
                          ),
                          isDense: true,
                          prefixIcon: Icon(Icons.lock),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Colors.black,
                          ),
                          child: const Text(
                            "Entrar",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Não tem uma conta? "),
                          GestureDetector(
                            onTap: () {
                              context.goNamed("login");
                            },
                            child: const Text(
                              "Criar conta",
                              style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
