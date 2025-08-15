import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/domain/itens/entities/item_entity.dart';
import 'package:frontend/domain/produtos/entities/produto_entity.dart';
import 'package:frontend/presentation/compras/bloc/compras_bloc.dart';
import 'package:frontend/presentation/compras/bloc/compras_event.dart';
import 'package:frontend/presentation/compras/bloc/compras_state.dart';
import 'package:frontend/presentation/produtos/bloc/produtos_bloc.dart';
import 'package:frontend/presentation/produtos/bloc/produtos_event.dart';
import 'package:uuid/uuid.dart';

class AdicionarItem extends StatefulWidget {
  const AdicionarItem({super.key});

  @override
  State<AdicionarItem> createState() => _AdicionarItemState();
}

class _AdicionarItemState extends State<AdicionarItem> {
  final TextEditingController _controller = TextEditingController();

  void _cadastrarItem(String nomeProduto) {
    final uuid = Uuid();

    final novoItem = ItemEntity(
      id: uuid.v4(),
      compraId: -1,
      produto: ProdutoEntity(
        id: uuid.v4(),
        nome: nomeProduto.trim(),
        marca: null,
        categoria: null,
      ),
      quantidade: 1,
      valor: 0.0,
      comprado: false,
    );

    context.read<ComprasBloc>().add(AtualizarCompra(item: novoItem));
    context.read<ProdutosBloc>().add(CriarProduto(novoItem.produto));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComprasBloc, ComprasState>(
      builder: (context, compraState) {
        return Card(
          elevation: 2,
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
                      onSubmitted: (value) => _cadastrarItem(value),
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
