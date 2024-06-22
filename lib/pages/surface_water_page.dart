import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydroinformatics_data_management_system/models/get_ffwc_data_model.dart';
import 'package:hydroinformatics_data_management_system/providers/station_info_provider.dart';
import 'package:hydroinformatics_data_management_system/services/data_entry_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../services/fetch_station_data_service.dart';

class SurfaceWaterPage extends StatefulWidget {
  const SurfaceWaterPage({super.key});

  static const String surfaceWaterPage = 'surfaceWaterPage';

  @override
  State<SurfaceWaterPage> createState() => _SurfaceWaterPageState();
}

class _SurfaceWaterPageState extends State<SurfaceWaterPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late StationInfoProvider stationInfoProvider;
  bool callOnce = false;
  late dynamic selectedStation;
  late String selectedKeyword;
  String? formattedPreviousDayDate;
  GetFfwcDataModel? getFfwcDataModel;
  TextEditingController datePickerController = TextEditingController();
  TextEditingController sixAmController = TextEditingController();
  TextEditingController nineAmController = TextEditingController();
  TextEditingController twelvePmController = TextEditingController();
  TextEditingController fifteenPmController = TextEditingController();
  TextEditingController eighteenPmController = TextEditingController();
  TextEditingController previousDayEighteenPmController =
      TextEditingController();

  var dt = DateTime.now();
  DateTime? pDate;
  bool isDatePicked = false;

  Future refresh() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const SurfaceWaterPage()));
    setState(() {});
  }

  @override
  void initState() {
    DateTime currentDate = DateTime.now();
    DateTime previousDay = currentDate.subtract(Duration(days: 1));

    String formattedDate = DateFormat('dd-MM-yyyy').format(currentDate);
    print(formattedDate);
    formattedPreviousDayDate = DateFormat('dd-MM-yyyy').format(previousDay);
    print(formattedPreviousDayDate);

    super.initState();
    datePickerController.text = formattedDate;

    print('picked Date: $pDate');
    print('Today: ${DateTime.now()}');

    print(
        'picked day of date: ${pDate?.day}, today day of date: ${DateTime.now().day}');
  }

  @override
  void didChangeDependencies() {
    stationInfoProvider = Provider.of(context, listen: true);
    if (callOnce == false && stationInfoProvider.stationInfo.isNotEmpty) {
      stationInfoProvider.getStationName();
      selectedStation = stationInfoProvider.stationName[0];
      selectedKeyword = stationInfoProvider.getStationKeyword(selectedStation);
      getFfwcDataModel = GetFfwcDataModel();
      callOnce = true;
    }

    super.didChangeDependencies();

    if (stationInfoProvider.stationInfo.isNotEmpty) {
      //String previousDayEighteenPmData = checkIntorDouble(stationInfoProvider.getFfwcDataModel.prevDayHr18 ?? '');
      //previousDayEighteenPmController.text = previousDayEighteenPmData;

      String sixAmData =
          checkIntorDouble(stationInfoProvider.getFfwcDataModel.hr6 ?? '');
      sixAmController.text = sixAmData;
      String nineAmData =
          checkIntorDouble(stationInfoProvider.getFfwcDataModel.hr9 ?? '');
      nineAmController.text = nineAmData;
      String twelvePmData =
          checkIntorDouble(stationInfoProvider.getFfwcDataModel.hr12 ?? '');
      twelvePmController.text = twelvePmData;
      String fifteenPmData =
          checkIntorDouble(stationInfoProvider.getFfwcDataModel.hr15 ?? '');
      fifteenPmController.text = fifteenPmData;
      String eighteenPmData =
          checkIntorDouble(stationInfoProvider.getFfwcDataModel.hr18 ?? '');
      eighteenPmController.text = eighteenPmData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        title: Text(
          'Surface Water Page',
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const SurfaceWaterPage()));
              },
              icon: const Icon(Icons.refresh),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Container(
            margin: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: stationInfoProvider.stationInfo.isEmpty
                  ? Text(
                      'You have no assigned station ...',
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Station',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  DropdownSearch<String>(
                                    items: stationInfoProvider.stationName,
                                    popupProps: const PopupProps.menu(
                                      showSearchBox: true,
                                    ),
                                    dropdownButtonProps:
                                        const DropdownButtonProps(
                                      color: Colors.black,
                                    ),
                                    dropdownDecoratorProps:
                                        DropDownDecoratorProps(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      dropdownSearchDecoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only(
                                              top: 12,
                                              bottom: 12,
                                              left: 8,
                                              right: 8),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: const BorderSide(
                                                  color: Colors.black,
                                                  width: 1))),
                                    ),
                                    onChanged: (value) {
                                      setState(() async {
                                        selectedStation = value.toString();
                                        selectedKeyword = stationInfoProvider
                                            .getStationKeyword(selectedStation);

                                        dynamic info =
                                            await FetchStationDataService
                                                .fetchFfwcData(selectedKeyword,
                                                    datePickerController.text);

                                        if (info != null) {
                                          getFfwcDataModel =
                                              GetFfwcDataModel.fromJson(info);

                                          // String prevDayEighteenPmData = checkIntorDouble(getFfwcDataModel!.prevDayHr18 ?? '');
                                          // previousDayEighteenPmController.text = prevDayEighteenPmData;

                                          String sixAmData = checkIntorDouble(
                                              getFfwcDataModel!.hr6 ?? '');
                                          sixAmController.text = sixAmData;
                                          String nineAmData = checkIntorDouble(
                                              getFfwcDataModel!.hr9 ?? '');
                                          nineAmController.text = nineAmData;
                                          String twelvePmData =
                                              checkIntorDouble(
                                                  getFfwcDataModel!.hr12 ?? '');
                                          twelvePmController.text =
                                              twelvePmData;
                                          String fifteenPmData =
                                              checkIntorDouble(
                                                  getFfwcDataModel!.hr15 ?? '');
                                          fifteenPmController.text =
                                              fifteenPmData;
                                          String eighteenPmData =
                                              checkIntorDouble(
                                                  getFfwcDataModel!.hr18 ?? '');
                                          eighteenPmController.text =
                                              eighteenPmData;
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Something went wrong'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          SystemNavigator.pop();
                                                        },
                                                        child: Text('OK'))
                                                  ],
                                                );
                                              });
                                        }
                                      });
                                    },
                                    selectedItem: selectedStation,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Date',
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: datePickerController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                          onPressed: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime(1950),
                                                    lastDate: DateTime.now());

                                            isDatePicked = true;

                                            pDate = pickedDate;
                                            print('picked Date: $pDate');
                                            print('Today: ${DateTime.now()}');

                                            print(
                                                'picked day of date: ${pDate?.day}, today day of date: ${DateTime.now().day}');

                                            if (pickedDate != null) {
                                              String formattedDate =
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(pickedDate);

                                              DateTime previousDayDate =
                                                  pickedDate.subtract(
                                                      const Duration(days: 1));
                                              String previousDayFormattedDate =
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(previousDayDate);

                                              setState(() {
                                                datePickerController.text =
                                                    formattedDate;

                                                formattedPreviousDayDate =
                                                    previousDayFormattedDate;
                                              });

                                              setState(() async {
                                                dynamic info =
                                                    await FetchStationDataService
                                                        .fetchFfwcData(
                                                            selectedKeyword,
                                                            datePickerController
                                                                .text);

                                                if (info != null) {
                                                  getFfwcDataModel =
                                                      GetFfwcDataModel.fromJson(
                                                          info);

                                                  // String prevDayEighteenPmData = checkIntorDouble(getFfwcDataModel!.prevDayHr18 ?? '');
                                                  // previousDayEighteenPmController.text = prevDayEighteenPmData;

                                                  String sixAmData =
                                                      checkIntorDouble(
                                                          getFfwcDataModel!
                                                                  .hr6 ??
                                                              '');
                                                  sixAmController.text =
                                                      sixAmData;
                                                  String nineAmData =
                                                      checkIntorDouble(
                                                          getFfwcDataModel!
                                                                  .hr9 ??
                                                              '');
                                                  nineAmController.text =
                                                      nineAmData;
                                                  String twelvePmData =
                                                      checkIntorDouble(
                                                          getFfwcDataModel!
                                                                  .hr12 ??
                                                              '');
                                                  twelvePmController.text =
                                                      twelvePmData;
                                                  String fifteenPmData =
                                                      checkIntorDouble(
                                                          getFfwcDataModel!
                                                                  .hr15 ??
                                                              '');
                                                  fifteenPmController.text =
                                                      fifteenPmData;
                                                  String eighteenPmData =
                                                      checkIntorDouble(
                                                          getFfwcDataModel!
                                                                  .hr18 ??
                                                              '');
                                                  eighteenPmController.text =
                                                      eighteenPmData;
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Something went wrong'),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: () {
                                                                  SystemNavigator
                                                                      .pop();
                                                                },
                                                                child:
                                                                    Text('OK'))
                                                          ],
                                                        );
                                                      });
                                                }
                                              });
                                            } else {}
                                          },
                                          icon: const Icon(
                                            Icons.date_range,
                                            color: Colors.blue,
                                          )),
                                      contentPadding: const EdgeInsets.only(
                                          left: 8,
                                          right: 8,
                                          top: 15,
                                          bottom: 15),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Card(
                        //   elevation: 3.0,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Column(
                        //       children: [
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text(
                        //               'Station: $selectedStation',
                        //               style: GoogleFonts.poppins(
                        //                   fontSize: 15,
                        //                   fontWeight: FontWeight.bold,
                        //                   color: Colors.blue),
                        //               textAlign: TextAlign.center,
                        //             ),
                        //
                        //             const SizedBox(
                        //               width: 3,
                        //             ),
                        //             // Text('Date: ${datePickerController.text}',
                        //             Text('Date: $formattedPreviousDayDate',
                        //                 textAlign: TextAlign.center,
                        //                 style: GoogleFonts.poppins(
                        //                   fontSize: 15,
                        //                   fontWeight: FontWeight.bold,
                        //                   color: Colors.blue,
                        //                 ))
                        //           ],
                        //         ),
                        //         const SizedBox(
                        //           height: 10,
                        //         ),
                        //         Row(
                        //           children: [
                        //             Text(
                        //               "18:00",
                        //               style: GoogleFonts.poppins(
                        //                   fontSize: 15, fontWeight: FontWeight.w500),
                        //             ),
                        //             const SizedBox(
                        //               width: 15,
                        //             ),
                        //             Expanded(
                        //                 child: TextFormField(
                        //                   validator: (value) {
                        //                     RegExp pattern1 = RegExp(r'^-?\d{0,3}\.\d{1,3}$');
                        //                     RegExp pattern2 = RegExp(r'^-?\d+$');
                        //
                        //                     if (sixAmController.text.isEmpty &&
                        //                         nineAmController.text.isEmpty &&
                        //                         twelvePmController.text.isEmpty &&
                        //                         fifteenPmController.text.isEmpty &&
                        //                         eighteenPmController.text.isEmpty &&
                        //                         previousDayEighteenPmController.text.isEmpty) {
                        //                       return 'At least one field must have a value';
                        //                     }
                        //
                        //                     if (value!.isNotEmpty &&
                        //                         (!((pattern1.hasMatch(value)) ||
                        //                             (pattern2.hasMatch(value))))) {
                        //                       return 'Please provide a valid value';
                        //                     }
                        //                   },
                        //                   keyboardType: TextInputType.number,
                        //                   controller: previousDayEighteenPmController,
                        //                   decoration: const InputDecoration(
                        //                     contentPadding: EdgeInsets.only(
                        //                         left: 8, right: 8, top: 15, bottom: 15),
                        //                     enabledBorder: OutlineInputBorder(
                        //                         borderSide: BorderSide(color: Colors.black),
                        //                         borderRadius:
                        //                         BorderRadius.all(Radius.circular(12))),
                        //                     focusedBorder: OutlineInputBorder(
                        //                         borderSide: BorderSide(color: Colors.black),
                        //                         borderRadius:
                        //                         BorderRadius.all(Radius.circular(12))),
                        //                     errorBorder: OutlineInputBorder(
                        //                         borderSide: BorderSide(color: Colors.red),
                        //                         borderRadius:
                        //                         BorderRadius.all(Radius.circular(12))),
                        //                   ),
                        //                 )),
                        //             const SizedBox(
                        //               width: 5,
                        //             ),
                        //             Text(
                        //               '(m)',
                        //               style: GoogleFonts.poppins(
                        //                   fontSize: 14, fontWeight: FontWeight.w500),
                        //             )
                        //           ],
                        //         ),
                        //         const SizedBox(
                        //           height: 5,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),

                        Card(
                          elevation: 3.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Station: $selectedStation',
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue),
                                      textAlign: TextAlign.center,
                                    ),
                                    // const Text(''),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text('Date: ${datePickerController.text}',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue,
                                        ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Form(
                                  key: formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "06:00",
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          if (6 - dt.hour > 0) ...[
                                            Expanded(
                                                child: TextFormField(
                                              enabled: false,
                                              validator: (value) {
                                                RegExp pattern1 = RegExp(
                                                    r'^-?\d{0,3}\.\d{1,3}$');
                                                RegExp pattern2 =
                                                    RegExp(r'^-?\d+$');

                                                if (
                                                    //previousDayEighteenPmController.text.isEmpty &&
                                                    sixAmController
                                                            .text.isEmpty &&
                                                        nineAmController
                                                            .text.isEmpty &&
                                                        twelvePmController
                                                            .text.isEmpty &&
                                                        fifteenPmController
                                                            .text.isEmpty &&
                                                        eighteenPmController
                                                            .text.isEmpty) {
                                                  return 'At least one field must have a value';
                                                }

                                                if (value!.isNotEmpty &&
                                                    (!((pattern1
                                                            .hasMatch(value)) ||
                                                        (pattern2.hasMatch(
                                                            value))))) {
                                                  return 'Please provide a valid value';
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: sixAmController,
                                              decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    top: 15,
                                                    bottom: 15),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12))),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12))),
                                                errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12))),
                                              ),
                                            )),
                                          ] else ...[
                                            Expanded(
                                                child: TextFormField(
                                              enabled: true,
                                              validator: (value) {
                                                RegExp pattern1 = RegExp(
                                                    r'^-?\d{0,3}\.\d{1,3}$');
                                                RegExp pattern2 =
                                                    RegExp(r'^-?\d+$');

                                                if (
                                                    //previousDayEighteenPmController.text.isEmpty &&
                                                    sixAmController
                                                            .text.isEmpty &&
                                                        nineAmController
                                                            .text.isEmpty &&
                                                        twelvePmController
                                                            .text.isEmpty &&
                                                        fifteenPmController
                                                            .text.isEmpty &&
                                                        eighteenPmController
                                                            .text.isEmpty) {
                                                  return 'At least one field must have a value';
                                                }

                                                if (value!.isNotEmpty &&
                                                    (!((pattern1
                                                            .hasMatch(value)) ||
                                                        (pattern2.hasMatch(
                                                            value))))) {
                                                  return 'Please provide a valid value';
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: sixAmController,
                                              decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    top: 15,
                                                    bottom: 15),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12))),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.black),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    12))),
                                                errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12))),
                                              ),
                                            )),
                                          ],
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '(m)',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),

                                      Row(
                                        children: [
                                          Text(
                                            "09:00",
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          if (isDatePicked) ... [
                                            if ((9 - dt.hour > 0) && (DateTime.now().year == pDate?.year && DateTime.now().month == pDate?.month && DateTime.now().day == pDate?.day)) ...[
                                              Expanded(
                                                  child: TextFormField(
                                                    enabled: false,
                                                    validator: (value) {
                                                      RegExp pattern1 = RegExp(
                                                          r'^-?\d{0,3}\.\d{1,3}$');
                                                      RegExp pattern2 =
                                                      RegExp(r'^-?\d+$');

                                                      if (sixAmController
                                                          .text.isEmpty &&
                                                          nineAmController
                                                              .text.isEmpty &&
                                                          twelvePmController
                                                              .text.isEmpty &&
                                                          fifteenPmController
                                                              .text.isEmpty &&
                                                          eighteenPmController
                                                              .text.isEmpty
                                                      //previousDayEighteenPmController.text.isEmpty
                                                      ) {
                                                        return 'At least one field must have a value';
                                                      }

                                                      if (value!.isNotEmpty &&
                                                          (!((pattern1
                                                              .hasMatch(value)) ||
                                                              (pattern2.hasMatch(
                                                                  value))))) {
                                                        return 'Please provide a valid value';
                                                      }
                                                    },
                                                    keyboardType:
                                                    TextInputType.number,
                                                    controller: nineAmController,
                                                    decoration: const InputDecoration(
                                                      contentPadding: EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 15,
                                                          bottom: 15),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      errorBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.red),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                    ),
                                                  )),
                                            ] else ...[
                                              Expanded(
                                                  child: TextFormField(
                                                    enabled: true,
                                                    validator: (value) {
                                                      RegExp pattern1 = RegExp(
                                                          r'^-?\d{0,3}\.\d{1,3}$');
                                                      RegExp pattern2 =
                                                      RegExp(r'^-?\d+$');

                                                      if (sixAmController
                                                          .text.isEmpty &&
                                                          nineAmController
                                                              .text.isEmpty &&
                                                          twelvePmController
                                                              .text.isEmpty &&
                                                          fifteenPmController
                                                              .text.isEmpty &&
                                                          eighteenPmController
                                                              .text.isEmpty
                                                      //previousDayEighteenPmController.text.isEmpty
                                                      ) {
                                                        return 'At least one field must have a value';
                                                      }

                                                      if (value!.isNotEmpty &&
                                                          (!((pattern1
                                                              .hasMatch(value)) ||
                                                              (pattern2.hasMatch(
                                                                  value))))) {
                                                        return 'Please provide a valid value';
                                                      }
                                                    },
                                                    keyboardType:
                                                    TextInputType.number,
                                                    controller: nineAmController,
                                                    decoration: const InputDecoration(
                                                      contentPadding: EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 15,
                                                          bottom: 15),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      errorBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.red),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                    ),
                                                  )),
                                            ],

                                          ] else ... [
                                            if (9 - dt.hour > 0) ...[
                                              Expanded(
                                                  child: TextFormField(
                                                    enabled: false,
                                                    validator: (value) {
                                                      RegExp pattern1 = RegExp(
                                                          r'^-?\d{0,3}\.\d{1,3}$');
                                                      RegExp pattern2 =
                                                      RegExp(r'^-?\d+$');

                                                      if (sixAmController
                                                          .text.isEmpty &&
                                                          nineAmController
                                                              .text.isEmpty &&
                                                          twelvePmController
                                                              .text.isEmpty &&
                                                          fifteenPmController
                                                              .text.isEmpty &&
                                                          eighteenPmController
                                                              .text.isEmpty
                                                      //previousDayEighteenPmController.text.isEmpty
                                                      ) {
                                                        return 'At least one field must have a value';
                                                      }

                                                      if (value!.isNotEmpty &&
                                                          (!((pattern1
                                                              .hasMatch(value)) ||
                                                              (pattern2.hasMatch(
                                                                  value))))) {
                                                        return 'Please provide a valid value';
                                                      }
                                                    },
                                                    keyboardType:
                                                    TextInputType.number,
                                                    controller: nineAmController,
                                                    decoration: const InputDecoration(
                                                      contentPadding: EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 15,
                                                          bottom: 15),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      errorBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.red),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                    ),
                                                  )),
                                            ] else ...[
                                              Expanded(
                                                  child: TextFormField(
                                                    enabled: true,
                                                    validator: (value) {
                                                      RegExp pattern1 = RegExp(
                                                          r'^-?\d{0,3}\.\d{1,3}$');
                                                      RegExp pattern2 =
                                                      RegExp(r'^-?\d+$');

                                                      if (sixAmController
                                                          .text.isEmpty &&
                                                          nineAmController
                                                              .text.isEmpty &&
                                                          twelvePmController
                                                              .text.isEmpty &&
                                                          fifteenPmController
                                                              .text.isEmpty &&
                                                          eighteenPmController
                                                              .text.isEmpty
                                                      //previousDayEighteenPmController.text.isEmpty
                                                      ) {
                                                        return 'At least one field must have a value';
                                                      }

                                                      if (value!.isNotEmpty &&
                                                          (!((pattern1
                                                              .hasMatch(value)) ||
                                                              (pattern2.hasMatch(
                                                                  value))))) {
                                                        return 'Please provide a valid value';
                                                      }
                                                    },
                                                    keyboardType:
                                                    TextInputType.number,
                                                    controller: nineAmController,
                                                    decoration: const InputDecoration(
                                                      contentPadding: EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 15,
                                                          bottom: 15),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      errorBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.red),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                    ),
                                                  )),
                                            ],
                                          ],
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '(m)',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "12:00",
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          if (isDatePicked) ...[
                                            if ((12 - dt.hour > 0) && (DateTime.now().year == pDate?.year && DateTime.now().month == pDate?.month && DateTime.now().day == pDate?.day)) ...[
                                              Expanded(
                                                  child: TextFormField(
                                                    enabled: false,
                                                    validator: (value) {
                                                      RegExp pattern1 = RegExp(
                                                          r'^-?\d{0,3}\.\d{1,3}$');
                                                      RegExp pattern2 =
                                                      RegExp(r'^-?\d+$');

                                                      if (sixAmController
                                                          .text.isEmpty &&
                                                          nineAmController
                                                              .text.isEmpty &&
                                                          twelvePmController
                                                              .text.isEmpty &&
                                                          fifteenPmController
                                                              .text.isEmpty &&
                                                          eighteenPmController
                                                              .text.isEmpty
                                                      //previousDayEighteenPmController.text.isEmpty
                                                      ) {
                                                        return 'At least one field must have a value';
                                                      }

                                                      if (value!.isNotEmpty &&
                                                          (!((pattern1
                                                              .hasMatch(value)) ||
                                                              (pattern2.hasMatch(
                                                                  value))))) {
                                                        return 'Please provide a valid value';
                                                      }
                                                    },
                                                    keyboardType:
                                                    TextInputType.number,
                                                    controller: twelvePmController,
                                                    decoration: const InputDecoration(
                                                      contentPadding: EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 15,
                                                          bottom: 15),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      errorBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.red),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                    ),
                                                  )),
                                            ] else ...[
                                              Expanded(
                                                  child: TextFormField(
                                                    enabled: true,
                                                    validator: (value) {
                                                      RegExp pattern1 = RegExp(
                                                          r'^-?\d{0,3}\.\d{1,3}$');
                                                      RegExp pattern2 =
                                                      RegExp(r'^-?\d+$');

                                                      if (sixAmController
                                                          .text.isEmpty &&
                                                          nineAmController
                                                              .text.isEmpty &&
                                                          twelvePmController
                                                              .text.isEmpty &&
                                                          fifteenPmController
                                                              .text.isEmpty &&
                                                          eighteenPmController
                                                              .text.isEmpty
                                                      //previousDayEighteenPmController.text.isEmpty
                                                      ) {
                                                        return 'At least one field must have a value';
                                                      }

                                                      if (value!.isNotEmpty &&
                                                          (!((pattern1
                                                              .hasMatch(value)) ||
                                                              (pattern2.hasMatch(
                                                                  value))))) {
                                                        return 'Please provide a valid value';
                                                      }
                                                    },
                                                    keyboardType:
                                                    TextInputType.number,
                                                    controller: twelvePmController,
                                                    decoration: const InputDecoration(
                                                      contentPadding: EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 15,
                                                          bottom: 15),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      errorBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.red),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                    ),
                                                  )),
                                            ],


                                          ] else ... [
                                            if (12 - dt.hour > 0) ...[
                                              Expanded(
                                                  child: TextFormField(
                                                    enabled: false,
                                                    validator: (value) {
                                                      RegExp pattern1 = RegExp(
                                                          r'^-?\d{0,3}\.\d{1,3}$');
                                                      RegExp pattern2 =
                                                      RegExp(r'^-?\d+$');

                                                      if (sixAmController
                                                          .text.isEmpty &&
                                                          nineAmController
                                                              .text.isEmpty &&
                                                          twelvePmController
                                                              .text.isEmpty &&
                                                          fifteenPmController
                                                              .text.isEmpty &&
                                                          eighteenPmController
                                                              .text.isEmpty
                                                      //previousDayEighteenPmController.text.isEmpty
                                                      ) {
                                                        return 'At least one field must have a value';
                                                      }

                                                      if (value!.isNotEmpty &&
                                                          (!((pattern1
                                                              .hasMatch(value)) ||
                                                              (pattern2.hasMatch(
                                                                  value))))) {
                                                        return 'Please provide a valid value';
                                                      }
                                                    },
                                                    keyboardType:
                                                    TextInputType.number,
                                                    controller: twelvePmController,
                                                    decoration: const InputDecoration(
                                                      contentPadding: EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 15,
                                                          bottom: 15),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      errorBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.red),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                    ),
                                                  )),
                                            ] else ...[
                                              Expanded(
                                                  child: TextFormField(
                                                    enabled: true,
                                                    validator: (value) {
                                                      RegExp pattern1 = RegExp(
                                                          r'^-?\d{0,3}\.\d{1,3}$');
                                                      RegExp pattern2 =
                                                      RegExp(r'^-?\d+$');

                                                      if (sixAmController
                                                          .text.isEmpty &&
                                                          nineAmController
                                                              .text.isEmpty &&
                                                          twelvePmController
                                                              .text.isEmpty &&
                                                          fifteenPmController
                                                              .text.isEmpty &&
                                                          eighteenPmController
                                                              .text.isEmpty
                                                      //previousDayEighteenPmController.text.isEmpty
                                                      ) {
                                                        return 'At least one field must have a value';
                                                      }

                                                      if (value!.isNotEmpty &&
                                                          (!((pattern1
                                                              .hasMatch(value)) ||
                                                              (pattern2.hasMatch(
                                                                  value))))) {
                                                        return 'Please provide a valid value';
                                                      }
                                                    },
                                                    keyboardType:
                                                    TextInputType.number,
                                                    controller: twelvePmController,
                                                    decoration: const InputDecoration(
                                                      contentPadding: EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 15,
                                                          bottom: 15),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      errorBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.red),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                    ),
                                                  )),
                                            ],
                                          ],
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '(m)',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "15:00",
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          // if (15 - dt.hour > 0) ...[
                                          //   Expanded(
                                          //       child: TextFormField(
                                          //     enabled: false,
                                          //     validator: (value) {
                                          //       RegExp pattern1 = RegExp(
                                          //           r'^-?\d{0,3}\.\d{1,3}$');
                                          //       RegExp pattern2 =
                                          //           RegExp(r'^-?\d+$');
                                          //
                                          //       if (sixAmController
                                          //                   .text.isEmpty &&
                                          //               nineAmController
                                          //                   .text.isEmpty &&
                                          //               twelvePmController
                                          //                   .text.isEmpty &&
                                          //               fifteenPmController
                                          //                   .text.isEmpty &&
                                          //               eighteenPmController
                                          //                   .text.isEmpty
                                          //           //previousDayEighteenPmController.text.isEmpty
                                          //           ) {
                                          //         return 'At least one field must have a value';
                                          //       }
                                          //
                                          //       if (value!.isNotEmpty &&
                                          //           (!((pattern1
                                          //                   .hasMatch(value)) ||
                                          //               (pattern2.hasMatch(
                                          //                   value))))) {
                                          //         return 'Please provide a valid value';
                                          //       }
                                          //     },
                                          //     keyboardType:
                                          //         TextInputType.number,
                                          //     controller: fifteenPmController,
                                          //     decoration: const InputDecoration(
                                          //       contentPadding: EdgeInsets.only(
                                          //           left: 8,
                                          //           right: 8,
                                          //           top: 15,
                                          //           bottom: 15),
                                          //       enabledBorder:
                                          //           OutlineInputBorder(
                                          //               borderSide: BorderSide(
                                          //                   color:
                                          //                       Colors.black),
                                          //               borderRadius:
                                          //                   BorderRadius.all(
                                          //                       Radius.circular(
                                          //                           12))),
                                          //       focusedBorder:
                                          //           OutlineInputBorder(
                                          //               borderSide: BorderSide(
                                          //                   color:
                                          //                       Colors.black),
                                          //               borderRadius:
                                          //                   BorderRadius.all(
                                          //                       Radius.circular(
                                          //                           12))),
                                          //       errorBorder: OutlineInputBorder(
                                          //           borderSide: BorderSide(
                                          //               color: Colors.red),
                                          //           borderRadius:
                                          //               BorderRadius.all(
                                          //                   Radius.circular(
                                          //                       12))),
                                          //     ),
                                          //   )),
                                          // ] else ...[
                                          //   Expanded(
                                          //       child: TextFormField(
                                          //     enabled: true,
                                          //     validator: (value) {
                                          //       RegExp pattern1 = RegExp(
                                          //           r'^-?\d{0,3}\.\d{1,3}$');
                                          //       RegExp pattern2 =
                                          //           RegExp(r'^-?\d+$');
                                          //
                                          //       if (sixAmController
                                          //                   .text.isEmpty &&
                                          //               nineAmController
                                          //                   .text.isEmpty &&
                                          //               twelvePmController
                                          //                   .text.isEmpty &&
                                          //               fifteenPmController
                                          //                   .text.isEmpty &&
                                          //               eighteenPmController
                                          //                   .text.isEmpty
                                          //           //previousDayEighteenPmController.text.isEmpty
                                          //           ) {
                                          //         return 'At least one field must have a value';
                                          //       }
                                          //
                                          //       if (value!.isNotEmpty &&
                                          //           (!((pattern1
                                          //                   .hasMatch(value)) ||
                                          //               (pattern2.hasMatch(
                                          //                   value))))) {
                                          //         return 'Please provide a valid value';
                                          //       }
                                          //     },
                                          //     keyboardType:
                                          //         TextInputType.number,
                                          //     controller: fifteenPmController,
                                          //     decoration: const InputDecoration(
                                          //       contentPadding: EdgeInsets.only(
                                          //           left: 8,
                                          //           right: 8,
                                          //           top: 15,
                                          //           bottom: 15),
                                          //       enabledBorder:
                                          //           OutlineInputBorder(
                                          //               borderSide: BorderSide(
                                          //                   color:
                                          //                       Colors.black),
                                          //               borderRadius:
                                          //                   BorderRadius.all(
                                          //                       Radius.circular(
                                          //                           12))),
                                          //       focusedBorder:
                                          //           OutlineInputBorder(
                                          //               borderSide: BorderSide(
                                          //                   color:
                                          //                       Colors.black),
                                          //               borderRadius:
                                          //                   BorderRadius.all(
                                          //                       Radius.circular(
                                          //                           12))),
                                          //       errorBorder: OutlineInputBorder(
                                          //           borderSide: BorderSide(
                                          //               color: Colors.red),
                                          //           borderRadius:
                                          //               BorderRadius.all(
                                          //                   Radius.circular(
                                          //                       12))),
                                          //     ),
                                          //   )),
                                          // ],

                                          if (isDatePicked) ...[

                                            if ((15 - dt.hour > 0) && (DateTime.now().year == pDate?.year && DateTime.now().month == pDate?.month && DateTime.now().day == pDate?.day)) ...[
                                              Expanded(
                                                  child: TextFormField(
                                                    enabled: false,
                                                    validator: (value) {
                                                      RegExp pattern1 = RegExp(
                                                          r'^-?\d{0,3}\.\d{1,3}$');
                                                      RegExp pattern2 =
                                                      RegExp(r'^-?\d+$');

                                                      if (sixAmController
                                                          .text.isEmpty &&
                                                          nineAmController
                                                              .text.isEmpty &&
                                                          twelvePmController
                                                              .text.isEmpty &&
                                                          fifteenPmController
                                                              .text.isEmpty &&
                                                          eighteenPmController
                                                              .text.isEmpty
                                                      //previousDayEighteenPmController.text.isEmpty
                                                      ) {
                                                        return 'At least one field must have a value';
                                                      }

                                                      if (value!.isNotEmpty &&
                                                          (!((pattern1
                                                              .hasMatch(value)) ||
                                                              (pattern2.hasMatch(
                                                                  value))))) {
                                                        return 'Please provide a valid value';
                                                      }
                                                    },
                                                    keyboardType:
                                                    TextInputType.number,
                                                    controller: fifteenPmController,
                                                    decoration: const InputDecoration(
                                                      contentPadding: EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 15,
                                                          bottom: 15),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      errorBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.red),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                    ),
                                                  )),
                                            ] else ...[
                                              Expanded(
                                                  child: TextFormField(
                                                    enabled: true,
                                                    validator: (value) {
                                                      RegExp pattern1 = RegExp(
                                                          r'^-?\d{0,3}\.\d{1,3}$');
                                                      RegExp pattern2 =
                                                      RegExp(r'^-?\d+$');

                                                      if (sixAmController
                                                          .text.isEmpty &&
                                                          nineAmController
                                                              .text.isEmpty &&
                                                          twelvePmController
                                                              .text.isEmpty &&
                                                          fifteenPmController
                                                              .text.isEmpty &&
                                                          eighteenPmController
                                                              .text.isEmpty
                                                      //previousDayEighteenPmController.text.isEmpty
                                                      ) {
                                                        return 'At least one field must have a value';
                                                      }

                                                      if (value!.isNotEmpty &&
                                                          (!((pattern1
                                                              .hasMatch(value)) ||
                                                              (pattern2.hasMatch(
                                                                  value))))) {
                                                        return 'Please provide a valid value';
                                                      }
                                                    },
                                                    keyboardType:
                                                    TextInputType.number,
                                                    controller: fifteenPmController,
                                                    decoration: const InputDecoration(
                                                      contentPadding: EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 15,
                                                          bottom: 15),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      errorBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.red),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                    ),
                                                  )),
                                            ],

                                          ] else ...[

                                            if (15 - dt.hour > 0) ...[
                                              Expanded(
                                                  child: TextFormField(
                                                    enabled: false,
                                                    validator: (value) {
                                                      RegExp pattern1 = RegExp(
                                                          r'^-?\d{0,3}\.\d{1,3}$');
                                                      RegExp pattern2 =
                                                      RegExp(r'^-?\d+$');

                                                      if (sixAmController
                                                          .text.isEmpty &&
                                                          nineAmController
                                                              .text.isEmpty &&
                                                          twelvePmController
                                                              .text.isEmpty &&
                                                          fifteenPmController
                                                              .text.isEmpty &&
                                                          eighteenPmController
                                                              .text.isEmpty
                                                      //previousDayEighteenPmController.text.isEmpty
                                                      ) {
                                                        return 'At least one field must have a value';
                                                      }

                                                      if (value!.isNotEmpty &&
                                                          (!((pattern1
                                                              .hasMatch(value)) ||
                                                              (pattern2.hasMatch(
                                                                  value))))) {
                                                        return 'Please provide a valid value';
                                                      }
                                                    },
                                                    keyboardType:
                                                    TextInputType.number,
                                                    controller: fifteenPmController,
                                                    decoration: const InputDecoration(
                                                      contentPadding: EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 15,
                                                          bottom: 15),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      errorBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.red),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                    ),
                                                  )),
                                            ] else ...[
                                              Expanded(
                                                  child: TextFormField(
                                                    enabled: true,
                                                    validator: (value) {
                                                      RegExp pattern1 = RegExp(
                                                          r'^-?\d{0,3}\.\d{1,3}$');
                                                      RegExp pattern2 =
                                                      RegExp(r'^-?\d+$');

                                                      if (sixAmController
                                                          .text.isEmpty &&
                                                          nineAmController
                                                              .text.isEmpty &&
                                                          twelvePmController
                                                              .text.isEmpty &&
                                                          fifteenPmController
                                                              .text.isEmpty &&
                                                          eighteenPmController
                                                              .text.isEmpty
                                                      //previousDayEighteenPmController.text.isEmpty
                                                      ) {
                                                        return 'At least one field must have a value';
                                                      }

                                                      if (value!.isNotEmpty &&
                                                          (!((pattern1
                                                              .hasMatch(value)) ||
                                                              (pattern2.hasMatch(
                                                                  value))))) {
                                                        return 'Please provide a valid value';
                                                      }
                                                    },
                                                    keyboardType:
                                                    TextInputType.number,
                                                    controller: fifteenPmController,
                                                    decoration: const InputDecoration(
                                                      contentPadding: EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 15,
                                                          bottom: 15),
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color:
                                                              Colors.black),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                      errorBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors.red),
                                                          borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12))),
                                                    ),
                                                  )),
                                            ],

                                          ],

































                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '(m)',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "18:00",
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          if (isDatePicked) ...[
                                            if ((18 - dt.hour > 0) &&
                                                (DateTime.now().year ==
                                                        pDate?.year &&
                                                    DateTime.now().month ==
                                                        pDate?.month &&
                                                    DateTime.now().day ==
                                                        pDate?.day)) ...[
                                              Expanded(
                                                  child: TextFormField(
                                                enabled: false,
                                                validator: (value) {
                                                  RegExp pattern1 = RegExp(
                                                      r'^-?\d{0,3}\.\d{1,3}$');
                                                  RegExp pattern2 =
                                                      RegExp(r'^-?\d+$');

                                                  if (sixAmController
                                                              .text.isEmpty &&
                                                          nineAmController
                                                              .text.isEmpty &&
                                                          twelvePmController
                                                              .text.isEmpty &&
                                                          fifteenPmController
                                                              .text.isEmpty &&
                                                          eighteenPmController
                                                              .text.isEmpty
                                                      //previousDayEighteenPmController.text.isEmpty
                                                      ) {
                                                    return 'At least one field must have a value';
                                                  }

                                                  if (value!.isNotEmpty &&
                                                      (!((pattern1.hasMatch(
                                                              value)) ||
                                                          (pattern2.hasMatch(
                                                              value))))) {
                                                    return 'Please provide a valid value';
                                                  }
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    eighteenPmController,
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 15,
                                                          bottom: 15),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                ),
                                              )),
                                            ] else ...[
                                              Expanded(
                                                  child: TextFormField(
                                                enabled: true,
                                                validator: (value) {
                                                  RegExp pattern1 = RegExp(
                                                      r'^-?\d{0,3}\.\d{1,3}$');
                                                  RegExp pattern2 =
                                                      RegExp(r'^-?\d+$');

                                                  if (sixAmController
                                                              .text.isEmpty &&
                                                          nineAmController
                                                              .text.isEmpty &&
                                                          twelvePmController
                                                              .text.isEmpty &&
                                                          fifteenPmController
                                                              .text.isEmpty &&
                                                          eighteenPmController
                                                              .text.isEmpty
                                                      //previousDayEighteenPmController.text.isEmpty
                                                      ) {
                                                    return 'At least one field must have a value';
                                                  }

                                                  if (value!.isNotEmpty &&
                                                      (!((pattern1.hasMatch(
                                                              value)) ||
                                                          (pattern2.hasMatch(
                                                              value))))) {
                                                    return 'Please provide a valid value';
                                                  }
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    eighteenPmController,
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 15,
                                                          bottom: 15),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                ),
                                              )),
                                            ],
                                          ] else ...[
                                            if ((18 - dt.hour > 0)) ...[
                                              Expanded(
                                                  child: TextFormField(
                                                enabled: false,
                                                validator: (value) {
                                                  RegExp pattern1 = RegExp(
                                                      r'^-?\d{0,3}\.\d{1,3}$');
                                                  RegExp pattern2 =
                                                      RegExp(r'^-?\d+$');

                                                  if (sixAmController
                                                              .text.isEmpty &&
                                                          nineAmController
                                                              .text.isEmpty &&
                                                          twelvePmController
                                                              .text.isEmpty &&
                                                          fifteenPmController
                                                              .text.isEmpty &&
                                                          eighteenPmController
                                                              .text.isEmpty
                                                      //previousDayEighteenPmController.text.isEmpty
                                                      ) {
                                                    return 'At least one field must have a value';
                                                  }

                                                  if (value!.isNotEmpty &&
                                                      (!((pattern1.hasMatch(
                                                              value)) ||
                                                          (pattern2.hasMatch(
                                                              value))))) {
                                                    return 'Please provide a valid value';
                                                  }
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    eighteenPmController,
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 15,
                                                          bottom: 15),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                ),
                                              )),
                                            ] else ...[
                                              Expanded(
                                                  child: TextFormField(
                                                enabled: true,
                                                validator: (value) {
                                                  RegExp pattern1 = RegExp(
                                                      r'^-?\d{0,3}\.\d{1,3}$');
                                                  RegExp pattern2 =
                                                      RegExp(r'^-?\d+$');

                                                  if (sixAmController
                                                              .text.isEmpty &&
                                                          nineAmController
                                                              .text.isEmpty &&
                                                          twelvePmController
                                                              .text.isEmpty &&
                                                          fifteenPmController
                                                              .text.isEmpty &&
                                                          eighteenPmController
                                                              .text.isEmpty
                                                      //previousDayEighteenPmController.text.isEmpty
                                                      ) {
                                                    return 'At least one field must have a value';
                                                  }

                                                  if (value!.isNotEmpty &&
                                                      (!((pattern1.hasMatch(
                                                              value)) ||
                                                          (pattern2.hasMatch(
                                                              value))))) {
                                                    return 'Please provide a valid value';
                                                  }
                                                },
                                                keyboardType:
                                                    TextInputType.number,
                                                controller:
                                                    eighteenPmController,
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 8,
                                                          right: 8,
                                                          top: 15,
                                                          bottom: 15),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .red),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          12))),
                                                ),
                                              )),
                                            ],
                                          ],
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '(m)',
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(50),
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                DataEntryService.ffwcSurfaceWaterDataEntry(
                                        selectedKeyword,
                                        datePickerController.text,
                                        // previousDayEighteenPmController.text,
                                        sixAmController.text,
                                        nineAmController.text,
                                        twelvePmController.text,
                                        fifteenPmController.text,
                                        eighteenPmController.text,
                                        //'18:00',
                                        '6:00',
                                        '9:00',
                                        '12:00',
                                        '15:00',
                                        '18:00')
                                    .then((value) {
                                  if (value != null) {
                                    showDialog<String>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content: Text(value['message']),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    showDialog<String>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        content:
                                            Text("OOPS! Something went wrong"),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child:
                                                Center(child: const Text('OK')),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                });
                              }
                            },
                            child: Text(
                              'Submit',
                              style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ))
                      ],
                    ),
            )),
      ),
    );
  }

  String checkIntorDouble(String value) {
    if (value.contains(".")) {
      return value;
    } else if (value == "") {
      return "";
    } else {
      double convertedValue = double.parse(value);
      String desiredValue = convertedValue.toStringAsFixed(1);
      return desiredValue;
    }
  }
}

