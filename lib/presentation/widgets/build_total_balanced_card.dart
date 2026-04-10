
  import 'package:flutter/material.dart';
import 'package:moneto_app/core/theme/app_colors.dart';
import 'package:moneto_app/data/models/expense.dart';

Widget buildTotalBalanceCard(List<Expense> expenses) {
    double total = expenses.fold(0.0, (double sum, item) => sum + item.amount);
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "إجمالي المصاريف",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(
            "${total.toStringAsFixed(2)} NIS",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
