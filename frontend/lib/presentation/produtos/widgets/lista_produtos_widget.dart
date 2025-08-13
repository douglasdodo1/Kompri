import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/presentation/produtos/bloc/produtos_bloc.dart';
import 'package:frontend/presentation/produtos/bloc/produtos_event.dart';
import 'package:frontend/presentation/produtos/bloc/produtos_state.dart';

class ListaProdutosWidget extends StatefulWidget {
  const ListaProdutosWidget({super.key});

  @override
  State<ListaProdutosWidget> createState() => _ListaProdutosWidgetState();
}

class _ListaProdutosWidgetState extends State<ListaProdutosWidget> {
  @override
  void initState() {
    super.initState();
    context.read<ProdutosBloc>().add(BuscarProdutos());
  }

  @override
  Widget build(BuildContext context) {
    Color getCategoryColor(String categoria) {
      switch (categoria.toLowerCase()) {
        case 'grãos':
          return Colors.amber.shade100;
        case 'laticínios':
          return Colors.blue.shade100;
        case 'limpeza':
          return Colors.green.shade100;
        case 'padaria':
          return Colors.orange.shade100;
        case 'higiene':
          return Colors.purple.shade100;
        default:
          return Colors.grey.shade200;
      }
    }

    IconData getCategoryIcon(String categoria) {
      switch (categoria.toLowerCase()) {
        case 'grãos':
          return Icons.grain;
        case 'laticínios':
          return Icons.local_drink;
        case 'limpeza':
          return Icons.cleaning_services;
        case 'padaria':
          return Icons.bakery_dining;
        case 'higiene':
          return Icons.soap;
        default:
          return Icons.shopping_bag;
      }
    }

    return BlocBuilder<ProdutosBloc, ProdutosState>(
      builder: (context, state) {
        return Container(
          color: const Color.fromARGB(255, 240, 238, 238),
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: state.listaProdutos.length,
            separatorBuilder: (_, _) => SizedBox(height: 8.h),

            itemBuilder: (context, index) {
              return Card(
                elevation: 3,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {
                    print('Produto clicado: ${state.listaProdutos[index]}');
                  },
                  child: Row(
                    children: [
                      Container(
                        width: 80.w,
                        height: 80.h,
                        margin: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: getCategoryColor(
                            state.listaProdutos[index].categoria ?? "",
                          ),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Icon(
                          getCategoryIcon(
                            state.listaProdutos[index].categoria ?? "",
                          ),
                          size: 40.sp,
                          color: Colors.grey.shade800,
                        ),
                      ),

                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text(
                              state.listaProdutos[index].nome,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),

                            Text(
                              "${state.listaProdutos[index].marca} • ${state.listaProdutos[index].categoria}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(right: 8.w, top: 8.h),
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
