
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:moneto_app/business_logic/expense_cubit/expense_cubit.dart';
import 'package:moneto_app/data/models/expense.dart';
import 'package:moneto_app/functions/my_functions.dart';
import 'package:moneto_app/presentation/widgets/build_expense_item.dart';
import 'package:moneto_app/presentation/widgets/build_total_balanced_card.dart';

Widget buildExpenseList(List<Expense> expenses,MyFunctions myFunctions, BuildContext context) {

  return Column(
    children: [
      buildTotalBalanceCard(expenses),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "المصاريف الأخيرة",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Expanded(
        child:
        expenses.isEmpty
                      ? Center(
                          child: Lottie.asset(
                            "assets/lottie/Wallet.json",
                            height: MediaQuery.of(context).size.width * 0.7,
                            width: MediaQuery.of(context).size.width * 0.7,
                          ),
                        )
                      :
                       ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (context, index) {
            final item = expenses[index];
            return Dismissible(
              key: Key(item.id.toString()),
              direction: DismissDirection.horizontal,
              // background: myFunctions.showDeleteDialog(context, content: content),
              confirmDismiss: (direction) => myFunctions.showDeleteDialog(
                context :context,
                content: "هل أنت متأكد من حذف هذا المصروف؟",
              ),
              onDismissed: (_) {
                context.read<ExpenseCubit>().deleteExpense(item.id!);
              },
              child: buildExpenseItem(context, item),
            );
          },
        ),
      ),
    ],
  );
}