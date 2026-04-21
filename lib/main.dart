import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/core/services/hive_service.dart';
import 'package:notes_app/presentation/screens/home/home_screen.dart';
import 'package:notes_app/presentation/screens/splash/splash_screen.dart';

import 'core/services/connectivity_services.dart';
import 'core/services/sync_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await Hive.initFlutter();
  await HiveService.openBoxes();

  final connectivityService = ConnectivityService();
  connectivityService.listen();

  // 🔥 ADD THIS
  await SyncService().processQueue();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),

      },
    );
  }
}
