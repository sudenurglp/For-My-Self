import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sude/splash_screen.dart';

Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb){
 await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyDPraHu7vVKWnaR4lwsJbHnRy2wL5D1Phc",
  authDomain: "sude-114ca.firebaseapp.com",
  projectId: "sude-114ca",
      storageBucket: "sude-114ca.appspot.com",
      messagingSenderId: "444420057285",
      appId: "1:444420057285:web:2433e01d10411263c568ac",));
 } else {
    await Firebase.initializeApp();
     }
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  statusBarColor: Colors.transparent,
  statusBarBrightness: Brightness.dark,
  systemNavigationBarDividerColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'For My Self',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
