import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydroinformatics_data_management_system/pages/edited_water_level_availabity_page.dart';
import 'package:hydroinformatics_data_management_system/pages/water_level_availability_page.dart';
import 'package:provider/provider.dart';

import '../providers/login_provider.dart';
import '../providers/station_info_provider.dart';

class IntermediaryPage extends StatefulWidget {
  const IntermediaryPage({super.key});

  static const String intermediaryPage = 'intermediary_page';

  @override
  State<IntermediaryPage> createState() => _IntermediaryPageState();
}

class _IntermediaryPageState extends State<IntermediaryPage> {
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
      backgroundColor: Color(0XFF64B5F6),
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Card(
                margin: const EdgeInsets.all(12.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextButton(
                    onPressed: () {
                      stationInfoProvider
                          .getStationInfo('SW', context)
                          .then((value) {
                        print('saidi');
                        EasyLoading.dismiss();
                        Navigator.of(context).pushNamed(
                            EditedWaterLevelAvailabilityPage
                                .editedWaterLevelAvailabilityPage);
                      });
                    },
                    child: Text(
                      'Real Time',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Card(
                margin: const EdgeInsets.all(12.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextButton(
                    onPressed: () {
                      stationInfoProvider
                          .getStationInfo('SW', context)
                          .then((value) {
                        print('saidi');
                        EasyLoading.dismiss();
                        Navigator.of(context).pushNamed(
                            WaterLevelAvailabilityPage
                                .waterLevelAvailabilityPage);
                      });
                    },
                    child: Text(
                      'Manual',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
