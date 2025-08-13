import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/presentation/compras/bloc/compras_bloc.dart';
import 'package:frontend/presentation/compras/bloc/compras_event.dart';
import 'package:frontend/presentation/compras/widgets/analise_gastos.dart';
import 'package:frontend/presentation/compras/widgets/boas_vindas.dart';
import 'package:frontend/presentation/compras/widgets/adicionar_item.dart';
import 'package:frontend/presentation/compras/widgets/lista_itens_widget.dart';

class CompraPage extends StatefulWidget {
  const CompraPage({super.key});

  @override
  State<CompraPage> createState() => _CompraPageState();
}

class _CompraPageState extends State<CompraPage> {
  @override
  void initState() {
    super.initState();

    context.read<ComprasBloc>().add(CarregarCompra());

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 248, 248, 245),
        title: const Text(
          "Nova compra",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 56, 57, 58),
            letterSpacing: 1.2,
            shadows: [
              Shadow(
                color: Colors.black26,
                offset: Offset(1, 1),
                blurRadius: 2,
              ),
            ],
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(color: Colors.grey, height: 1.0),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 24.h),
              const AnaliseGastos(),
              SizedBox(height: 15.h),
              const AdicionarItem(),
              SizedBox(height: 15.h),
              const ListaItens(),
            ],
          ),
        ),
      ),
    );
  }
}
