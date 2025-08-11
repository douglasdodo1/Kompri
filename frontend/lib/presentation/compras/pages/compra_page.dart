import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/presentation/compras/bloc/compras_bloc.dart';
import 'package:frontend/presentation/compras/bloc/compras_event.dart';
import 'package:frontend/presentation/compras/widgets/analise_gastos.dart';
import 'package:frontend/presentation/compras/widgets/boas_vindas.dart';
import 'package:frontend/presentation/compras/widgets/adicionar_item.dart';
import 'package:frontend/presentation/compras/widgets/lista_itens_widget.dart';

class CompraPage extends StatelessWidget {
  const CompraPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Adiciona o evento diretamente no build usando o bloc do contexto
    context.read<ComprasBloc>().add(CarregarCompra());

    return const _ComprasView();
  }
}

class _ComprasView extends StatefulWidget {
  const _ComprasView();

  @override
  State<_ComprasView> createState() => _ComprasViewState();
}

class _ComprasViewState extends State<_ComprasView> {
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
            child: const BoasVindas(),
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: ListView(
              children: <Widget>[
                SizedBox(height: 24.h),
                AnaliseGastos(),
                SizedBox(height: 15.h),
                AdicionarItem(),
                SizedBox(height: 15.h),
                ListaItens(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
