import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/domain/itens/entities/item_entity.dart';
import 'package:frontend/domain/produtos/entities/produto_entity.dart';
import 'package:frontend/presentation/compras/bloc/compras_bloc.dart';
import 'package:frontend/presentation/compras/bloc/compras_event.dart';
import 'package:frontend/presentation/compras/bloc/compras_state.dart';

class AdicionarItem extends StatefulWidget {
  const AdicionarItem({super.key});

  @override
  State<AdicionarItem> createState() => _AdicionarItemState();
}

class _AdicionarItemState extends State<AdicionarItem> {
  final TextEditingController _controller = TextEditingController();

  void _cadastrarItem(String nomeProduto, ComprasEntity? compraAtual) {
    if (nomeProduto.trim().isEmpty || compraAtual == null) return;
    if (compraAtual.id == null) return;

    final novoItem = ItemEntity(
      id: -1,
      compraId: compraAtual.id!,
      produto: ProdutoEntity(
        id: -1,
        nome: nomeProduto.trim(),
        marca: null,
        categoria: null,
      ),
      quantidade: 1,
      valor: 0.0,
      comprado: false,
    );

    context.read<ComprasBloc>().add(AtualizarCompra(item: novoItem));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComprasBloc, ComprasState>(
      builder: (context, compraState) {
        final compraAtual = compraState.compra;

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
                    Icon(Icons.shopping_cart, color: Colors.indigo, size: 18),
                    SizedBox(width: 8),
                    Text(
                      "Qual produto você deseja adicionar?",
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
                      child: Icon(
                        Icons.shopping_cart,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                    TextField(
                      controller: _controller,
                      onSubmitted: (value) =>
                          _cadastrarItem(value, compraAtual),
                      decoration: InputDecoration(
                        hintText: 'Digite o nome do produto e pressione Enter',
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
