import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/presentation/itens/bloc/item_bloc.dart';
import 'package:frontend/presentation/itens/bloc/item_event.dart';
import 'package:frontend/presentation/itens/bloc/item_state.dart';

class ListaItens extends StatefulWidget {
  const ListaItens({super.key});

  @override
  State<ListaItens> createState() => _ListaItensState();
}

class _ListaItensState extends State<ListaItens> {
  @override
  void initState() {
    super.initState();
    context.read<ItemBloc>().add(BuscarItens());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemBloc, ItemState>(
      builder: (context, state) {
        final items = state.itens;
        if (items.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 60,
                  color: Colors.grey[300],
                ),
                SizedBox(height: 16.h),
                const Text(
                  "Nenhum item ainda",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                const Text(
                  "Adicione um produto acima",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Column(
              children: items.map((item) {
                final precoUnit = item.valor
                    .toStringAsFixed(2)
                    .replaceAll('.', ',');
                final precoTotal = (item.valor * item.quantidade)
                    .toStringAsFixed(2)
                    .replaceAll('.', ',');
                final isBought = item.comprado;
                final marcaController = TextEditingController(
                  text: item.produto.marca ?? "",
                );

                return Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: Material(
                    elevation: isBought ? 0 : 2,
                    borderRadius: BorderRadius.circular(10.r),
                    color: isBought ? Colors.green.shade50 : Colors.white,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Marca editável
                          TextField(
                            controller: marcaController,
                            decoration: InputDecoration(
                              hintText: "Marca (editar)",
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: 12.w,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[800],
                            ),
                            onSubmitted: (value) {
                              final updatedProduto = item.produto.copyWith(
                                marca: value,
                              );
                              final updatedItem = item.copyWith(
                                produto: updatedProduto,
                              );
                              context.read<ItemBloc>().add(
                                AtualizarItens(item: updatedItem),
                              );
                            },
                          ),
                          SizedBox(height: 8.h),

                          // Nome do produto
                          Text(
                            item.produto.nome,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              decoration: isBought
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: isBought ? Colors.grey : Colors.black87,
                            ),
                          ),
                          SizedBox(height: 10.h),

                          // Linha de controles
                          Row(
                            children: [
                              // Rádio de comprado
                              Radio<bool>(
                                value: true,
                                groupValue: isBought,
                                onChanged: (v) {
                                  final updated = item.copyWith(comprado: v!);
                                  context.read<ItemBloc>().add(
                                    AtualizarItens(item: updated),
                                  );
                                },
                              ),

                              // Preço unitário
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'R\$ $precoUnit / un',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: isBought
                                        ? Colors.grey
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),

                              // Quantidade
                              IconButton(
                                icon: Icon(Icons.remove, size: 20.sp),
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
                                  fontSize: 16.sp,
                                  color: isBought
                                      ? Colors.grey
                                      : Colors.black87,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, size: 20.sp),
                                onPressed: () {
                                  final updated = item.copyWith(
                                    quantidade: item.quantidade + 1,
                                  );
                                  context.read<ItemBloc>().add(
                                    AtualizarItens(item: updated),
                                  );
                                },
                              ),
                              SizedBox(width: 16.w),

                              // Preço total
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerRight,
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
                              ),

                              // Lixeira
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 24.sp,
                                ),
                                onPressed: () {
                                  context.read<ItemBloc>().add(
                                    DeletarItem(itemId: item.id),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
