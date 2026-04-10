class Expense {
  final int? id;
  final String title;
  final double amount;
  final String date;
  final String category;

  Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });

  // للحفظ في قاعدة البيانات Sqflite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date,
      'category': category,
    };
  }

  // للعرض في التطبيق
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      // نستخدم (as num) لأنها تشمل الـ int والـ double معاً
      // ثم ننادي .toDouble() للتحويل الآمن
      amount: (map['amount'] as num).toDouble(),
      date: map['date'],
      category: map['category'],
    );
  }
}
