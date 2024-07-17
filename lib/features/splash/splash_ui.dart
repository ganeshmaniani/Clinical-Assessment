import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/core.dart';
import '../features.dart';

class SplashUI extends StatefulWidget {
  const SplashUI({super.key});

  @override
  State<SplashUI> createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> {
  @override
  void initState() {
    super.initState();

    initialAppRoute();
  }

  void initialAppRoute() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var studentId = preferences.getInt(DBKeys.dbColumnId);
    final auth = studentId != null ? true : false;
    Future.delayed(
        const Duration(seconds: 2),
        () => {
              // if (auth)
              //   {
              //     Navigator.of(context).pushAndRemoveUntil(
              //         MaterialPageRoute(
              //             builder: (context) => const TabHomeScreen()),
              //         (route) => false)
              //   }
              // else
              //   {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const RegisterUI()),
                  (route) => false)
            }
        // },
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppAssets.appIcon),
      ),
    );
  }
}
