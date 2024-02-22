import 'package:flutter/material.dart';
import 'package:movieapp/di/app_modules.dart';
import 'package:movieapp/presentation/common/localization/app_localizations.dart';
import 'package:movieapp/presentation/navigation/navigation_routes.dart';
import 'package:movieapp/presentation/utils/constants/app_styles.dart';

void main() {
  AppModules().setup(); // Setup dependency injection
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Movie App',
      theme: AppStyles.appTheme,
      darkTheme: AppStyles.appDarkTheme,
      themeMode: ThemeMode.system, // Enable automatic dark theme support
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.app_title,
      debugShowCheckedModeBanner: false,
    );
  }
}
