import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/local_db/db_helper.dart';
import '../../data/models/expense.dart';
import 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  final DbHelper dbHelper = DbHelper();

  ExpenseCubit() : super(ExpenseLoading());

  // --- جلب البيانات ---
  void fetchExpenses() async {
    emit(ExpenseLoading());
    try {
      final data = await dbHelper.readData();
      // تحويل الـ List<Map> إلى List من الموديل بتاعنا
      List<Expense> expenses = data.map((e) => Expense.fromMap(e)).toList();
      emit(ExpenseLoaded(expenses));
    } catch (e) {
      emit(ExpenseError("فشل في تحميل البيانات"));
    }
  }

  // --- إضافة مصروف ---
  void addExpense(Expense expense) async {
    try {
      await dbHelper.insertData(expense);
      fetchExpenses(); // تحديث القائمة فوراً بعد الإضافة
    } catch (e) {
      emit(ExpenseError("فشل في إضافة المصروف"));
    }
  }

  // --- حذف مصروف ---
  void deleteExpense(int id) async {
    try {
      await dbHelper.deleteData(id);
      fetchExpenses(); // تحديث القائمة فوراً بعد الحذف
    } catch (e) {
      emit(ExpenseError("فشل في حذف المصروف"));
    }
  }

  void updateExpense(Expense expense) async {
    try {
      await dbHelper.updateData(
        expense,
      ); // نادِ دالة الـ update من الـ DbHelper
      fetchExpenses(); // حدّث الواجهة فوراً
    } catch (e) {
      emit(ExpenseError("فشل في تحديث البيانات"));
    }
  }

  void deleteMyDatabase() async {
    try {
      await dbHelper.deleteMyDatabase();
    } catch (e) {
      emit(ExpenseError("فشل في حذف البيانات"));
    }
  }
}
