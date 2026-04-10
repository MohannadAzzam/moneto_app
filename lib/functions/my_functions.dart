import 'package:flutter/material.dart';

class MyFunctions {
  Future<bool?> showDeleteDialog({
    required BuildContext context,
    required String content,
    required VoidCallback onConfirm, // إضافة هذا السطر 
  }) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("تنبيه"),
        content: Text(content),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("إلغاء")),
        TextButton(onPressed: onConfirm, child: const Text("تأكيد", style: TextStyle(color: Colors.red))),
      ],
      ),
    );
  }
}
