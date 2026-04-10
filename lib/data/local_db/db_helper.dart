import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/expense.dart';

class DbHelper {
  static Database? _db;
  Database? mydb;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'moneto.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE "expenses" (
            "id" INTEGER PRIMARY KEY AUTOINCREMENT,
            "title" TEXT NOT NULL,
            "amount" REAL NOT NULL,
            "date" TEXT NOT NULL,
            "category" TEXT NOT NULL
          )
        ''');
      },
    );
  }

  // --- 1. دالة الإضافة (Create) ---
  Future<int> insertData(Expense model) async {
    mydb = await db;
    // نستخدم toMap() التي أنشأناها في الموديل لتحويل الكائن لبيانات تفهمها القاعدة
    return await mydb!.insert(
      "expenses",
      model.toMap(),
      // في حال تكرار الـ ID (نادراً ما يحدث مع Autoincrement) يقوم باستبداله
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // --- 2. دالة القراءة (Read) ---
  Future<List<Map<String, dynamic>>> readData() async {
    mydb = await db;
    // جلب البيانات وترتيبها من الأحدث للأقدم بناءً على الـ ID
    return await mydb!.query("expenses", orderBy: "id DESC");
  }

  // --- 3. دالة التعديل (Update) ---
  Future<int> updateData(Expense model) async {
    mydb = await db;
    return await mydb!.update(
      "expenses",
      model.toMap(),
      where: "id = ?",
      whereArgs: [model.id], // هذا هو مفتاح التعديل
    );
  }

  // --- 4. دالة الحذف (Delete) ---
  Future<int> deleteData(int id) async {
    mydb = await db;
    return await mydb!.delete("expenses", where: "id = ?", whereArgs: [id]);
  }

  // --- 5. دالة إضافية للمطورين: حذف قاعدة البيانات بالكامل ---
  // مفيدة جداً لو غيرت في هيكل الجدول وتريد إعادة إنشائه من الصفر
  Future<void> deleteMyDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'moneto.db');

    await deleteDatabase(path);
    _db = null; // تصفير المتغير لضمان إعادة التهيئة عند الطلب القادم
    print("Database Deleted Successfully");
  }
}
