import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/services/shared_preferences_service.dart';
import 'package:frontend/utils/format_to_cash.dart';
import 'package:frontend/utils/set_spents.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  State<WelcomeWidget> createState() => WelcomeWidgetState();
}

class WelcomeWidgetState extends State<WelcomeWidget> {
  final TextEditingController _controller = TextEditingController();

  String mes = DateFormat.MMMM('pt_BR').format(DateTime.now());
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
        height: 200.h,
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

            SizedBox(height: 17.h),
            Align(
              alignment: Alignment.center,
              child: Text("Orçamento para $mes de ${DateTime.now().year}"),
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
                setSpents(_controller.text);
                Navigator.pop(context);
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
