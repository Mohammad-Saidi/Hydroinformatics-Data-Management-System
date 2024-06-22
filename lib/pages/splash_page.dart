import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydroinformatics_data_management_system/custom/bottom_navigation.dart';

import 'package:hydroinformatics_data_management_system/pages/login_page.dart';
import 'package:hydroinformatics_data_management_system/pages/services_page.dart';
import 'package:hydroinformatics_data_management_system/providers/login_provider.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/helper_method.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String splashPage = 'splashPage';

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  static const String keyLogIn = "login";
  late LoginProvider loginProvider;

  @override
  void initState() {
    loginProvider = Provider.of(context, listen: false);

    Future.delayed(const Duration(seconds: 5)).then((value) async {
      // Navigator.of(context).pushReplacementNamed(LoginPage.loginPage);

      final SharedPreferences loginPref = await SharedPreferences.getInstance();
      final String? userName = await loginPref.getString('userName');
      final String? password = await loginPref.getString('password');

      if (userName != null && userName.isNotEmpty) {
        if (password != null && password.isNotEmpty) {
          loginProvider.getLoginInfo(userName, password).then((value) async {
            if (value != null) {
              if (value['status'] == 'success') {




                HelperMethod.setUserId(
                    value['user_id'].toString());

                HelperMethod.setUserName(value["name"]);

                HelperMethod.setAuthToken(
                    value['authorization']['token']);






                Navigator.of(context).pushReplacementNamed(
                    BottomNavigationPage.bottomNavigationPage);
              } else if (value['status'] == 'error') {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Error!!!'),
                      content: const Text(
                          "Something went wrong. Please try again later"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              }
            } else {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Error!!!'),
                    content: const Text(
                        "Something went wrong. Please try again later"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            }
          });
        }
      } else {
        Navigator.of(context).pushReplacementNamed(LoginPage.loginPage);
      }
    });

    // void checking() async {
    //   void completeLogin() {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (BuildContext context) => const LoginPage(),
    //       ),
    //     );
    //   }
    //
    //   void completeServicePage() {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (BuildContext context) => const ServicesPage(),
    //       ),
    //     );
    //   }
    //
    //   var sharedPref = await SharedPreferences.getInstance();
    //   var isLoggedIn = sharedPref.getBool(SplashPageState.keyLogIn);
    //
    //   if (isLoggedIn != null) {
    //     if (isLoggedIn) {
    //       completeServicePage();
    //     } else {
    //       completeLogin();
    //     }
    //   } else {
    //     completeLogin();
    //   }
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF64B5F6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 50,
            ),
          )
        ],
      ),
    );
  }
}
