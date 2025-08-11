import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/calcular_economia.dart';
import 'package:frontend/core/utils/nome_do_mes.dart';
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
        final listaOrdenada = List.from(bloc.state.listaCompras)
          ..sort((a, b) {
            final dateA = DateFormat('MM/yyyy').parse(a.data);
            final dateB = DateFormat('MM/yyyy').parse(b.data);

            return dateB.compareTo(dateA);
          });

        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ...List.generate(listaOrdenada.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 16,
                  ),
                  child: Card(
                    elevation: 2,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nomeDoMes(
                                  listaOrdenada[index].data.substring(0, 2),
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.sp,
                                ),
                              ),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 100.w,
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                      color: Colors.indigo[50],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child:
                                          double.parse(
                                                calcularEconomia(
                                                  listaOrdenada[index]
                                                      .valorTotal,
                                                  listaOrdenada[proximoItem(
                                                        index,
                                                        listaOrdenada.length,
                                                      )]
                                                      .valorTotal,
                                                ),
                                              ) <
                                              0
                                          ? Row(
                                              children: [
                                                Text(
                                                  "${calcularEconomia(listaOrdenada[index].valorTotal, listaOrdenada[proximoItem(index, listaOrdenada.length)].valorTotal)}%",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.sp,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),
                                                const Icon(
                                                  Icons.trending_up,
                                                  color: Colors.green,
                                                  size: 20,
                                                ),
                                              ],
                                            )
                                          : Row(
                                              children: [
                                                Text(
                                                  "${calcularEconomia(listaOrdenada[index].valorTotal, listaOrdenada[proximoItem(index, listaOrdenada.length)].valorTotal)}%",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16.sp,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),

                                                const Icon(
                                                  Icons.trending_down,
                                                  color: Colors.red,
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
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
