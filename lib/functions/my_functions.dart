import 'package:flutter/material.dart';

class MyFunctions {
  
  Future<bool?> showDeleteDialog({required BuildContext context,required String content}) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("تأكيد الحذف"),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("إلغاء"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text("حذف", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

}