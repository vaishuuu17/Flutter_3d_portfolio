import 'package:flutter/material.dart';
import 'screens/portfolio_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VaishnaviPortfolioApp());
}

class VaishnaviPortfolioApp extends StatelessWidget {
  const VaishnaviPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vaishnavi More | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090B18),
        fontFamily: 'Ebrima',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9B7BFF),
          brightness: Brightness.dark,
        ),
      ),
      home: const PortfolioScreen(),
    );
  }
}
