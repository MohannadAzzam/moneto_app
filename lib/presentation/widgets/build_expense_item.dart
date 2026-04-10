
  import 'package:flutter/material.dart';
import 'package:moneto_app/constants/strings.dart';
import 'package:moneto_app/core/theme/app_colors.dart';
import 'package:moneto_app/data/models/expense.dart';

Widget buildExpenseItem(BuildContext context, Expense item) {
    return ListTile(
      onTap: () {
        // نمرر الـ item كـ arguments لشاشة الإضافة لتعمل كشاشة تعديل
        Navigator.pushNamed(context, addExpenseScreen, arguments: item);
      },
      leading: CircleAvatar(
        backgroundColor: AppColors.bgCyan,
        child: const Icon(Icons.wallet, color: AppColors.primary),
      ),
      title: Text(
        item.title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(item.date),
      trailing: Text(
        "-${item.amount.toStringAsFixed(2)}",
        style: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
