import 'package:azkary/core/providers/favorite_provider.dart';
import 'package:azkary/core/providers/hadith_provider.dart';
import 'package:azkary/core/providers/quran_provider.dart';
import 'package:azkary/core/themes/color_app.dart';
import 'package:azkary/features/home/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/providers/azkar_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AzkarProvider()..fetchAzkar()),
        ChangeNotifierProvider(create: (_) => HadithProvider()..fetchDoaa()),
        ChangeNotifierProvider(create: (_) => QuranProvider()..fetchQuran()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: const Locale('ar', 'AE'),
        supportedLocales: const [
          Locale('ar', 'AE'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate, // Add this delegate
          GlobalWidgetsLocalizations.delegate, // Add this delegate
        ],
        debugShowCheckedModeBanner: false,
        //title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorApp.primaryColor),
          useMaterial3: true,
        ),
        home: const Directionality(
          // add this
          textDirection: TextDirection.rtl, // set this property
          child: SplashScreen(),
        ));
  }
}
