import 'package:moneto_app/data/models/expense.dart';

abstract class ExpenseState {}


class ExpenseLoading extends ExpenseState {}

class ExpenseLoaded extends ExpenseState {
  final List<Expense> expenses;
  ExpenseLoaded( { required this.expenses});
}

class ExpenseError extends ExpenseState {
  final String message;
  ExpenseError(this.message);
}
