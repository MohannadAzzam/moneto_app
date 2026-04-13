import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneto_app/business_logic/expense_cubit/expense_cubit.dart';
import 'package:moneto_app/business_logic/locale_cubit/locale_cubit.dart';
import 'package:moneto_app/core/localization/app_localizations.dart';
import 'package:moneto_app/functions/my_functions.dart';
import '../../core/theme/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyFunctions myFunctions = MyFunctions();
    var localization = AppLocalizations.of(context);

    // جلب اللغة الحالية لمعرفتها في الواجهة
    String currentLanguage = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text("${localization?.translate('settings')}"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          _buildSettingsSection(
            "${localization?.translate('category_general')}",
          ),

          _buildSettingsItem(
            icon: Icons.language,
            title: currentLanguage == 'ar'
                ? "اللغة (العربية)"
                : "Language (English)",
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _showLanguageDialog(context);
            },
          ),

          SwitchListTile(
            secondary: const Icon(
              Icons.dark_mode_outlined,
              color: Colors.black87,
            ),
            title: Text("${localization?.translate('dark_mode')}"),
            activeThumbColor: AppColors.primary,
            value: false, // يجب ربطه بـ Cubit خاص بالثيم لاحقاً
            onChanged: (bool value) {
              // منطق تغيير الثيم
            },
          ),
          const Divider(),
          _buildSettingsSection("${localization?.translate('data')}"),
          _buildSettingsItem(
            icon: Icons.delete_forever_outlined,
            title: "${localization?.translate('delete_all_data')}",
            titleColor: Colors.red,
            onTap: () {
              myFunctions.showDeleteDialog(
                context: context,
                content:
                    "${localization?.translate('delete_data_confirmation')}", // newRoute: homeScreen
                onConfirm: () async {
                  // جلب الـ Cubit قبل إغلاق الـ Dialog
                  final expenseCubit = context.read<ExpenseCubit>();

                  // تنفيذ عملية الحذف وانتظارها
                  await expenseCubit.deleteMyDatabase();

                  // إغلاق الديالوج
                  if (context.mounted) {
                    Navigator.of(context).pop();

                    // إظهار رسالة النجاح
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          localization?.translate('data_deleted_success') ??
                              "تم الحذف",
                        ),
                      ),
                    );
                  }
                },
              );
              // إظهار Dialog تأكيد لمسح قاعدة البيانات بالكامل
            },
          ),
          _buildSettingsItem(
            icon: Icons.info_outline,
            title: "${localization?.translate('about_app')}",
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
                children: [Text("${localization?.translate('description')}")],
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

void _showLanguageDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Text("🇵🇸", style: TextStyle(fontSize: 24)),
              title: const Text("العربية"),
              trailing: Localizations.localeOf(context).languageCode == 'ar'
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                context.read<LocaleCubit>().changeLanguage('ar');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Text("🇺🇸", style: TextStyle(fontSize: 24)),
              title: const Text("English"),
              trailing: Localizations.localeOf(context).languageCode == 'en'
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                context.read<LocaleCubit>().changeLanguage('en');
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}
