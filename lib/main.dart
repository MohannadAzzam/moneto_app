// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneto_app/business_logic/expense_cubit/expense_cubit.dart';
import 'package:moneto_app/constants/strings.dart';
import 'package:moneto_app/core/routing/app_router.dart';

void main() {
  // يفضل تعريف الراوتر هنا وتمريره
  final AppRouter appRouter = AppRouter();
  runApp(MonetoApp(appRouter: appRouter));
}

class MonetoApp extends StatelessWidget {
  final AppRouter appRouter; // تأكد من وجود هذا السطر

  const MonetoApp({super.key, required this.appRouter}); // والكونستركتور يتطلبه

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute, // استخدام الراوتر هنا
      initialRoute: homeScreen,
    );
  }
}
