import 'package:flutter/material.dart';

import 'features/auth/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const Color primaryColor =
      Color(0xFF2563EB);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VisionMe',

      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
        ),

        scaffoldBackgroundColor:
            const Color(0xFFF8FAFC),

        fontFamily: 'Poppins',

        appBarTheme: const AppBarTheme(
          backgroundColor:
              Color(0xFFF8FAFC),

          foregroundColor:
              Colors.black,

          elevation: 0,

          scrolledUnderElevation: 0,

          surfaceTintColor:
              Colors.transparent,

          centerTitle: false,
        ),

        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 0,
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
                    24),
          ),
        ),

        elevatedButtonTheme:
            ElevatedButtonThemeData(
          style:
              ElevatedButton.styleFrom(
            backgroundColor:
                primaryColor,
            foregroundColor:
                Colors.white,

            elevation: 0,

            minimumSize:
                const Size(
              double.infinity,
              55,
            ),

            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                      18),
            ),
          ),
        ),

        inputDecorationTheme:
            InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,

          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),

          border:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
                    18),
            borderSide:
                BorderSide.none,
          ),

          enabledBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
                    18),
            borderSide:
                BorderSide.none,
          ),

          focusedBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
                    18),
            borderSide:
                const BorderSide(
              color: primaryColor,
              width: 1.5,
            ),
          ),
        ),
      ),

      home: const LoginScreen(),
    );
  }
}