import 'package:flutter/material.dart';
import 'package:frontend/core/widgets/app_footer.dart';

class PaginaBase extends StatefulWidget {
  @override
  State<PaginaBase> createState() => _PaginaBaseState();
}

class _PaginaBaseState extends State<PaginaBase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kompri")),
      body: Container(),
      bottomNavigationBar: AppFooter(),
    );
  }
}
