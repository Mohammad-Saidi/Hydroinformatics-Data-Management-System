import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydroinformatics_data_management_system/custom/bottom_navigation.dart';
import 'package:hydroinformatics_data_management_system/pages/intermediary_page.dart';
import 'package:hydroinformatics_data_management_system/pages/user_registration_page.dart';
import 'package:hydroinformatics_data_management_system/pages/water_level_availability_page.dart';
import 'package:provider/provider.dart';

import '../custom/drawer.dart';
import '../providers/login_provider.dart';
import '../providers/station_info_provider.dart';
import 'data_request_page.dart';
import 'data_selection_page.dart';



class InitialPage extends StatefulWidget {
  const InitialPage({super.key});


  static const String initialPage = 'initialPage';

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  late LoginProvider loginProvider;
  late StationInfoProvider stationInfoProvider;

  @override
  void didChangeDependencies() {
    loginProvider = Provider.of(context, listen: true);
    stationInfoProvider = Provider.of(context, listen: true);
    loginProvider.getServiceInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,



      backgroundColor: Color(0XFF64B5F6),
      drawer: HomePageDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'BWDB',
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Offers(),
              const SizedBox(
                height: 20.0,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Service List',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                //child: Image.asset('images/bwdb_pic.png'),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GridView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: loginProvider.serviceInfo.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                EasyLoading.show();
                                if (loginProvider.serviceInfo[index].data! == "WL") {
                                  stationInfoProvider
                                      .getStationInfo(
                                      loginProvider.serviceInfo[index].data!, context)
                                      .then((value) {
                                    EasyLoading.dismiss();
                                    Navigator.of(context).pushNamed(
                                        DataSelectionPage.dataSelectionPage,
                                        arguments:
                                        loginProvider.serviceInfo[index].data!);
                                  });
                                }

                                if (loginProvider.serviceInfo[index].data! == "RF") {
                                  stationInfoProvider
                                      .getStationInfo(
                                      loginProvider.serviceInfo[index].data!, context)
                                      .then((value) {
                                    EasyLoading.dismiss();
                                    Navigator.of(context).pushNamed(
                                        DataSelectionPage.dataSelectionPage,
                                        arguments:
                                        loginProvider.serviceInfo[index].data!);
                                  });
                                }

                                if (loginProvider.serviceInfo[index].data! == "GW") {
                                  stationInfoProvider
                                      .getStationInfo(
                                      loginProvider.serviceInfo[index].data!, context)
                                      .then((value) {
                                    EasyLoading.dismiss();
                                    Navigator.of(context).pushNamed(
                                        DataSelectionPage.dataSelectionPage,
                                        arguments:
                                        loginProvider.serviceInfo[index].data!);
                                  });
                                }

                                if (loginProvider.serviceInfo[index].data! == "UR") {
                                  stationInfoProvider
                                      .getStationInfo(
                                      loginProvider.serviceInfo[index].data!, context)
                                      .then((value) {
                                    EasyLoading.dismiss();
                                    Navigator.of(context).pushNamed(
                                        UserRegistrationPage.userRegistrationPage);
                                  });
                                }


                                if (loginProvider.serviceInfo[index].data! == "DR") {
                                  stationInfoProvider
                                      .getStationInfo(
                                      loginProvider.serviceInfo[index].data!, context)
                                      .then((value) {
                                    EasyLoading.dismiss();
                                    Navigator.of(context)
                                        .pushNamed(DataRequestPage.dataRequestPage);
                                  });
                                }

                                // if (loginProvider.serviceInfo[index].data! == "DR") {
                                //   stationInfoProvider
                                //       .getStationInfo(
                                //       loginProvider.serviceInfo[index].data!, context)
                                //       .then((value) {
                                //     EasyLoading.dismiss();
                                //     Navigator.of(context)
                                //         .pushNamed(DataRequestPage.dataRequestPage);
                                //   });
                                // }
                                if (loginProvider.serviceInfo[index].data! == "SW") {
                                  EasyLoading.dismiss();

                                  Navigator.pushNamed(context, IntermediaryPage.intermediaryPage);



                                  // stationInfoProvider
                                  //     .getStationInfo(
                                  //     loginProvider.serviceInfo[index].data!, context)
                                  //     .then((value) {
                                  //   EasyLoading.dismiss();
                                  //   Navigator.of(context)
                                  //       .pushNamed(WaterLevelAvailabilityPage.waterLevelAvailabilityPage);
                                  // });
                                }
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          height: 40,
                                          child: Image.network(
                                              loginProvider.serviceInfo[index].icon!)),
                                      FittedBox(
                                        child: Text(
                                            loginProvider.serviceInfo[index].type!,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class Offers extends StatefulWidget {
  Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  int _selectedPromo = 0;

  List<Image> widgetList = [
    Image.asset('images/slider1.jpg'),
    Image.asset('images/slider3.jpg'),
    Image.asset('images/slider4.jpeg'),
    Image.asset('images/slider5.png'),
    Image.asset('images/slider7.jpg'),
  ];

  late Timer timer;

  final PageController controller = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_selectedPromo < 5) {
        _selectedPromo++;
      } else {
        _selectedPromo = 0;
      }
      if (controller.positions.isNotEmpty) {
        controller.animateToPage(_selectedPromo,
            duration: const Duration(milliseconds: 700), curve: Curves.easeIn);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: controller,
            itemCount: widgetList.length,
            itemBuilder: (context, index) {
              return ClipRRect(

                borderRadius: BorderRadius.circular(20),
                child: SizedBox.fromSize(
                  size: Size.fromRadius(48),

                  child: FittedBox(fit: BoxFit.fill,child: widgetList[index]),
                ),
              );
            },
            onPageChanged: (int selectedPage) {
              setState(() {
                _selectedPromo = selectedPage;
              });
            },
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int index = 0; index < widgetList.length; index++)
                  if (index == _selectedPromo) ...[createCircle(true)] else
                    createCircle(false)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget createCircle(bool isCurrent) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: isCurrent ? 9 : 5,
      width: isCurrent ? 9 : 5,
      decoration: BoxDecoration(
        color: isCurrent ? Colors.blue : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}