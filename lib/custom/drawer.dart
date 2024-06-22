import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydroinformatics_data_management_system/custom/profile_widget.dart';
import 'package:hydroinformatics_data_management_system/helpers/helper_method.dart';
import 'package:hydroinformatics_data_management_system/pages/contact_page.dart';
import 'package:hydroinformatics_data_management_system/pages/edit_profile_page.dart';
import 'package:hydroinformatics_data_management_system/pages/login_page.dart';
import 'package:hydroinformatics_data_management_system/pages/services_page.dart';
import 'package:hydroinformatics_data_management_system/pages/splash_page.dart';
import 'package:hydroinformatics_data_management_system/services/logout_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../utils/user_preferences.dart';

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({super.key});

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  @override
  void didChangeDependencies() {
    getUserInfo();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0XFF64B5F6), Color(0XFF42A5F5)])),
        child: Drawer(
          backgroundColor: Colors.transparent,
          width: MediaQuery.of(context).size.width / 1.4,
          child: Container(
            margin: const EdgeInsets.only(top: 30, left: 15, right: 15),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Align(
                  //   alignment: Alignment.center,
                  //   child: CircleAvatar(
                  //     backgroundImage: AssetImage('images/profile.png'),
                  //     radius: 50,
                  //   ),
                  // ),
                  ProfileWidget(
                    imagePath: user.imagePath,
                    onClicked: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EditProfilePage()),
                      );
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 10.0,),
                  buildName(user),
                  const SizedBox(height: 10.0,),
                  // buildAbout(user),


                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Username: ${HelperMethod.userName ?? ''}',
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ServicesPage.servicesPage);
                        },
                        child: Text('Home',
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.white)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.quick_contacts_mail_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ContactPage.contactPage);
                        },
                        child: Text('Contact Us',
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.white)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.edit_rounded,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(EditProfilePage.editProfilePage);
                        },
                        child: Text('Edit Profile',
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.white)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {

                      // final prefs =
                      //     await SharedPreferences.getInstance();
                      // prefs.setBool(SplashPageState.KEYLOGIN, false);





                      LogoutService.userLogout().then((value) async {
                         final SharedPreferences loginPref = await SharedPreferences.getInstance();



                        if (value != null) {
                          if (value["message"] == "Successfully logged out") {
                            await loginPref.remove('userName');
                            await loginPref.remove('password');
                            var snackBar =
                                SnackBar(content: Text(value["message"]));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                            Navigator.of(context)
                                .pushReplacementNamed(LoginPage.loginPage);
                          }
                        } else {

                          await loginPref.remove('userName');
                          await loginPref.remove('password');

                          var snackBar = const SnackBar(content: Text(''));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.of(context).pushReplacementNamed(LoginPage.loginPage);



                          // showDialog<String>(
                          //   context: context,
                          //   builder: (BuildContext context) => AlertDialog(
                          //     content: const Text('Oops! Unauthenticated'),
                          //     actions: <Widget>[
                          //       TextButton(
                          //         onPressed: () => Navigator.pop(context),
                          //         child: const Text('OK'),
                          //       ),
                          //     ],
                          //   ),
                          // );
                        }
                      });
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text('Logout',
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.white))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 20,
                    thickness: 0.5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.featured_play_list_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text('Version 1.0.0',
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.white)),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text('Powered by Leotech',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.white))
                ]),
          ),
        ),
      ),
    );
  }
  Widget buildName(User user) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        user.name,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
      ),
      const SizedBox(height: 4),
      Text(
        user.email,
        style: const TextStyle(color: Colors.white),
      )
    ],
  );
  Widget buildAbout(User user) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          user.about,
          style: const TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );

  void getUserInfo() {
    HelperMethod.getUserName().then((value) {
      setState(() {});
    });
  }
}
