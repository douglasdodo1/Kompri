import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/format_to_cash.dart';
import 'package:frontend/core/utils/nome_do_mes.dart';
import 'package:frontend/domain/compras/entities/compras_entity.dart';
import 'package:frontend/domain/instituicoes/entities/instituicao_entity.dart';
import 'package:frontend/presentation/compras/bloc/compras_bloc.dart';
import 'package:frontend/presentation/compras/bloc/compras_event.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BoasVindas extends StatefulWidget {
  const BoasVindas({super.key});

  @override
  State<BoasVindas> createState() => BoasVindasState();
}

class BoasVindasState extends State<BoasVindas> {
  final TextEditingController _controller = TextEditingController();

  String data = DateFormat('MM/yyyy', 'pt_BR').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.target, size: 20, color: const Color(0xFF6366F1)),
            SizedBox(width: 5.w),
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                'Defina seu orçamento',
                style: TextStyle(fontSize: 22.sp),
              ),
            ),
          ],
        ),
      ),
      content: SizedBox(
        height: 170.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Qual valor você deseja gastar em compras esse mês?",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF475569)),
            ),

            Text(
              "Isso nos ajudará a acompanhar seus gastos e manter você no controle.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF64748B)),
            ),

            Align(
              alignment: Alignment.center,
              child: Text(
                "Orçamento para ${nomeDoMes(data.substring(0, 2))} de ${data.substring(3)}",
              ),
            ),

            SizedBox(
              height: 40.h,
              width: 220.w,
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyInputFormatter(),
                ],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'R\$',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: SizedBox(
            width: 220.w,
            child: ElevatedButton(
              onPressed: () {
                final valorEstimado = _controller.text;

                final compra = ComprasEntity(
                  id: 0,
                  data: data,
                  status: "aberta",
                  valorTotal: "0.00",
                  valorEstimado: valorEstimado,
                  qtdItens: 0,
                  usuarioCpf: "12345678900",
                  itens: [],
                  instituicao: InstituicaoEntity(id: 1, nome: ""),
                );
                Navigator.pop(context);
                context.read<ComprasBloc>().add(CriarCompra(compra));
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Definir orçamento",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
