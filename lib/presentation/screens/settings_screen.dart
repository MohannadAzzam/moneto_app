import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneto_app/business_logic/expense_cubit/expense_cubit.dart';
import 'package:moneto_app/functions/my_functions.dart';
import '../../core/theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyFunctions myFunctions = MyFunctions();
    return Scaffold(
      appBar: AppBar(title: const Text("الإعدادات"), centerTitle: true),
      body: ListView(
        children: [
          _buildSettingsSection("عام"),
          _buildSettingsItem(
            icon: Icons.monetization_on_outlined,
            title: "العملة",
            trailing: "NIS",
            onTap: () {
              // هنا يمكنك إضافة منطق تغيير العملة لاحقاً
            },
          ),
          _buildSettingsItem(
            icon: Icons.dark_mode_outlined,
            title: "الوضع الليلي",
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const Divider(),
          _buildSettingsSection("البيانات"),
          _buildSettingsItem(
            icon: Icons.delete_forever_outlined,
            title: "مسح جميع البيانات",
            titleColor: Colors.red,
            onTap: () {
              context.read<ExpenseCubit>().deleteMyDatabase();
              myFunctions.showDeleteDialog(
                context: context,
                content: "هل أنت متأكد من حذف جميع البيانات؟",
                // newRoute: homeScreen
              );

              // إظهار Dialog تأكيد لمسح قاعدة البيانات بالكامل
            },
          ),
          _buildSettingsItem(
            icon: Icons.info_outline,
            title: "عن التطبيق",
            onTap: () {
              showBottomSheet(
                context: context,
                builder: (context) => Text('sdklfjkalefjsdifjweiofjo'),
              );
            
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    dynamic trailing,
    Color? titleColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: titleColor ?? Colors.black87),
      title: Text(title, style: TextStyle(color: titleColor)),
      trailing: trailing is String
          ? Text(trailing, style: const TextStyle(color: Colors.grey))
          : trailing,
    );
  }
}
