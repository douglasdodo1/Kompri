import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/nome_do_mes.dart';
import 'package:frontend/presentation/compras/bloc/compras_bloc.dart';
import 'package:frontend/presentation/compras/bloc/compras_event.dart';
import 'package:frontend/presentation/compras/bloc/compras_state.dart';

class ListaCompras extends StatefulWidget {
  const ListaCompras({super.key});

  @override
  State<ListaCompras> createState() => _ListaComprasState();
}

class _ListaComprasState extends State<ListaCompras> {
  @override
  void initState() {
    super.initState();
    context.read<ComprasBloc>().add(BuscarCompras());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComprasBloc, ComprasState>(
      builder: (context, state) {
        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          itemCount: state.listaCompras.length,
          separatorBuilder: (_, _) => SizedBox(height: 8.h),
          itemBuilder: (context, index) {
            final item = state.listaCompras[index];
            final valor =
                double.tryParse(
                  state.economiaPorMes[item.id.toString()] ?? '0',
                ) ??
                0;
            final bool economizou = valor < 0;

            return Card(
              elevation: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8.h,
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
                                  "${state.porcentagemPorMesLucro[item.id.toString()]}%",
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
                                  color: economizou ? Colors.green : Colors.red,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            item.instituicao.nome,
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

                    SizedBox(height: 8.w),

                    Text(
                      economizou
                          ? "Você economizou ${state.economiaPorMes[item.id.toString()]?.substring(1)} em relação ao mês anterior"
                          : "Você gastou ${state.economiaPorMes[item.id.toString()]} a mais em relação ao mês anterior",
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
            );
          },
        );
      },
    );
  }
}
