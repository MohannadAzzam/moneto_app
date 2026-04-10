import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneto_app/constants/strings.dart';
import 'package:moneto_app/functions/my_functions.dart';
import 'package:moneto_app/presentation/widgets/build_expense_list.dart';
import '../../business_logic/expense_cubit/expense_cubit.dart';
import '../../business_logic/expense_cubit/expense_state.dart';
import '../../core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () => Navigator.pushNamed(context, settingsScreen),
          ),
        ],
        title: const Text(
          "Moneto",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<ExpenseCubit, ExpenseState>(
        builder: (context, state) {
          return switch (state) {
            ExpenseLoading() => Center(child: CircularProgressIndicator()),
            ExpenseLoaded() => buildExpenseList(
              state.expenses,
              MyFunctions(),
              context,
            ),
            ExpenseError() => Center(child: Text('حدث خطأ ما')),
            ExpenseState() => throw UnimplementedError(),
          };
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Navigator.pushNamed(context, addExpenseScreen),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}



            // Column(
            //   children: [
            //     buildTotalBalanceCard(state.expenses),
            //     const Padding(
            //       padding: EdgeInsets.symmetric(
            //         horizontal: 16.0,
            //         vertical: 8.0,
            //       ),
            //       child: Align(
            //         alignment: Alignment.centerRight,
            //         child: Text(
            //           "المصاريف الأخيرة",
            //           style: TextStyle(
            //             fontSize: 18,
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //       ),
            //     ),
            //     Expanded(
            //       child: state.expenses.isEmpty
            //           ? Center(
            //               child: Lottie.asset(
            //                 "assets/lottie/Wallet.json",
            //                 height: MediaQuery.of(context).size.width * 0.7,
            //                 width: MediaQuery.of(context).size.width * 0.7,
            //               ),
            //             )
            //           : ListView.builder(
            //               itemCount: state.expenses.length,
            //               itemBuilder: (context, index) {
            //                 final item = state.expenses[index];

            //                 // إضافة ميزة الحذف بالسحب
            //                 return Dismissible(
            //                   key: Key(item.id.toString()),
            //                   direction: DismissDirection.horizontal,
            //                   background: Container(
            //                     color: Colors.red,
            //                     alignment: Alignment.centerLeft,
            //                     padding: const EdgeInsets.only(left: 20),
            //                     child: const Icon(
            //                       Icons.delete,
            //                       color: Colors.white,
            //                     ),
            //                   ),
            //                   confirmDismiss: (direction) =>
            //                       myFunctions.showDeleteDialog(
            //                         // newRoute: homeScreen,
            //                         context,
            //                         content: "هل أنت متأكد من حذف هذا المصروف؟",
            //                       ),
            //                   onDismissed: (direction) {
            //                     context.read<ExpenseCubit>().deleteExpense(
            //                       item.id!,
            //                     );
            //                   },
            //                   child: buildExpenseItem(context, item),
            //                 );
            //               },
            //             ),
            //     ),
            //   ],
            // );
