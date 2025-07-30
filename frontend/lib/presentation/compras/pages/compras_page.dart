import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/presentation/compras/bloc/compras_bloc.dart';
import 'package:frontend/presentation/compras/bloc/compras_event.dart';
import 'package:frontend/presentation/compras/widgets/analysis_widget.dart';
import 'package:frontend/presentation/compras/widgets/spent_progress_widget.dart';
import 'package:frontend/presentation/compras/widgets/welcome_widget.dart';
import 'package:frontend/services/injection_container.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ComprasPage extends StatelessWidget {
  const ComprasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ComprasBloc>()..add(CarregarCompra()),
      child: const _ComprasView(),
    );
  }
}

class _ComprasView extends StatefulWidget {
  const _ComprasView();

  @override
  State<_ComprasView> createState() => _ComprasViewState();
}

class _ComprasViewState extends State<_ComprasView> {
  void _incrementCounter() {}

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return BlocProvider.value(
            value: context.read<ComprasBloc>(),
            child: const WelcomeWidget(),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Kompri - Compras"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 24.h),
              const SpentProgressWidget(),
              SizedBox(height: 24.h),
              _buildButtons(),
              SizedBox(height: 24.h),
              const AnalysisWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 80.h,
              child: ElevatedButton(
                onPressed: _incrementCounter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[600],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor: Colors.black.withValues(alpha: (0.2)),
                  elevation: 6,
                  padding: EdgeInsets.zero,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(LucideIcons.plus, size: 28),
                    SizedBox(height: 6),
                    Text(
                      "Nova compra",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: SizedBox(
              height: 80.h,
              child: ElevatedButton(
                onPressed: _incrementCounter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.grey[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.zero,
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      LucideIcons.search,
                      size: 28,
                      color: Color(0xFF475569),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "text",
                      style: TextStyle(
                        color: Color(0xFF334155),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
