import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/widgets/app_footer.dart';
import 'package:frontend/presentation/compras/bloc/compras_bloc.dart';
import 'package:frontend/presentation/compras/bloc/compras_event.dart';
import 'package:frontend/presentation/compras/widgets/escolher_instituicao.dart';
import 'package:frontend/presentation/compras/widgets/spent_progress_widget.dart';
import 'package:frontend/presentation/compras/widgets/welcome_widget.dart';
import 'package:frontend/presentation/itens/bloc/item_bloc.dart';
import 'package:frontend/presentation/itens/bloc/item_event.dart';
import 'package:frontend/presentation/itens/widgets/adicionar_item.dart';
import 'package:frontend/presentation/itens/widgets/lista_itens_widget.dart';
import 'package:frontend/services/injection_container.dart';

class ComprasPage extends StatelessWidget {
  const ComprasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<ComprasBloc>()..add(CarregarCompra())),
        BlocProvider(create: (_) => sl<ItemBloc>()..add(BuscarItens())),
      ],
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
          child: ListView(
            children: <Widget>[
              SizedBox(height: 24.h),
              const SpentProgressWidget(),
              SizedBox(height: 15.h),
              AdicionarItem(),
              SizedBox(height: 2.h),
              ListaItens(),
            ],
          ),
        ),
        bottomNavigationBar: AppFooter(),
      ),
    );
  }
}
