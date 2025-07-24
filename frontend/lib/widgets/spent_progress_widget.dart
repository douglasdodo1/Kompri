import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpentProgressWidget extends StatefulWidget {
  const SpentProgressWidget({Key? key}) : super(key: key);

  @override
  State<SpentProgressWidget> createState() => SpentProgressWidgetState();
}

class SpentProgressWidgetState extends State<SpentProgressWidget> {
  String mes = DateFormat.MMMM('pt_BR').format(DateTime.now());
  
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
        scale: isPressed ? 0.98 : 1.0,
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
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 8.r,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    mes,
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  ),
                  Icon(LucideIcons.target, size: 20, color: Colors.grey[300]),
                ],
              ),
              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gasto até agora',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Color(0xFFCBD5E1),
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
                              fontFeatures: [FontFeature.tabularFigures()],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Restante',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Color(0xFFCBD5E1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        'R\$ 500,00',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Color(0xFF6EE7B7),
                          fontWeight: FontWeight.w500,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 25.h),
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
                      Color.fromARGB(255, 15, 19, 22),
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),

              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('56% utilizado', style: TextStyle(color: Colors.white)),
                  SizedBox(
                    width: 120.w,
                    child: FittedBox(
                      child: Text(
                        'R\$ 1.000,00 total',
                        style: TextStyle(color: Colors.white),
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
