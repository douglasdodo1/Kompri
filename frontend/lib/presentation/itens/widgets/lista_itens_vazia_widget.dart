import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListaItensVaziaWidget extends StatelessWidget {
  const ListaItensVaziaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 60, color: Colors.grey[300]),
          SizedBox(height: 16.h),
          const Text(
            "Nenhum item ainda",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const Text(
            "Adicione um produto acima",
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
