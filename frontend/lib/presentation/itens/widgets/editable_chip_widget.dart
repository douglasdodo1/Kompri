import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditableChip extends StatefulWidget {
  final String? valorAtual;
  final String hint;
  final Color corFundo;
  final ValueChanged<String> onConfirmar;

  const EditableChip({
    super.key,
    required this.valorAtual,
    required this.hint,
    required this.corFundo,
    required this.onConfirmar,
  });

  @override
  State<EditableChip> createState() => _EditableChipState();
}

class _EditableChipState extends State<EditableChip> {
  bool editando = false;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.valorAtual);
  }

  @override
  Widget build(BuildContext context) {
    if (editando) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w),
        decoration: BoxDecoration(
          color: widget.corFundo,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: IntrinsicWidth(
          child: TextField(
            controller: controller,
            autofocus: true,
            style: TextStyle(fontSize: 10.sp),
            decoration: InputDecoration(
              hintText: widget.hint,
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 6.h),
            ),
            onSubmitted: (value) {
              widget.onConfirmar(value.trim());
              setState(() => editando = false);
            },
            onEditingComplete: () {
              widget.onConfirmar(controller.text.trim());
              setState(() => editando = false);
            },
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => setState(() => editando = true),
      child: Chip(
        label: Text(
          widget.valorAtual ?? widget.hint,
          style: TextStyle(fontSize: 10.sp),
        ),
        backgroundColor: widget.corFundo,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
