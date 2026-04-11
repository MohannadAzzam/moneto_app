// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moneto_app/business_logic/locale_cubit/locale_cubit.dart';
import 'package:moneto_app/constants/strings.dart';
import 'package:moneto_app/core/localization/app_localizations_delegate.dart';
import 'package:moneto_app/core/routing/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final String cachedLanguageCode = prefs.getString('language') ?? 'ar';

  final AppRouter appRouter = AppRouter();
  runApp(
    BlocProvider(
      create: (context) => LocaleCubit(locale: Locale(cachedLanguageCode)), // تمرير اللغة المحفوظة إلى Cubit
      child: MonetoApp(appRouter: appRouter),
    ),
  );
}

class MonetoApp extends StatelessWidget {
  final AppRouter appRouter; 

  const MonetoApp({super.key, required this.appRouter}); // والكونستركتور يتطلبه

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp(
          locale: locale,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates:  [
            const AppLocalizationsDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          
          
          debugShowCheckedModeBanner: false,
          onGenerateRoute: appRouter.generateRoute, // استخدام الراوتر هنا
          initialRoute: homeScreen,
        );
      },
    );
  }
}
