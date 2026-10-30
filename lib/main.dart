import 'package:flutter/material.dart';
<<<<<<< HEAD
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
=======
import 'package:flutter_3d_portfolio/ninja_game/core/ninja_animation.dart';
import 'package:flutter_3d_portfolio/ninja_game/utils/game_audio.dart';
import 'package:flutter_3d_portfolio/screens/home.dart';
import 'package:flutter_animate/flutter_animate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NinjaAnimation.load();
  await GameAudio.preload();
  runApp(const Flutter3dPortfolio());
}

class Flutter3dPortfolio extends StatelessWidget {
  const Flutter3dPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Ebrima'
      ),
      home: const Home(),
    ).animate().fadeIn(duration: 500.milliseconds);
  }
}
>>>>>>> f48b51b3b72dbb0c7a4afdfe4165de7090bf74b7
