import 'package:flutter/material.dart';
import 'package:move/app/services/shared_config.dart';
import 'package:move/app/view/authPages/splash_screen.dart';

Future<void> main() async {
  //FOR SHARED PREFERENCES
  WidgetsFlutterBinding.ensureInitialized();
  await StorageUtil.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MOVE',
      home: SplashScreen(),
    );
  }
}
