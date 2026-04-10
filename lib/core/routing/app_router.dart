import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneto_app/constants/strings.dart';
import 'package:moneto_app/presentation/screens/add_expense_screen.dart';
import 'package:moneto_app/presentation/screens/lottie_screen.dart';
import 'package:moneto_app/presentation/screens/settings_screen.dart';
import '../../business_logic/expense_cubit/expense_cubit.dart';
import '../../presentation/screens/home_screen.dart';

class AppRouter {
  // نقوم بإنشاء نسخة واحدة من الـ Cubit هنا إذا أردنا مشاركتها بين كل الشاشات
  // أو إنشاؤه داخل الـ MaterialPageRoute إذا كان مخصصاً لشاشة واحدة.
  final ExpenseCubit _expenseCubit = ExpenseCubit();

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _expenseCubit..fetchExpenses(),
            child: const HomeScreen(),
          ),
        );

      case addExpenseScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider.value(
            value: _expenseCubit, // تمرير الـ Cubit الحالي للشاشة الجديدة
            child: const AddExpenseScreen(),
          ),
        );
      case settingsScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ExpenseCubit(),
            child: const SettingsScreen(),
          ),
        );

      case lottieScreen:
        return MaterialPageRoute(builder: (_) => LottieScreen());

      default:
        return null;
    }
  }

  // دالة لإغلاق الـ Cubit عند إغلاق التطبيق نهائياً
  void dispose() {
    _expenseCubit.close();
  }
}
