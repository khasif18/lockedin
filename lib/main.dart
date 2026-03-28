import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const LockedInApp());
}

class LockedInApp extends StatelessWidget {
  const LockedInApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LockedIn',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

// Compatibility alias to satisfy the default widget test that expects `MyApp`.
class MyApp extends LockedInApp {
  const MyApp({super.key});
}
