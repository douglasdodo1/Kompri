import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/services/shared_preferences_service.dart';
import 'package:frontend/utils/format_to_cash.dart';
import 'package:frontend/utils/set_spents.dart';
import 'package:frontend/widgets/welcome_widget.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

class SpentProgressWidget extends StatefulWidget {
  const SpentProgressWidget({Key? key}) : super(key: key);

  @override
  State<SpentProgressWidget> createState() => SpentProgressWidgetState();
}

class SpentProgressWidgetState extends State<SpentProgressWidget> {
  String mes = DateFormat.MMMM('pt_BR').format(DateTime.now());
  bool isEstimatedValue = false;
  String estimatedValue = "0";
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEstimatedValue();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        builder: (context) => const WelcomeWidget(),
      ).then((_) => _loadEstimatedValue());
    });
  }

  Future<void> _loadEstimatedValue() async {
    final prefs = await SharedPreferencesService.getInstance();
    final value = prefs.getData('estimatedValue') ?? 0;
    setState(() {
      estimatedValue = value.toString();
      _controller.text = value.toString().replaceAll(RegExp(r'[^0-9]'), '');
    });
  }

  void setIsEditingEstimatedValue() {
    setState(() {
      isEstimatedValue = !isEstimatedValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isPressed = false;

    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Kompri button tapped!')));
      },
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          height: 200.h,
          width: 400.w,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
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
                      SizedBox(
                        height: 32.h,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _controller.text = estimatedValue.replaceAll(
                                RegExp(r'[^0-9]'),
                                '',
                              );
                              setIsEditingEstimatedValue();
                            });
                          },
                          icon: const Icon(Icons.edit, size: 14),
                          label: Text(
                            "Editar estimativa",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                              side: const BorderSide(color: Colors.transparent),
                            ),
                          ),
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
                          child: Text(
                            'R\$ 1.000,00',
                            style: TextStyle(
                              fontSize: 32.sp,
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
                        'R\$ 500,00',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: const Color(0xFF6EE7B7),
                          fontWeight: FontWeight.w500,
                          fontFeatures: const [FontFeature.tabularFigures()],
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
                  child: LinearProgressIndicator(
                    value: 0.6,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      const Color.fromARGB(255, 15, 19, 22),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('56% utilizado', style: TextStyle(color: Colors.white)),
                  if (!isEstimatedValue)
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'R\$ $estimatedValue total',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  else
                    SizedBox(
                      width: 120.w,
                      height: 30.h,
                      child: TextField(
                        onSubmitted: (value) {
                          setSpents(value);
                          _loadEstimatedValue();
                        },
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
                          labelText: 'R\$',
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
