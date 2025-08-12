import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/domain/instituicoes/entities/instituicao_entity.dart';
import 'package:frontend/presentation/compras/bloc/compras_bloc.dart';
import 'package:frontend/presentation/compras/bloc/compras_event.dart';
import 'package:frontend/presentation/compras/bloc/compras_state.dart';

class EscolherInstituicao extends StatefulWidget {
  const EscolherInstituicao({super.key});

  @override
  State<EscolherInstituicao> createState() => _EscolherInstituicaoState();
}

class _EscolherInstituicaoState extends State<EscolherInstituicao> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    }

    return BlocConsumer<ComprasBloc, ComprasState>(
      listener: (context, state) {
        final ComprasEntity? compra = state.compraAtual;
      },
      builder: (context, state) {
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.store, color: Colors.indigo, size: 18),
                    SizedBox(width: 8),
                    Text(
                      "Onde você está comprando?",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12),
                      child: Icon(Icons.store, size: 18, color: Colors.grey),
                    ),
                    TextField(
                      onChanged: (value) {
                        final instituicao = InstituicaoEntity(
                          id: 0,
                          nome: value.trim(),
                        );
                        context.read<ComprasBloc>().add(
                          AtualizarCompra(instituicao: instituicao),
                        );
                      },
                      decoration: InputDecoration(
                        hintText:
                            'Digite o nome da loja (ex: Supermercado Extra)',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 40,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.indigo),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
