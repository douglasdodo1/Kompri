import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/calcular_valor_progresso.dart';
import 'package:frontend/core/utils/diferenca.dart';
import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/presentation/compras/bloc/compras_bloc.dart';
import 'package:frontend/presentation/compras/bloc/compras_event.dart';
import 'package:frontend/presentation/compras/bloc/compras_state.dart';
import 'package:frontend/core/utils/format_to_cash.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

class AnaliseGastos extends StatefulWidget {
  const AnaliseGastos({super.key});

  @override
  State<AnaliseGastos> createState() => _AnaliseGastosState();
}

class _AnaliseGastosState extends State<AnaliseGastos> {
  final TextEditingController _controller = TextEditingController();

  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    context.read<ComprasBloc>().add(BuscarCompraRecente());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleEdit(String valorAtual) {
    setState(() {
      if (!isEditing) {
        _controller.text = valorAtual.replaceAll(RegExp(r'[^0-9]'), '');
      }
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mes = DateFormat.MMMM('pt_BR').format(DateTime.now());

    return BlocConsumer<ComprasBloc, ComprasState>(
      listener: (context, state) {
        final compra = state.compra;
        if (compra != null) {
          final val = compra.valorEstimado;
          _controller.text = val.replaceAll(RegExp(r'[^0-9]'), '');
        }
      },
      builder: (context, state) {
        final ComprasEntity? compra = state.compra;
        final String valorEstimado = compra?.valorEstimado ?? '0.00';
        final String valorGastoCompra =
            state.compra?.itens
                .fold(
                  0.00,
                  (total, item) => item.comprado == true ? total + (item.quantidade * item.valor) : total,
                )
                .toStringAsFixed(2) ??
            "0.00";

        final String valorRestante = calcularDiferenca(
          valorEstimado,
          valorGastoCompra,
        );

        return GestureDetector(
          onTapDown: (_) => FocusScope.of(context).unfocus(),
          child: AnimatedScale(
            scale: 1.0,
            duration: const Duration(milliseconds: 100),
            child: Container(
              height: 200.h,
              width: 400.w,
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 8.r,
                    offset: const Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        mes,
                        style: TextStyle(fontSize: 20.sp, color: Colors.white),
                      ),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _toggleEdit(valorEstimado),
                            icon: const Icon(Icons.edit, size: 14),
                            label: Text(
                              "Editar",
                              style: TextStyle(fontSize: 12.sp),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              elevation: 0,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            LucideIcons.target,
                            size: 20,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gasto até agora',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xFFCBD5E1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 150.w,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'R\$ $valorGastoCompra',
                                style: TextStyle(
                                  fontSize: 35.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFeatures: const [
                                    FontFeature.tabularFigures(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Restante',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xFFCBD5E1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'R\$ $valorRestante',
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: (double.tryParse(valorRestante) ?? 0.0) > 0
                                  ? Color(0xFF6EE7B7)
                                  : Colors.red,
                              fontWeight: FontWeight.w500,
                              fontFeatures: const [
                                FontFeature.tabularFigures(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Container(
                    height: 8.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.grey[300],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                          begin: 0,
                          end: calcularValorProgresso(
                            valorGastoCompra,
                            valorEstimado,
                          ),
                        ),
                        duration: Duration(milliseconds: 500),
                        builder: (context, value, child) {
                          return LinearProgressIndicator(
                            value: value.clamp(0.0, 1.0),
                            backgroundColor: Colors.grey[300],
                            color: Color.fromARGB(255, 15, 19, 22),
                          );
                        },
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '56% utilizado',
                        style: TextStyle(color: Colors.white),
                      ),
                      if (!isEditing)
                        Text(
                          'R\$ $valorEstimado total',
                          style: TextStyle(color: Colors.white),
                        )
                      else
                        SizedBox(
                          width: 120.w,
                          height: 30.h,
                          child: TextField(
                            controller: _controller,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter(),
                            ],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                            ),
                            onSubmitted: (value) {
                              context.read<ComprasBloc>().add(
                                AtualizarCompra(valorEstimado: value),
                              );
                              _toggleEdit(valorEstimado);
                            },
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
