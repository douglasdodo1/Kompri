import 'package:flutter/material.dart';
import 'package:frontend/presentation/compras/pages/compras_page.dart';

class AppFooter extends StatefulWidget {
  const AppFooter({super.key});

  @override
  State<AppFooter> createState() => _AppFooterState();
}

class _AppFooterState extends State<AppFooter> {
  int selectedIndex = 0;

  final List<_FooterItem> items = const [
    _FooterItem(icon: Icons.home, label: 'Início'),
    _FooterItem(icon: Icons.view_week, label: 'código de barras'),
    _FooterItem(icon: Icons.shopping_cart, label: 'Carrinho'),
    _FooterItem(icon: Icons.history, label: 'Histórico'),
  ];

  @override
  Widget build(BuildContext context) {
    void redirect() {
      if (selectedIndex == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ComprasPage()),
        );
      }
    }

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey, width: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = selectedIndex == index;

          return Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedIndex = index;
                });
                redirect();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected ? Colors.indigo[50] : Colors.white,
                foregroundColor: isSelected ? Colors.indigo : Colors.grey[700],
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.icon, size: 24),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _FooterItem {
  final IconData icon;
  final String label;

  const _FooterItem({required this.icon, required this.label});
}
