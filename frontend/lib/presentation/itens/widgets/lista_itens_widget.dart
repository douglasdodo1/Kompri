import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/presentation/itens/bloc/item_bloc.dart';
import 'package:frontend/presentation/itens/bloc/item_event.dart';
import 'package:frontend/presentation/itens/bloc/item_state.dart';

class ListaItens extends StatefulWidget {
  const ListaItens({super.key});

  @override
  State<ListaItens> createState() => _ListaItensState();
}

class _ListaItensState extends State<ListaItens> {
  int? editingPriceId;
  double? tempPrice;

  @override
  void initState() {
    super.initState();
    context.read<ItemBloc>().add(BuscarItens());
  }

  void startEditingPrice(int itemId, double currentPrice) {
    setState(() {
      editingPriceId = itemId;
      tempPrice = currentPrice;
    });
  }

  void onTempPriceChanged(String value) {
    final newPrice = double.tryParse(value.replaceAll(',', '.'));
    if (newPrice != null) {
      tempPrice = newPrice;
    }
  }

  void onEditingFinished() {
    if (editingPriceId != null && tempPrice != null) {
      final bloc = context.read<ItemBloc>();
      final item = bloc.state.itens.firstWhere((e) => e.id == editingPriceId);
      final updated = item.copyWith(valor: tempPrice!);
      bloc.add(AtualizarItens(item: updated));
    }

    setState(() {
      editingPriceId = null;
      tempPrice = null;
    });
  }

  void simulateBarcodeScan(int itemId) {
    debugPrint('Simulando leitura de código de barras para item $itemId');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemBloc, ItemState>(
      builder: (context, state) {
        final items = state.itens;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeOut,
          transform: Matrix4.translationValues(0, 0, 0),
          child: Card(
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: items.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 50,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Nenhum item adicionado ainda",
                            style: TextStyle(color: Colors.grey),
                          ),
                          const Text(
                            "Comece digitando o nome de um produto acima",
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: items.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;

                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300 + index * 100),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: item.comprado
                                ? Colors.green[50]
                                : Colors.grey[100],
                            border: Border.all(
                              color: item.comprado
                                  ? Colors.green[200]!
                                  : Colors.grey[300]!,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      final updated = item.copyWith(
                                        comprado: !item.comprado,
                                      );
                                      context.read<ItemBloc>().add(
                                        AtualizarItens(item: updated),
                                      );
                                    },
                                    child: Icon(
                                      item.comprado
                                          ? Icons.check_circle
                                          : Icons.circle_outlined,
                                      color: item.comprado
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      item.produto.nome,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        decoration: item.comprado
                                            ? TextDecoration.lineThrough
                                            : null,
                                        color: item.comprado
                                            ? Colors.green[800]
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                  if (item.valor == 0)
                                    const Chip(
                                      label: Text("Sem preço"),
                                      backgroundColor: Color(0xFFFFF7E0),
                                      labelStyle: TextStyle(
                                        color: Colors.orange,
                                      ),
                                    ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      context.read<ItemBloc>().add(
                                        DeletarItem(itemId: item.id),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    onPressed: item.quantidade > 1
                                        ? () {
                                            final updated = item.copyWith(
                                              quantidade: item.quantidade - 1,
                                            );
                                            context.read<ItemBloc>().add(
                                              AtualizarItens(item: updated),
                                            );
                                          }
                                        : null,
                                  ),
                                  Text(
                                    "${item.quantidade}",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed: () {
                                      final updated = item.copyWith(
                                        quantidade: item.quantidade + 1,
                                      );
                                      context.read<ItemBloc>().add(
                                        AtualizarItens(item: updated),
                                      );
                                    },
                                  ),
                                  const Spacer(),
                                  editingPriceId == item.id
                                      ? Row(
                                          children: [
                                            const Icon(
                                              Icons.attach_money,
                                              size: 16,
                                            ),
                                            SizedBox(
                                              width: 60,
                                              child: TextField(
                                                keyboardType:
                                                    TextInputType.number,
                                                onChanged: onTempPriceChanged,
                                                onSubmitted: (_) =>
                                                    onEditingFinished(),
                                                autofocus: true,
                                                decoration:
                                                    const InputDecoration(
                                                      isDense: true,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : GestureDetector(
                                          onTap: () => startEditingPrice(
                                            item.id,
                                            item.valor,
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.attach_money,
                                                size: 16,
                                              ),
                                              Text(
                                                item.valor
                                                    .toStringAsFixed(2)
                                                    .replaceAll('.', ','),
                                                style: TextStyle(
                                                  color: item.valor == 0
                                                      ? Colors.orange
                                                      : Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      size: 16,
                                      color: Colors.indigo,
                                    ),
                                    onPressed: () =>
                                        simulateBarcodeScan(item.id),
                                  ),
                                ],
                              ),
                              if (item.valor > 0) ...[
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total do item:",
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      "R\$ ${(item.valor * item.quantidade).toStringAsFixed(2).replaceAll('.', ',')}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ),
        );
      },
    );
  }
}
