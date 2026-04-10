import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/expense_cubit/expense_cubit.dart';
import '../../data/models/expense.dart';
import '../../core/theme/app_colors.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  // فئة افتراضية، يمكنك لاحقاً تحويلها لـ Dropdown
  // final String _category = "عام";

  Expense? existingExpense; // لتخزين البيانات المرسلة للتعديل
  bool isEditMode = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && args is Expense) {
      existingExpense = args;
      isEditMode = true;
      _titleController.text = existingExpense!.title;
      _amountController.text = existingExpense!.amount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditMode ? "تعديل مصروف" : "إضافة مصروف",
          style: const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "ماذا صرفت؟",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // حقل العنوان
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "مثلاً: غداء، بنزين، إنترنت",
                  filled: true,
                  fillColor: AppColors.bgCyan.withValues(alpha: 0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.description_outlined),
                ),
                validator: (value) =>
                    value!.isEmpty ? "برجاء إدخال الوصف" : null,
              ),

              const SizedBox(height: 25),
              const Text(
                "المبلغ (NIS)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // حقل المبلغ
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: InputDecoration(
                  hintText: "0.00",
                  filled: true,
                  fillColor: AppColors.bgCyan.withValues(alpha: 0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(
                    Icons.attach_money,
                    color: AppColors.moneyGreen,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "برجاء إدخال المبلغ";
                  if (double.tryParse(value) == null) return "أدخل رقم صحيح";
                  return null;
                },
              ),

              const Spacer(),

              // زر الحفظ
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _saveExpense,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    // shape: BorderRadius.circular(15),
                    elevation: 5,
                  ),
                  child: const Text(
                    "حفظ في المحفظة",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _saveExpense() {
    if (_formKey.currentState!.validate()) {
      final expense = Expense(
        id: existingExpense?.id, // في حال التعديل نرسل نفس الـ ID
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        date: existingExpense?.date ?? DateTime.now().toString().split(' ')[0],
        category: "عام",
      );

      if (isEditMode) {
        // تأكد من إضافة دالة updateExpense في الـ Cubit
        context.read<ExpenseCubit>().updateExpense(expense);
      } else {
        context.read<ExpenseCubit>().addExpense(expense);
      }

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
