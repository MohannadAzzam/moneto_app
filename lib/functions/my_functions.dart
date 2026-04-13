import 'package:flutter/material.dart';
import 'package:moneto_app/core/localization/app_localizations.dart';

class MyFunctions {
  Future<bool?> showDeleteDialog({
    required BuildContext context,
    required String content,
    required Function() onConfirm, // إضافة هذا السطر
  }) {
    var localization = AppLocalizations.of(context);
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:  Text("${localization?.translate('alert')}"),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:  Text("${localization?.translate('cancel')}"),
          ),
          TextButton(
            onPressed: onConfirm,
            child:  Text("${localization?.translate('confirm')}"),
          ),
        ],
      ),
    );
  }
}
