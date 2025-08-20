import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/domain/usuarios/entities/usuarios_entity.dart';
import 'package:frontend/presentation/usuarios/bloc/usuarios_bloc.dart';
import 'package:frontend/presentation/usuarios/bloc/usuarios_event.dart';
import 'package:frontend/presentation/usuarios/bloc/usuarios_state.dart';
import 'package:go_router/go_router.dart';

class CadastroWidget extends StatefulWidget {
  const CadastroWidget({super.key});

  @override
  State<CadastroWidget> createState() => _CadastroWidgetState();
}

class _CadastroWidgetState extends State<CadastroWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsuariosBloc, UsuariosState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              physics: const NeverScrollableScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Criar conta",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
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
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 50.h,
                          ),
                          child: Form(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 22.h,
                              children: [
                                TextFormField(
                                  onChanged: (value) => context
                                      .read<UsuariosBloc>()
                                      .add(AtualizarNome(nome: value)),
                                  decoration: InputDecoration(
                                    labelText: "Nome",
                                    hintText: "Digite seu nome",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(14),
                                      ),
                                    ),
                                    isDense: true,
                                    prefixIcon: Icon(Icons.person),
                                    errorText: (state.errorNome != '')
                                        ? state.errorNome
                                        : null,
                                  ),
                                ),
                                TextFormField(
                                  onChanged: (value) => context
                                      .read<UsuariosBloc>()
                                      .add(AtualizarCpf(cpf: value)),
                                  decoration: InputDecoration(
                                    labelText: "CPF",
                                    hintText: "Somente dígitos",
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(14),
                                      ),
                                    ),
                                    isDense: true,
                                    prefixIcon: const Icon(Icons.pin),
                                    errorText: (state.errorCpf != '')
                                        ? state.errorCpf
                                        : null,
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                                TextFormField(
                                  onChanged: (value) => context
                                      .read<UsuariosBloc>()
                                      .add(AtualizarEmail(email: value)),
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    hintText: "example@ex.com",
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(14),
                                      ),
                                    ),
                                    isDense: true,
                                    prefixIcon: const Icon(Icons.email),
                                    errorText: (state.errorEmail != '')
                                        ? state.errorEmail
                                        : null,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                TextFormField(
                                  onChanged: (value) => context
                                      .read<UsuariosBloc>()
                                      .add(AtualizarSenha(senha: value)),
                                  decoration: InputDecoration(
                                    labelText: "Senha",
                                    hintText: "Digite sua senha",
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(14),
                                      ),
                                    ),
                                    isDense: true,
                                    prefixIcon: const Icon(Icons.lock),
                                    errorText: (state.errorSenha != '')
                                        ? state.errorSenha
                                        : null,
                                  ),
                                  obscureText: true,
                                ),
                                TextFormField(
                                  onChanged: (value) =>
                                      context.read<UsuariosBloc>().add(
                                        AtualizarConfirmarSenha(
                                          confirmarSenha: value,
                                        ),
                                      ),
                                  decoration: InputDecoration(
                                    labelText: "Confirmar senha",
                                    hintText: "Digite sua senha novamente",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(14),
                                      ),
                                    ),
                                    isDense: true,
                                    prefixIcon: Icon(Icons.lock),
                                    errorText: (state.errorConfirmarSenha != '')
                                        ? state.errorConfirmarSenha
                                        : null,
                                  ),
                                  obscureText: true,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.read<UsuariosBloc>().add(
                                        CriarUsuario(),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: Colors.black,
                                    ),
                                    child: const Text(
                                      "Criar conta",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Já possui uma conta? "),
                                    GestureDetector(
                                      onTap: () {
                                        context.goNamed("login");
                                      },
                                      child: const Text(
                                        "Fazer login",
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
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
