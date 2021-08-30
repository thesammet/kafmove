import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:move/app/services/shared_config.dart';
import 'package:move/app/view/authPages/splash_two.dart';
import 'package:http/http.dart' as http;
import 'package:move/app/view/menu_dashboard_layout.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print("token\n");
    print(StorageUtil.getString("token"));
    if (StorageUtil.getString("token") != null &&
        StorageUtil.getString("token") != "") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => MenuDashboardPage()));
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SplashTwo()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/splashbg.png"), fit: BoxFit.cover)),
        child: Center(
          child: Image.asset("assets/movecool.png"),
        ));
  }
}
