import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/calcular_economia.dart';
import 'package:frontend/core/utils/nome_do_mes.dart';
import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/presentation/compras/bloc/compras_bloc.dart';
import 'package:frontend/presentation/compras/bloc/compras_event.dart';
import 'package:frontend/presentation/compras/bloc/compras_state.dart';
import 'package:intl/intl.dart';

class ListaCompras extends StatefulWidget {
  const ListaCompras({super.key});

  @override
  State<ListaCompras> createState() => _ListaComprasState();
}

class _ListaComprasState extends State<ListaCompras> {
  late final ComprasBloc bloc;

  int proximoItem(int indexAtual, int tamanho) {
    if (indexAtual < tamanho - 1) {
      return indexAtual + 1;
    } else {
      return indexAtual;
    }
  }

  @override
  void initState() {
    super.initState();
    bloc = context.read<ComprasBloc>();
    bloc.add(BuscarCompras());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComprasBloc, ComprasState>(
      builder: (context, state) {
        final List<ComprasEntity> listaOrdenada =
            List.from(bloc.state.listaCompras)..sort((a, b) {
              final dateA = DateFormat('MM/yyyy').parse(a.data);
              final dateB = DateFormat('MM/yyyy').parse(b.data);
              return dateB.compareTo(dateA);
            });

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            spacing: 5.h,
            children: listaOrdenada.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final proximo =
                  listaOrdenada[proximoItem(index, listaOrdenada.length)];
              final economia = double.parse(
                calcularEconomia(item.valorTotal, proximo.valorTotal),
              );
              final economizou = economia < 0;
              final porcentagemLucro = economia.abs().toStringAsFixed(2);

              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 16,
                ),
                child: Card(
                  elevation: 2,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nomeDoMes(item.data.substring(0, 2)),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.sp,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 85.w,
                                  height: 30.h,
                                  decoration: BoxDecoration(
                                    color: Colors.indigo[50],
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Row(
                                      children: [
                                        Text(
                                          "$porcentagemLucro%",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                            color: economizou
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                        Icon(
                                          economizou
                                              ? Icons.trending_up
                                              : Icons.trending_down,
                                          color: economizou
                                              ? Colors.green
                                              : Colors.red,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                "Instituição: ${item.instituicao.nome}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Comprou: ${item.qtdItens} itens",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 8.h),

                        Text(
                          economizou
                              ? "Você economizou $porcentagemLucro% em relação ao mês anterior"
                              : "Você gastou $porcentagemLucro% a mais em relação ao mês anterior",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12.sp,
                          ),
                        ),

                        Divider(color: Colors.grey[300]),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total: R\$ ${item.valorTotal}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            ),
                            Text(
                              "Estimado: R\$ ${item.valorEstimado}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
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
        );
      },
    );
  }
}
