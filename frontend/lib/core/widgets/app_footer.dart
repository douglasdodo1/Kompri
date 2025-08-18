import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  final ValueChanged<int> onItemTapped;
  final int selectedIndex;

  const AppFooter({
    super.key,
    required this.onItemTapped,
    required this.selectedIndex,
  });

  final List<FooterItem> items = const [
    FooterItem(icon: Icons.home, label: 'Início'),
    FooterItem(icon: Icons.shopping_bag, label: 'Meus produtos'),
    FooterItem(icon: Icons.history, label: 'Histórico'),
  ];

  @override
  Widget build(BuildContext context) {
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
              onPressed: () => onItemTapped(index),
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

class FooterItem {
  final IconData icon;
  final String label;

  const FooterItem({required this.icon, required this.label});
}
