import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydroinformatics_data_management_system/pages/real_time_water_level_page.dart';
import 'package:hydroinformatics_data_management_system/pages/water_level_availability_search_page.dart';
import 'package:provider/provider.dart';

import '../providers/subdivision_provider.dart';
import '../providers/water_level_availability_provider.dart';

class EditedWaterLevelAvailabilityPage extends StatefulWidget {
  const EditedWaterLevelAvailabilityPage({super.key});

  static const String editedWaterLevelAvailabilityPage =
      'editedWaterLevelAvailabilityPage';

  @override
  State<EditedWaterLevelAvailabilityPage> createState() =>
      _EditedWaterLevelAvailabilityPageState();
}

class _EditedWaterLevelAvailabilityPageState
    extends State<EditedWaterLevelAvailabilityPage> {
  late WaterLevelAvailabilityProvider waterLevelAvailabilityProvider;
  late SubdivisionProvider subdivisionProvider;
  bool callOnce = true;

  @override
  void didChangeDependencies() {
    waterLevelAvailabilityProvider = Provider.of(context, listen: true);
    subdivisionProvider = Provider.of(context);

    if (callOnce) {
      waterLevelAvailabilityProvider.getWaterLevelAvailability(context);
      callOnce = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF64B5F6),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        title: Text(
          'Water Level Availability',
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: waterLevelAvailabilityProvider.surfaceWaterList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              EasyLoading.show();
                              subdivisionProvider
                                  .getSubdivision(
                                      context,
                                      waterLevelAvailabilityProvider
                                          .surfaceWaterList[0].serialNo!)
                                  .then((value) {
                                EasyLoading.dismiss();
                                Navigator.of(context).pushNamed(
                                    RealTimeWaterLevelAvailabilitySearchPage.waterLevelAvailabilitySearchPage);
                              });
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        height: 40,
                                        child: Image.network(
                                            waterLevelAvailabilityProvider
                                                .surfaceWaterList[0].icon!)),
                                    FittedBox(
                                      child: Text(
                                          waterLevelAvailabilityProvider
                                              .surfaceWaterList[0].name!,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              EasyLoading.show();
                              subdivisionProvider
                                  .getSubdivision(
                                      context,
                                      waterLevelAvailabilityProvider
                                          .surfaceWaterList[1].serialNo!)
                                  .then((value) {
                                EasyLoading.dismiss();
                                Navigator.of(context).pushNamed(
                                    WaterLevelAvailabilitySearchPage
                                        .waterLevelAvailabilitySearchPage);
                              });
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        height: 40,
                                        child: Image.network(
                                            waterLevelAvailabilityProvider
                                                .surfaceWaterList[1].icon!)),
                                    FittedBox(
                                      child: Text(
                                          waterLevelAvailabilityProvider
                                              .surfaceWaterList[1].name!,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400)),
                                    )
                                  ],
                                ),
                              ),
                            ),
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
