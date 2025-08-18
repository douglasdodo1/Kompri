import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/presentation/produtos/bloc/produtos_bloc.dart';
import 'package:frontend/presentation/produtos/bloc/produtos_event.dart';
import 'package:frontend/presentation/produtos/bloc/produtos_state.dart';

class PesquisarProduto extends StatefulWidget {
  const PesquisarProduto({super.key});

  @override
  State<PesquisarProduto> createState() => _PesquisarProdutoState();
}

class _PesquisarProdutoState extends State<PesquisarProduto> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProdutosBloc, ProdutosState>(
      builder: (context, state) {
        return Center(
          child: Container(
            decoration: BoxDecoration(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: TextField(
                controller: controller,
                onChanged: (value) => context.read<ProdutosBloc>().add(
                  PesquisarProdutoString(value),
                ),
                decoration: InputDecoration(
                  hintText: 'Pesquisar produto por nome, categoria ou marca',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(width: 1, color: Colors.grey),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
