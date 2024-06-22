import 'package:flutter/material.dart';
import 'package:hydroinformatics_data_management_system/pages/home_page.dart';
import 'package:hydroinformatics_data_management_system/pages/profile_page.dart';
import 'package:hydroinformatics_data_management_system/pages/search_page.dart';

import '../pages/initial_page.dart';
import '../pages/services_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  static const String bottomNavigationPage = 'bottomNavigationPage';

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int selectedIndex = 0;

  List<Widget> pages = [const InitialPage(), const SearchPage(), const ServicesPage(), const InitialPage()];

  // from

  // int currentTab = 0;
  // final List<Widget> screens = [
  //   ServicesPage(),
  //   SearchPage(),
  //   ProfilePage(),
  // ];

  Widget currentScreen = const InitialPage();

  // last

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: pages[selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const InitialPage();
                        selectedIndex = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: selectedIndex == 0 ? Colors.white : Colors.black,
                        ),
                        Text(
                          'Home',
                          style: TextStyle(color: selectedIndex == 0 ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const SearchPage();
                        selectedIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: selectedIndex == 1 ? Colors.white : Colors.black,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(color: selectedIndex == 1 ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Right Tab Bar Icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const ServicesPage();
                        selectedIndex = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: selectedIndex == 2 ? Colors.white : Colors.black,
                        ),
                        Text(
                          'Service',
                          style: TextStyle(color: selectedIndex == 2 ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = const InitialPage();
                        selectedIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.contact_mail_outlined,
                          color: selectedIndex == 3 ? Colors.white : Colors.black,
                        ),
                        Text(
                          'Station',
                          style: TextStyle(color: selectedIndex == 3 ? Colors.white : Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// BottomNavigationBar(
// backgroundColor: Colors.blue,
// selectedItemColor: Colors.white,
// unselectedItemColor: Colors.white54,
// type: BottomNavigationBarType.fixed,
// currentIndex: selectedIndex,
// onTap: (value) {
// setState(() {
// selectedIndex = value;
// });
// },
// items: const [
// BottomNavigationBarItem(
// icon: ImageIcon(
// AssetImage('images/home.png'),
// ),
// label: 'Home',
// ),
// BottomNavigationBarItem(
// icon: ImageIcon(
// AssetImage('images/search.png'),
// ),
// label: 'Search',
// ),
// BottomNavigationBarItem(
// icon: ImageIcon(
// AssetImage('images/user.png'),
// ),
// label: 'Profile'),
// ],
// ),
