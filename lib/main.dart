import 'package:flutter/material.dart';
import 'package:tmed_vc/constants/app_router.dart';

import 'constants/colors.dart';

void main() {
  // Run Flutter App
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Material App
    return MaterialApp.router(
      title: 'T-MED VC',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme().copyWith(color: primaryColor),
        primaryColor: primaryColor,
        scaffoldBackgroundColor: secondaryColor,
      ),
      routerConfig: AppRouts.router,
    );
  }
}