//
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hydroinformatics_data_management_system/models/get_ffwc_data_model.dart';
// import 'package:hydroinformatics_data_management_system/providers/station_info_provider.dart';
// import 'package:hydroinformatics_data_management_system/services/data_entry_service.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// import '../services/fetch_station_data_service.dart';
//
// class SurfaceWaterPage extends StatefulWidget {
//   const SurfaceWaterPage({super.key});
//
//   static const String surfaceWaterPage = 'surfaceWaterPage';
//
//   @override
//   State<SurfaceWaterPage> createState() => _SurfaceWaterPageState();
// }
//
// class _SurfaceWaterPageState extends State<SurfaceWaterPage> {
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   late StationInfoProvider stationInfoProvider;
//   bool callOnce = false;
//   late dynamic selectedStation;
//   late String selectedKeyword;
//   GetFfwcDataModel? getFfwcDataModel;
//   TextEditingController datePickerController = TextEditingController();
//   TextEditingController sixAmController = TextEditingController();
//   TextEditingController nineAmController = TextEditingController();
//   TextEditingController twelvePmController = TextEditingController();
//   TextEditingController fifteenPmController = TextEditingController();
//   TextEditingController eighteenPmController = TextEditingController();
//
//   @override
//   void initState() {
//     DateTime currentDate = DateTime.now();
//
//     String formattedDate = DateFormat('dd-MM-yyyy').format(currentDate);
//
//     super.initState();
//     datePickerController.text = formattedDate;
//   }
//
//   @override
//   void didChangeDependencies() {
//     stationInfoProvider = Provider.of(context, listen: true);
//     if (callOnce == false && stationInfoProvider.stationInfo.isNotEmpty) {
//       stationInfoProvider.getStationName();
//       selectedStation = stationInfoProvider.stationName[0];
//       selectedKeyword = stationInfoProvider.getStationKeyword(selectedStation);
//       getFfwcDataModel = GetFfwcDataModel();
//       callOnce = true;
//     }
//
//     super.didChangeDependencies();
//
//     if (stationInfoProvider.stationInfo.isNotEmpty) {
//
//       String sixAmData =
//       checkIntorDouble(stationInfoProvider.getFfwcDataModel.hr6 ?? '');
//       sixAmController.text = sixAmData;
//       String nineAmData =
//       checkIntorDouble(stationInfoProvider.getFfwcDataModel.hr9 ?? '');
//       nineAmController.text = nineAmData;
//       String twelvePmData =
//       checkIntorDouble(stationInfoProvider.getFfwcDataModel.hr12 ?? '');
//       twelvePmController.text = twelvePmData;
//       String fifteenPmData =
//       checkIntorDouble(stationInfoProvider.getFfwcDataModel.hr15 ?? '');
//       fifteenPmController.text = fifteenPmData;
//       String eighteenPmData =
//       checkIntorDouble(stationInfoProvider.getFfwcDataModel.hr18 ?? '');
//       eighteenPmController.text = eighteenPmData;
//
//     }
//
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//         backgroundColor: Colors.blue,
//         title: Text(
//           'Surface Water Page',
//           style: GoogleFonts.poppins(
//               fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//           margin: const EdgeInsets.all(20),
//           child: SingleChildScrollView(
//             child: stationInfoProvider.stationInfo.isEmpty
//                 ? Text(
//               'You have no assigned station ...',
//               style: GoogleFonts.poppins(
//                   fontSize: 14, fontWeight: FontWeight.w500),
//             )
//                 : Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Column(
//                         children: [
//                           Text(
//                             'Station',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 15, fontWeight: FontWeight.w500),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           DropdownSearch<String>(
//                             items: stationInfoProvider.stationName,
//                             popupProps: const PopupProps.menu(
//                               showSearchBox: true,
//                             ),
//                             dropdownButtonProps: const DropdownButtonProps(
//                               color: Colors.black,
//                             ),
//                             dropdownDecoratorProps: DropDownDecoratorProps(
//                               textAlignVertical: TextAlignVertical.center,
//                               dropdownSearchDecoration: InputDecoration(
//                                   contentPadding: const EdgeInsets.only(
//                                       top: 12, bottom: 12, left: 8, right: 8),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: const BorderSide(
//                                           color: Colors.black, width: 1)),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                       borderSide: const BorderSide(
//                                           color: Colors.black, width: 1))),
//                             ),
//                             onChanged: (value) {
//                               setState(() async {
//                                 selectedStation = value.toString();
//                                 selectedKeyword = stationInfoProvider
//                                     .getStationKeyword(selectedStation);
//
//                                 dynamic info =
//                                 await FetchStationDataService.fetchFfwcData(
//                                     selectedKeyword,
//                                     datePickerController.text);
//
//                                 if (info != null) {
//                                   getFfwcDataModel =
//                                       GetFfwcDataModel.fromJson(info);
//
//                                   String sixAmData = checkIntorDouble(
//                                       getFfwcDataModel!.hr6 ?? '');
//                                   sixAmController.text = sixAmData;
//                                   String nineAmData = checkIntorDouble(
//                                       getFfwcDataModel!.hr9 ?? '');
//                                   nineAmController.text = nineAmData;
//                                   String twelvePmData = checkIntorDouble(
//                                       getFfwcDataModel!.hr12 ?? '');
//                                   twelvePmController.text = twelvePmData;
//                                   String fifteenPmData = checkIntorDouble(
//                                       getFfwcDataModel!.hr15 ?? '');
//                                   fifteenPmController.text = fifteenPmData;
//                                   String eighteenPmData = checkIntorDouble(
//                                       getFfwcDataModel!.hr18 ?? '');
//                                   eighteenPmController.text = eighteenPmData;
//                                 } else {
//                                   showDialog(
//                                       context: context,
//                                       builder: (context) {
//                                         return AlertDialog(
//                                           title: Text('Something went wrong'),
//                                           actions: [
//                                             TextButton(
//                                                 onPressed: () {
//                                                   SystemNavigator.pop();
//                                                 },
//                                                 child: Text('OK'))
//                                           ],
//                                         );
//                                       });
//                                 }
//                               });
//                             },
//                             selectedItem: selectedStation,
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       child: Column(
//                         children: [
//                           Text(
//                             'Date',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 15, fontWeight: FontWeight.w500),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           TextFormField(
//                             controller: datePickerController,
//                             readOnly: true,
//                             decoration: InputDecoration(
//                               suffixIcon: IconButton(
//                                   onPressed: () async {
//                                     DateTime? pickedDate = await showDatePicker(
//                                         context: context,
//                                         initialDate: DateTime.now(),
//                                         firstDate: DateTime(1950),
//                                         lastDate: DateTime(2100));
//
//                                     if (pickedDate != null) {
//                                       String formattedDate =
//                                       DateFormat('dd-MM-yyyy')
//                                           .format(pickedDate);
//                                       setState(() async {
//                                         datePickerController.text =
//                                             formattedDate;
//
//                                         dynamic info =
//                                         await FetchStationDataService
//                                             .fetchFfwcData(selectedKeyword,
//                                             datePickerController.text);
//
//                                         if (info != null) {
//                                           getFfwcDataModel =
//                                               GetFfwcDataModel.fromJson(info);
//                                           String sixAmData = checkIntorDouble(
//                                               getFfwcDataModel!.hr6 ?? '');
//                                           sixAmController.text = sixAmData;
//                                           String nineAmData = checkIntorDouble(
//                                               getFfwcDataModel!.hr9 ?? '');
//                                           nineAmController.text = nineAmData;
//                                           String twelvePmData =
//                                           checkIntorDouble(
//                                               getFfwcDataModel!.hr12 ?? '');
//                                           twelvePmController.text =
//                                               twelvePmData;
//                                           String fifteenPmData =
//                                           checkIntorDouble(
//                                               getFfwcDataModel!.hr15 ?? '');
//                                           fifteenPmController.text =
//                                               fifteenPmData;
//                                           String eighteenPmData =
//                                           checkIntorDouble(
//                                               getFfwcDataModel!.hr18 ?? '');
//                                           eighteenPmController.text =
//                                               eighteenPmData;
//                                         } else {
//                                           showDialog(
//                                               context: context,
//                                               builder: (context) {
//                                                 return AlertDialog(
//                                                   title: Text(
//                                                       'Something went wrong'),
//                                                   actions: [
//                                                     TextButton(
//                                                         onPressed: () {
//                                                           SystemNavigator.pop();
//                                                         },
//                                                         child: Text('OK'))
//                                                   ],
//                                                 );
//                                               });
//                                         }
//                                       });
//                                     } else {}
//                                   },
//                                   icon: const Icon(
//                                     Icons.date_range,
//                                     color: Colors.blue,
//                                   )),
//                               contentPadding: const EdgeInsets.only(
//                                   left: 8, right: 8, top: 15, bottom: 15),
//                               enabledBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                   borderRadius:
//                                   BorderRadius.all(Radius.circular(12))),
//                               focusedBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide(color: Colors.black),
//                                   borderRadius:
//                                   BorderRadius.all(Radius.circular(12))),
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Station: $selectedStation',
//                       style: GoogleFonts.poppins(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(
//                       width: 3,
//                     ),
//                     Text('Date: ${datePickerController.text}',
//                         textAlign: TextAlign.center,
//                         style: GoogleFonts.poppins(
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue,
//                         ))
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 Form(
//                   key: formKey,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             "06:00",
//                             style: GoogleFonts.poppins(
//                                 fontSize: 15, fontWeight: FontWeight.w500),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Expanded(
//                               child: TextFormField(
//                                 validator: (value) {
//                                   RegExp pattern1 = RegExp(r'^-?\d{0,3}\.\d{1,3}$');
//                                   RegExp pattern2 = RegExp(r'^-?\d+$');
//
//                                   if (sixAmController.text.isEmpty &&
//                                       nineAmController.text.isEmpty &&
//                                       twelvePmController.text.isEmpty &&
//                                       fifteenPmController.text.isEmpty &&
//                                       eighteenPmController.text.isEmpty) {
//                                     return 'At least one field must have a value';
//                                   }
//
//                                   if (value!.isNotEmpty &&
//                                       (!((pattern1.hasMatch(value)) ||
//                                           (pattern2.hasMatch(value))))) {
//                                     return 'Please provide a valid value';
//                                   }
//                                 },
//                                 keyboardType: TextInputType.number,
//                                 controller: sixAmController,
//                                 decoration: const InputDecoration(
//                                   contentPadding: EdgeInsets.only(
//                                       left: 8, right: 8, top: 15, bottom: 15),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.black),
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(12))),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.black),
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(12))),
//                                   errorBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.red),
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(12))),
//                                 ),
//                               )),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             '(m)',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 14, fontWeight: FontWeight.w500),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "09:00",
//                             style: GoogleFonts.poppins(
//                                 fontSize: 15, fontWeight: FontWeight.w500),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Expanded(
//                               child: TextFormField(
//                                 validator: (value) {
//                                   RegExp pattern1 = RegExp(r'^-?\d{0,3}\.\d{1,3}$');
//                                   RegExp pattern2 = RegExp(r'^-?\d+$');
//
//                                   if (sixAmController.text.isEmpty &&
//                                       nineAmController.text.isEmpty &&
//                                       twelvePmController.text.isEmpty &&
//                                       fifteenPmController.text.isEmpty &&
//                                       eighteenPmController.text.isEmpty) {
//                                     return 'At least one field must have a value';
//                                   }
//
//                                   if (value!.isNotEmpty &&
//                                       (!((pattern1.hasMatch(value)) ||
//                                           (pattern2.hasMatch(value))))) {
//                                     return 'Please provide a valid value';
//                                   }
//                                 },
//                                 keyboardType: TextInputType.number,
//                                 controller: nineAmController,
//                                 decoration: const InputDecoration(
//                                   contentPadding: EdgeInsets.only(
//                                       left: 8, right: 8, top: 15, bottom: 15),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.black),
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(12))),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.black),
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(12))),
//                                   errorBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.red),
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(12))),
//                                 ),
//                               )),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             '(m)',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 14, fontWeight: FontWeight.w500),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "12:00",
//                             style: GoogleFonts.poppins(
//                                 fontSize: 15, fontWeight: FontWeight.w500),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Expanded(
//                               child: TextFormField(
//                                 validator: (value) {
//                                   RegExp pattern1 = RegExp(r'^-?\d{0,3}\.\d{1,3}$');
//                                   RegExp pattern2 = RegExp(r'^-?\d+$');
//
//                                   if (sixAmController.text.isEmpty &&
//                                       nineAmController.text.isEmpty &&
//                                       twelvePmController.text.isEmpty &&
//                                       fifteenPmController.text.isEmpty &&
//                                       eighteenPmController.text.isEmpty) {
//                                     return 'At least one field must have a value';
//                                   }
//
//                                   if (value!.isNotEmpty &&
//                                       (!((pattern1.hasMatch(value)) ||
//                                           (pattern2.hasMatch(value))))) {
//                                     return 'Please provide a valid value';
//                                   }
//                                 },
//                                 keyboardType: TextInputType.number,
//                                 controller: twelvePmController,
//                                 decoration: const InputDecoration(
//                                   contentPadding: EdgeInsets.only(
//                                       left: 8, right: 8, top: 15, bottom: 15),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.black),
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(12))),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.black),
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(12))),
//                                   errorBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.red),
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(12))),
//                                 ),
//                               )),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             '(m)',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 14, fontWeight: FontWeight.w500),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "15:00",
//                             style: GoogleFonts.poppins(
//                                 fontSize: 15, fontWeight: FontWeight.w500),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Expanded(
//                               child: TextFormField(
//                                 validator: (value) {
//                                   RegExp pattern1 = RegExp(r'^-?\d{0,3}\.\d{1,3}$');
//                                   RegExp pattern2 = RegExp(r'^-?\d+$');
//
//                                   if (sixAmController.text.isEmpty &&
//                                       nineAmController.text.isEmpty &&
//                                       twelvePmController.text.isEmpty &&
//                                       fifteenPmController.text.isEmpty &&
//                                       eighteenPmController.text.isEmpty) {
//                                     return 'At least one field must have a value';
//                                   }
//
//                                   if (value!.isNotEmpty &&
//                                       (!((pattern1.hasMatch(value)) ||
//                                           (pattern2.hasMatch(value))))) {
//                                     return 'Please provide a valid value';
//                                   }
//                                 },
//                                 keyboardType: TextInputType.number,
//                                 controller: fifteenPmController,
//                                 decoration: const InputDecoration(
//                                   contentPadding: EdgeInsets.only(
//                                       left: 8, right: 8, top: 15, bottom: 15),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.black),
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(12))),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.black),
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(12))),
//                                   errorBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.red),
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(12))),
//                                 ),
//                               )),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             '(m)',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 14, fontWeight: FontWeight.w500),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "18:00",
//                             style: GoogleFonts.poppins(
//                                 fontSize: 15, fontWeight: FontWeight.w500),
//                           ),
//                           const SizedBox(
//                             width: 10,
//                           ),
//                           Expanded(
//                               child: TextFormField(
//                                 validator: (value) {
//                                   RegExp pattern1 = RegExp(r'^-?\d{0,3}\.\d{1,3}$');
//                                   RegExp pattern2 = RegExp(r'^-?\d+$');
//
//                                   if (sixAmController.text.isEmpty &&
//                                       nineAmController.text.isEmpty &&
//                                       twelvePmController.text.isEmpty &&
//                                       fifteenPmController.text.isEmpty &&
//                                       eighteenPmController.text.isEmpty) {
//                                     return 'At least one field must have a value';
//                                   }
//
//                                   if (value!.isNotEmpty &&
//                                       (!((pattern1.hasMatch(value)) ||
//                                           (pattern2.hasMatch(value))))) {
//                                     return 'Please provide a valid value';
//                                   }
//                                 },
//                                 keyboardType: TextInputType.number,
//                                 controller: eighteenPmController,
//                                 decoration: const InputDecoration(
//                                   contentPadding: EdgeInsets.only(
//                                       left: 8, right: 8, top: 15, bottom: 15),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.black),
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(12))),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.black),
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(12))),
//                                   errorBorder: OutlineInputBorder(
//                                       borderSide: BorderSide(color: Colors.red),
//                                       borderRadius:
//                                       BorderRadius.all(Radius.circular(12))),
//                                 ),
//                               )),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             '(m)',
//                             style: GoogleFonts.poppins(
//                                 fontSize: 14, fontWeight: FontWeight.w500),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 35,
//                 ),
//                 ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         minimumSize: Size.fromHeight(50),
//                         backgroundColor: Colors.blue,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8))),
//                     onPressed: () {
//                       if (formKey.currentState!.validate()) {
//                         DataEntryService.ffwcSurfaceWaterDataEntry(
//                             selectedKeyword,
//                             datePickerController.text,
//                             sixAmController.text,
//                             nineAmController.text,
//                             twelvePmController.text,
//                             fifteenPmController.text,
//                             eighteenPmController.text,
//                             '6:00',
//                             '9:00',
//                             '12:00',
//                             '15:00',
//                             '18:00')
//                             .then((value) {
//                           if (value != null) {
//                             showDialog<String>(
//                               context: context,
//                               builder: (context) => AlertDialog(
//                                 content: Text(value['message']),
//                                 actions: <Widget>[
//                                   TextButton(
//                                     onPressed: () =>
//                                         Navigator.pop(context, 'OK'),
//                                     child: const Text('OK'),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           } else {
//                             showDialog<String>(
//                               context: context,
//                               builder: (context) => AlertDialog(
//                                 content: Text("OOPS! Something went wrong"),
//                                 actions: <Widget>[
//                                   TextButton(
//                                     onPressed: () => Navigator.pop(context),
//                                     child: Center(child: const Text('OK')),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           }
//                         });
//                       }
//                     },
//                     child: Text(
//                       'Submit',
//                       style: GoogleFonts.poppins(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white),
//                     ))
//               ],
//             ),
//           )),
//     );
//   }
//
//   String checkIntorDouble(String value) {
//     if (value.contains(".")) {
//       return value;
//     } else if (value == "") {
//       return "";
//     } else {
//       double convertedValue = double.parse(value);
//       String desiredValue = convertedValue.toStringAsFixed(1);
//       return desiredValue;
//     }
//   }
// }
