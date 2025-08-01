import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/format_to_cash.dart';
import 'package:frontend/presentation/compras/bloc/compras_bloc.dart';
import 'package:frontend/presentation/compras/bloc/compras_event.dart';
import 'package:frontend/presentation/compras/bloc/compras_state.dart';
import 'package:frontend/presentation/itens/bloc/item_bloc.dart';
import 'package:frontend/presentation/itens/bloc/item_event.dart';
import 'package:frontend/presentation/itens/widgets/editable_chip_widget.dart';
import 'package:frontend/presentation/itens/widgets/lista_itens_vazia_widget.dart';

class ListaItens extends StatefulWidget {
  const ListaItens({super.key});

  @override
  State<ListaItens> createState() => _ListaItensState();
}

class _ListaItensState extends State<ListaItens> {
  @override
  void initState() {
    super.initState();
    context.read<ComprasBloc>().add(BuscarCompraRecente());
    context.read<ItemBloc>().add(BuscarItens());
  }

  void _editarCampo({
    required String? valorAtual,
    required String titulo,
    required Function(String novoValor) onConfirmar,
  }) {
    final controller = TextEditingController(text: valorAtual);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Editar $titulo'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Digite nova $titulo'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              onConfirmar(controller.text.trim());
              Navigator.pop(context);
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComprasBloc, ComprasState>(
      builder: (context, state) {
        final items = state.compra?.itens ?? [];
        if (items.isEmpty) {
          return const ListaItensVaziaWidget();
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Column(
              children: items.map((item) {
                final precoTotal = (item.valor * item.quantidade)
                    .toStringAsFixed(2)
                    .replaceAll('.', ',');
                final isBought = item.comprado;

                final valorController = TextEditingController(
                  text: item.valor.toStringAsFixed(2),
                );

                return Stack(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      margin: EdgeInsets.only(bottom: 10.h),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: isBought
                            ? Colors.green.shade50
                            : Colors.grey.shade50,
                        border: Border.all(
                          color: isBought
                              ? Colors.green.shade200
                              : Colors.grey.shade200,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.read<ItemBloc>().add(
                                    AtualizarItens(
                                      item: item.copyWith(
                                        comprado: !item.comprado,
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(
                                  isBought
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: isBought ? Colors.green : Colors.grey,
                                  size: 20.sp,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Text(
                                  item.produto.nome,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: isBought
                                        ? Colors.green.shade900
                                        : Colors.black87,
                                    decoration: isBought
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                              ),

                              if (item.produto.marca != null || true)
                                EditableChip(
                                  valorAtual: item.produto.marca,
                                  hint: 'marca',
                                  corFundo: Colors.blue.shade50,
                                  onConfirmar: (novoValor) {
                                    final atualizado = item.copyWith(
                                      produto: item.produto.copyWith(
                                        marca: novoValor,
                                      ),
                                    );
                                    context.read<ComprasBloc>().add(
                                      AtualizarCompra(marca:atualizado),
                                    );
                                  },
                                ),

                              SizedBox(width: 8.w),

                              if (item.produto.categoria != null || true)
                                EditableChip(
                                  valorAtual: item.produto.categoria,
                                  hint: 'categoria',
                                  corFundo: Colors.orange.shade50,
                                  onConfirmar: (novoValor) {
                                    final atualizado = item.copyWith(
                                      produto: item.produto.copyWith(
                                        categoria: novoValor,
                                      ),
                                    );
                                    context.read<ComprasBloc>().add(
                                      AtualizarItens(item: atualizado),
                                    );
                                  },
                                ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 18.sp,
                                ),
                                onPressed: () {
                                  context.read<ItemBloc>().add(
                                    DeletarItem(itemId: item.id),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          if (item.comprado) ...[
                            Container(
                              height: 3.h,
                              color: const Color.fromARGB(255, 127, 133, 128),
                            ),
                          ],

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 120.w,
                                    height: 30.h,
                                    child: TextField(
                                      controller: valorController,
                                      onSubmitted: (value) {
                                        final novoValor = double.tryParse(
                                          value.replaceAll(',', '.'),
                                        );
                                        if (novoValor != null) {
                                          context.read<ItemBloc>().add(
                                            AtualizarItens(
                                              item: item.copyWith(
                                                valor: novoValor,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        CurrencyInputFormatter(),
                                      ],
                                      style: TextStyle(fontSize: 13.sp),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        prefixText: ' R\$',
                                        suffixText: '/UN',
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  IconButton(
                                    icon: Icon(Icons.remove, size: 18.sp),
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
                                    '${item.quantidade}',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: isBought
                                          ? Colors.grey
                                          : Colors.black87,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add, size: 18.sp),
                                    onPressed: () {
                                      final updated = item.copyWith(
                                        quantidade: item.quantidade + 1,
                                      );
                                      context.read<ItemBloc>().add(
                                        AtualizarItens(item: updated),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'Total: R\$ $precoTotal',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: isBought
                                        ? Colors.grey
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
