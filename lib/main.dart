import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const CineQuotesApp());
}

// ============================================================
// CINEQUOTES APP
// ============================================================

class CineQuotesApp extends StatelessWidget {
  const CineQuotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'CineQuotes',

      // ========================================================
      // APP THEME
      // ========================================================

      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4527A0),
        ),

        scaffoldBackgroundColor:
            const Color(0xFFF9F5FC),
      ),

      home: const HomeScreen(),
    );
  }
}