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
          SwitchListTile(
            secondary: const Icon(
              Icons.dark_mode_outlined,
              color: Colors.black87,
            ),
            title: const Text("الوضع الليلي"),
            activeColor: AppColors.primary,
            value: false, // يجب ربطه بـ Cubit خاص بالثيم لاحقاً
            onChanged: (bool value) {
              // منطق تغيير الثيم
            },
          ),
          const Divider(),
          _buildSettingsSection("البيانات"),
          _buildSettingsItem(
            icon: Icons.delete_forever_outlined,
            title: "مسح جميع البيانات",
            titleColor: Colors.red,
            onTap: () {
              myFunctions.showDeleteDialog(
                context: context,
                content:
                    "هل أنت متأكد من حذف جميع البيانات؟ لن تتمكن من استعادتها.", // newRoute: homeScreen
            onConfirm: () {
                            context.read<ExpenseCubit>().deleteMyDatabase();
              Navigator.pop(context);
ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('تم مسح جميع البيانات')));
              
            },
              );
              // إظهار Dialog تأكيد لمسح قاعدة البيانات بالكامل
            },
          ),
          _buildSettingsItem(
            icon: Icons.info_outline,
            title: "عن التطبيق",
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Moneto',
                applicationVersion: '1.0.0',
                applicationIcon: const Icon(
                  Icons.wallet,
                  color: AppColors.primary,
                  size: 40,
                ),
                children: [
                  const Text("تطبيق ذكي لإدارة مصاريفك الشخصية بكل سهولة."),
                ],
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
