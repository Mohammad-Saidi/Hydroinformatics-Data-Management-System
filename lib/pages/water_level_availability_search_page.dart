// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hydroinformatics_data_management_system/models/district_info_model.dart';
// import 'package:hydroinformatics_data_management_system/models/surface_water_daily_graph_model.dart';
// import 'package:hydroinformatics_data_management_system/providers/data_availability_provider.dart';
// import 'package:hydroinformatics_data_management_system/providers/district_info_provider.dart';
// import 'package:hydroinformatics_data_management_system/providers/graph_provider.dart';
// import 'package:hydroinformatics_data_management_system/providers/subdivision_provider.dart';
// import 'package:hydroinformatics_data_management_system/providers/sw_auto_manual_station_info_provider.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// import 'data_availability_list_page.dart';
//
// class WaterLevelAvailabilitySearchPage extends StatefulWidget {
//   const WaterLevelAvailabilitySearchPage({super.key});
//
//   static const waterLevelAvailabilitySearchPage =
//       'waterLevelAvailabilitySearchPage';
//
//   @override
//   State<WaterLevelAvailabilitySearchPage> createState() =>
//       _WaterLevelAvailabilitySearchPageState();
// }
//
// class _WaterLevelAvailabilitySearchPageState
//     extends State<WaterLevelAvailabilitySearchPage> {
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   TextEditingController fromDateController = TextEditingController();
//   TextEditingController toDateController = TextEditingController();
//   late SubdivisionProvider subdivisionProvider;
//   late DataAvailabilityProvider dataAvailabilityProvider;
//   late DistrictInfoProvider districtInfoProvider;
//   late GraphProvider graphProvider;
//   late SurfaceWaterAutoManualInfoProvider surfaceWaterAutoManualInfoProvider;
//   bool callOnce = true;
//
//   dynamic selectedDivision;
//   dynamic selectedDivisionCode;
//   dynamic selectedStationCode;
//   dynamic selectedDistrict;
//   dynamic selectedDistrictCode;
//   dynamic selectedDistrictId;
//   String? selectedStation;
//   List<DateTime>? dateTimes;
//   List<double>? values;
//
//   // late TooltipBehavior _tooltipBehavior;
//   // @override
//   // void initState() {
//   //   _tooltipBehavior = TooltipBehavior(
//   //     enable: true,
//   //     tooltipPosition: TooltipPosition.pointer,
//   //     builder: (dynamic data, dynamic point, dynamic series, int pointIndex,
//   //         int seriesIndex) {
//   //       final DateTime date = data.;
//   //       final double value = data.yValue;
//   //       return Container(
//   //         padding: EdgeInsets.all(5),
//   //         decoration: BoxDecoration(
//   //           color: Colors.black54,
//   //           borderRadius: BorderRadius.circular(5),
//   //         ),
//   //         child: Text(
//   //           '${DateFormat('MM/dd/yyyy hh:mm a').format(date)}: ${value.toString()}',
//   //           style: TextStyle(color: Colors.white),
//   //         ),
//   //       );
//   //     },
//   //   );
//   //   // TODO: implement initState
//   //   super.initState();
//   // }
//
//   @override
//   void didChangeDependencies() {
//     districtInfoProvider = Provider.of(context, listen: true);
//     surfaceWaterAutoManualInfoProvider = Provider.of(context, listen: true);
//     subdivisionProvider = Provider.of(context, listen: true);
//     graphProvider = Provider.of(context, listen: true);
//     dataAvailabilityProvider = Provider.of(context);
//
//     if (callOnce) {
//       subdivisionProvider.getSubdivisionList();
//       subdivisionProvider.getSubdivisionCodeList();
//       districtInfoProvider.getDistrict();
//       dateTimes = graphProvider.surfaceWaterDailyDateTime
//           .map((e) => DateTime.parse(e))
//           .toList();
//
//       values = graphProvider.surfaceWaterDailyDateTimeValue
//           .map((e) => double.parse(e))
//           .toList();
//       //surfaceWaterAutoManualInfoProvider.surfaceWaterAutoManualInfo(context, value);
//
//       callOnce = false;
//     }
//     super.didChangeDependencies();
//     selectedDivision = subdivisionProvider.allSubDivisionList[0];
//     selectedDivisionCode = subdivisionProvider.allDivisionCodeList[0];
//   }
//
//   //final List dateTimes = graphProvider.surfaceWaterDailyDateTime;
//
//   @override
//   Widget build(BuildContext context) {
//     // final dateTimes = graphProvider.surfaceWaterDailyDateTime;
//     // final values = graphProvider.surfaceWaterDailyDateTimeValue;
//     // print(dateTimes);
//     // print(values);
//
//     // List<DateTime> dateTimes = graphProvider.surfaceWaterDailyDateTime
//     //     .map((e) => DateTime.parse(e))
//     //     .toList();
//     // print(dateTimes.isEmpty);
//     //
//     // print("DateTimes: $dateTimes");
//     //
//     // List<double> values = graphProvider.surfaceWaterDailyDateTimeValue
//     //     .map((e) => double.parse(e))
//     //     .toList();
//     //
//     // print(values.isEmpty);
//     //print(values[2].runtimeType);
//
//     // final List<DateTime> dateTimes = [
//     //   DateTime.parse('2024-06-27 23:45:00'),
//     //   DateTime.parse('2024-06-27 23:30:00'),
//     //   DateTime.parse('2024-06-27 23:15:00'),
//     //   DateTime.parse('2024-06-27 23:00:00'),
//     //   DateTime.parse('2024-06-27 22:45:00'),
//     //   DateTime.parse('2024-06-27 22:30:00'),
//     //   DateTime.parse('2024-06-27 22:15:00'),
//     //   DateTime.parse('2024-06-27 22:00:00'),
//     //
//     //   DateTime.parse('2024-06-27 10:45:00'),
//     //   DateTime.parse('2024-06-27 10:30:00'),
//     //   DateTime.parse('2024-06-27 10:15:00'),
//     //   DateTime.parse('2024-06-27 10:00:00'),
//     //   DateTime.parse('2024-06-27 09:45:00'),
//     //   DateTime.parse('2024-06-27 09:30:00'),
//     //   DateTime.parse('2024-06-27 09:15:00'),
//     //   DateTime.parse('2024-06-27 09:00:00'),
//     //
//     //   DateTime.parse('2024-06-25 23:45:00'),
//     //   DateTime.parse('2024-06-25 23:30:00'),
//     //   DateTime.parse('2024-06-25 23:15:00'),
//     //   DateTime.parse('2024-06-25 23:00:00'),
//     //   DateTime.parse('2024-06-25 22:45:00'),
//     //   DateTime.parse('2024-06-25 22:30:00'),
//     //   DateTime.parse('2024-06-25 22:15:00'),
//     //   DateTime.parse('2024-06-25 22:00:00'),
//     //
//     //   DateTime.parse('2024-06-25 10:45:00'),
//     //   DateTime.parse('2024-06-25 10:30:00'),
//     //   DateTime.parse('2024-06-25 10:15:00'),
//     //   DateTime.parse('2024-06-25 10:00:00'),
//     //   DateTime.parse('2024-06-25 09:45:00'),
//     //   DateTime.parse('2024-06-25 09:30:00'),
//     //   DateTime.parse('2024-06-25 09:15:00'),
//     //   DateTime.parse('2024-06-25 09:00:00'),
//     //
//     //   // ... (other date time values)
//     // ];
//     //
//     // final List<double> values = [
//     //   -0.177, -0.141, -0.115, -0.097, -0.057,
//     //   -0.038, -0.002, 0.039,
//     //   -0.177, -0.141, -0.115, -0.097, -0.057,
//     //   -0.038, -0.002, 0.039,
//     //   -0.177, -0.141, -0.115, -0.097, -0.057,
//     //   -0.038, -0.002, 0.039,
//     //   -0.177, -0.141, -0.115, -0.097, -0.057,
//     //   -0.038, -0.002, 0.039,
//     //   // ... (other values)
//     // ];
//
//     // Map<String, Map<int, Map<int, double>>> groupedData = {};
//     //
//     // print(graphProvider.dateTimes.length);
//     // print(graphProvider.values.length);
//     //
//     // for (int i = 0; i < graphProvider.dateTimes.length; i++) {
//     //   String date = DateFormat('yyyy-MM-dd').format(graphProvider.dateTimes[i]);
//     //   //print('Date at for loop: $date');
//     //   int hour = graphProvider.dateTimes[i].hour;
//     //   //print('Hour at for loop: $hour');
//     //   int minute = graphProvider.dateTimes[i].minute;
//     //   //print('Minute at for loop: $minute');
//     //
//     //   if (!groupedData.containsKey(date)) {
//     //     groupedData[date] = {};
//     //   }
//     //   if (!groupedData[date]!.containsKey(hour)) {
//     //     groupedData[date]![hour] = {};
//     //   }
//     //   groupedData[date]![hour]![minute] = graphProvider.values[i];
//     //
//     //   //print(groupedData[date]![hour]![minute]);
//     // }
//
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: const IconThemeData(
//           color: Colors.white,
//         ),
//         backgroundColor: Colors.blue,
//         title: Text(
//           'Data Availability Search Page',
//           style: GoogleFonts.poppins(
//               fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//
//       // body: ListView(
//       //   children: groupedData.keys.map((date) {
//       //     return Column(
//       //       crossAxisAlignment: CrossAxisAlignment.start,
//       //       children: [
//       //         Padding(
//       //           padding: const EdgeInsets.all(8.0),
//       //           child: Text(
//       //             date,
//       //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       //           ),
//       //         ),
//       //         Table(
//       //           border: TableBorder.all(),
//       //           columnWidths: {
//       //             0: FixedColumnWidth(100.0),
//       //             1: FixedColumnWidth(80.0),
//       //             2: FixedColumnWidth(80.0),
//       //             3: FixedColumnWidth(80.0),
//       //             4: FixedColumnWidth(80.0),
//       //           },
//       //           children: [
//       //             TableRow(
//       //               children: [
//       //                 TableCell(
//       //                   child: Container(
//       //                     padding: EdgeInsets.all(8.0),
//       //                     alignment: Alignment.center,
//       //                     child: Text(
//       //                       'Hour',
//       //                       style: TextStyle(fontWeight: FontWeight.bold),
//       //                     ),
//       //                   ),
//       //                 ),
//       //                 TableCell(
//       //                   child: Container(
//       //                     padding: EdgeInsets.all(8.0),
//       //                     alignment: Alignment.center,
//       //                     child: Text(
//       //                       '00.00',
//       //                       style: TextStyle(fontWeight: FontWeight.bold),
//       //                     ),
//       //                   ),
//       //                 ),
//       //                 TableCell(
//       //                   child: Container(
//       //                     padding: EdgeInsets.all(8.0),
//       //                     alignment: Alignment.center,
//       //                     child: Text(
//       //                       '00.15',
//       //                       style: TextStyle(fontWeight: FontWeight.bold),
//       //                     ),
//       //                   ),
//       //                 ),
//       //                 TableCell(
//       //                   child: Container(
//       //                     padding: EdgeInsets.all(8.0),
//       //                     alignment: Alignment.center,
//       //                     child: Text(
//       //                       '00.30',
//       //                       style: TextStyle(fontWeight: FontWeight.bold),
//       //                     ),
//       //                   ),
//       //                 ),
//       //                 TableCell(
//       //                   child: Container(
//       //                     padding: EdgeInsets.all(8.0),
//       //                     alignment: Alignment.center,
//       //                     child: Text(
//       //                       '00.45',
//       //                       style: TextStyle(fontWeight: FontWeight.bold),
//       //                     ),
//       //                   ),
//       //                 ),
//       //               ],
//       //             ),
//       //             ...groupedData[date]!.keys.map((hour) {
//       //               return TableRow(
//       //                 children: [
//       //                   TableCell(
//       //                     child: Container(
//       //                       padding: EdgeInsets.all(8.0),
//       //                       alignment: Alignment.center,
//       //                       child: Text(
//       //                         '$hour:00',
//       //                         style: TextStyle(fontWeight: FontWeight.bold),
//       //                       ),
//       //                     ),
//       //                   ),
//       //                   TableCell(
//       //                     child: Container(
//       //                       padding: EdgeInsets.all(8.0),
//       //                       alignment: Alignment.center,
//       //                       child: Text(
//       //                         groupedData[date]![hour]![0]?.toString() ?? '',
//       //                       ),
//       //                     ),
//       //                   ),
//       //                   TableCell(
//       //                     child: Container(
//       //                       padding: EdgeInsets.all(8.0),
//       //                       alignment: Alignment.center,
//       //                       child: Text(
//       //                         groupedData[date]![hour]![15]?.toString() ?? '',
//       //                       ),
//       //                     ),
//       //                   ),
//       //                   TableCell(
//       //                     child: Container(
//       //                       padding: EdgeInsets.all(8.0),
//       //                       alignment: Alignment.center,
//       //                       child: Text(
//       //                         groupedData[date]![hour]![30]?.toString() ?? '',
//       //                       ),
//       //                     ),
//       //                   ),
//       //                   TableCell(
//       //                     child: Container(
//       //                       padding: EdgeInsets.all(8.0),
//       //                       alignment: Alignment.center,
//       //                       child: Text(
//       //                         groupedData[date]![hour]![45]?.toString() ?? '',
//       //                       ),
//       //                     ),
//       //                   ),
//       //                 ],
//       //               );
//       //             }).toList(),
//       //           ],
//       //         ),
//       //       ],
//       //     );
//       //   }).toList(),
//       // ),
//
//       body: Center(
//         child: Container(
//           margin: EdgeInsets.all(10),
//           child: SingleChildScrollView(
//             child: Form(
//               key: formKey,
//               child: Column(
//                 children: [
//                   DropdownSearch<String>(
//                     items: districtInfoProvider.listOfdistrictNames,
//
//                     popupProps: const PopupProps.menu(
//                       showSearchBox: true,
//                     ),
//                     dropdownButtonProps: const DropdownButtonProps(
//                       color: Colors.black,
//                     ),
//                     dropdownDecoratorProps: DropDownDecoratorProps(
//                       textAlignVertical: TextAlignVertical.center,
//                       dropdownSearchDecoration: InputDecoration(
//                           contentPadding: const EdgeInsets.only(
//                               top: 12, bottom: 12, left: 8, right: 8),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: const BorderSide(
//                                   color: Colors.black, width: 1)),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: const BorderSide(
//                                   color: Colors.black, width: 1))),
//                     ),
//                     // onChanged: (value) {
//                     //   selectedDivision = value.toString();
//                     //   subdivisionProvider
//                     //       .getfilteredSubdivisionCode(selectedDivision);
//                     //   selectedDivisionCode =
//                     //       subdivisionProvider.filteredSubdivisionCode;
//                     //   setState(() {
//                     //     print('test: $selectedDivisionCode');
//                     //   });
//                     // },
//
//                     onChanged: (value) async {
//                       selectedDistrict = value;
//
//                       selectedDistrictId =
//                           districtInfoProvider.getDistrictId(value!);
//                       print(selectedDistrictId);
//                       //print(selectedDistrictId);
//
//                       await surfaceWaterAutoManualInfoProvider
//                           .surfaceWaterAutoManualInfo(
//                               context, selectedDistrictId);
//
//                       surfaceWaterAutoManualInfoProvider.getStationList();
//
//                       //print(surfaceWaterAutoManualInfoProvider.stationNames);
//                     },
//
//                     selectedItem: selectedDivision,
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   DropdownSearch<String>(
//                     items: surfaceWaterAutoManualInfoProvider.stationNames,
//                     popupProps: const PopupProps.menu(
//                       showSearchBox: true,
//                     ),
//                     dropdownButtonProps: const DropdownButtonProps(
//                       color: Colors.black,
//                     ),
//                     dropdownDecoratorProps: DropDownDecoratorProps(
//                       textAlignVertical: TextAlignVertical.center,
//                       dropdownSearchDecoration: InputDecoration(
//                           contentPadding: const EdgeInsets.only(
//                               top: 12, bottom: 12, left: 8, right: 8),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: const BorderSide(
//                                   color: Colors.black, width: 1)),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: const BorderSide(
//                                   color: Colors.black, width: 1))),
//                     ),
//                     onChanged: (value) {
//                       selectedStation = value;
//
//                       selectedStationCode = surfaceWaterAutoManualInfoProvider
//                           .getStationCode(value!);
//
//                       print('Selected Station Code: $selectedStationCode');
//
//                       // selectedDivision = value.toString();
//                       // subdivisionProvider
//                       //     .getfilteredSubdivisionCode(selectedDivision);
//                       // selectedDivisionCode =
//                       //     subdivisionProvider.filteredSubdivisionCode;
//                       // setState(() {
//                       //   print('test: $selectedDivisionCode');
//                       // });
//                     },
//                     selectedItem: selectedStation ?? 'Select Station',
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Text(
//                         'From Date',
//                         style: GoogleFonts.poppins(
//                             fontSize: 15, fontWeight: FontWeight.w500),
//                       ),
//                       Text(
//                         'To Date',
//                         style: GoogleFonts.poppins(
//                             fontSize: 15, fontWeight: FontWeight.w500),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextFormField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Select a year';
//                             }
//                           },
//                           controller: fromDateController,
//                           readOnly: true,
//                           decoration: InputDecoration(
//                             suffixIcon: IconButton(
//                                 onPressed: () async {
//                                   DateTime? pickedDate = await showDatePicker(
//                                       context: context,
//                                       initialDate: DateTime.now(),
//                                       firstDate: DateTime(1950),
//                                       lastDate: DateTime(2100));
//
//                                   if (pickedDate != null) {
//                                     String formattedDate =
//                                         DateFormat('yyyy-MM-dd')
//                                             .format(pickedDate);
//                                     print('From date: $formattedDate');
//                                     setState(() {
//                                       fromDateController.text = formattedDate;
//                                       print(fromDateController.text);
//                                     });
//                                   } else {}
//                                 },
//                                 icon: const Icon(
//                                   Icons.date_range,
//                                   color: Colors.blue,
//                                 )),
//                             contentPadding: const EdgeInsets.only(
//                                 left: 8, right: 8, top: 15, bottom: 15),
//                             enabledBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.black),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(12))),
//                             focusedBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.black),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(12))),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: TextFormField(
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Select a year';
//                             }
//                           },
//                           controller: toDateController,
//                           readOnly: true,
//                           decoration: InputDecoration(
//                             suffixIcon: IconButton(
//                                 onPressed: () async {
//                                   DateTime? pickedDate = await showDatePicker(
//                                       context: context,
//                                       initialDate: DateTime.now(),
//                                       firstDate: DateTime(1950),
//                                       lastDate: DateTime(2100));
//
//                                   if (pickedDate != null) {
//                                     String formattedDate =
//                                         DateFormat('yyyy-MM-dd')
//                                             .format(pickedDate);
//                                     print('to date: ${formattedDate}');
//                                     setState(() {
//                                       toDateController.text = formattedDate;
//                                       print(toDateController.text);
//                                     });
//                                   } else {}
//                                 },
//                                 icon: const Icon(
//                                   Icons.date_range,
//                                   color: Colors.blue,
//                                 )),
//                             contentPadding: const EdgeInsets.only(
//                                 left: 8, right: 8, top: 15, bottom: 15),
//                             enabledBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.black),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(12))),
//                             focusedBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.black),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(12))),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue),
//                       onPressed: () {
//                         if (formKey.currentState!.validate()) {
//                           // EasyLoading.show();
//                           // dataAvailabilityProvider
//                           //     .getWaterLevelAvailability(
//                           //         context,
//                           //         selectedDivisionCode,
//                           //         fromDateController.text,
//                           //         toDateController.text)
//                           //     .then((value) {
//                           //   EasyLoading.dismiss();
//                           //   if (value != null) {
//                           //     if (value["status"] == "success") {
//                           //       Navigator.of(context).pushNamed(
//                           //           DataAvailabilityListPage
//                           //               .dataAvailabilityListPage);
//                           //     }
//                           //   }
//                           // });
//                           EasyLoading.show();
//                           graphProvider
//                               .showSurfaceWaterDailyGraph(
//                                   selectedStationCode,
//                                   fromDateController.text,
//                                   toDateController.text,
//                                   context)
//                               .then((value) {
//                             EasyLoading.dismiss();
//                             // if (value != null) {
//                             //   if (value["status"] == "success") {
//                             //     Navigator.of(context).pushNamed(
//                             //         DataAvailabilityListPage
//                             //             .dataAvailabilityListPage);
//                             //   }
//                             // }
//
//                             if (graphProvider
//                                 .surfaceWaterDailyStationList.isNotEmpty) {
//                               // print(graphProvider.surfaceWaterDailyDateTime);
//                               // print(
//                               //     graphProvider.surfaceWaterDailyDateTimeValue);
//
//                               print(
//                                   "Mooooooo: ${graphProvider.dateTimes.length}");
//                               print("Moooo: ${graphProvider.values.length}");
//
//                               showDialog<String>(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     print(
//                                         "Mooooooo at show Dialog: ${graphProvider.dateTimes.length}");
//                                     print(
//                                         "Moooo at show Dialog: ${graphProvider.values.length}");
//
//                                     //print(groupedData);
//
//                                     Map<String, Map<int, Map<int, double>>>
//                                         groupedData = {};
//
//                                     print(graphProvider.dateTimes.length);
//                                     print(graphProvider.values.length);
//
//                                     for (int i = 0;
//                                         i < graphProvider.dateTimes.length;
//                                         i++) {
//                                       String date = DateFormat('yyyy-MM-dd')
//                                           .format(graphProvider.dateTimes[i]);
//                                       print('Date at for loop: $date');
//                                       int hour =
//                                           graphProvider.dateTimes[i].hour;
//                                       print('Hour at for loop: $hour');
//                                       int minute =
//                                           graphProvider.dateTimes[i].minute;
//                                       //print('Minute at for loop: $minute');
//
//                                       if (!groupedData.containsKey(date)) {
//                                         groupedData[date] = {};
//                                       }
//                                       if (!groupedData[date]!
//                                           .containsKey(hour)) {
//                                         groupedData[date]![hour] = {};
//                                       }
//                                       groupedData[date]![hour]![minute] =
//                                           graphProvider.values[i];
//
//                                       //print(groupedData[date]![hour]![minute]);
//                                     }
//
//                                     return AlertDialog(
//                                       contentPadding: EdgeInsets.zero,
//                                       insetPadding: const EdgeInsets.all(10),
//                                       content: SizedBox(
//                                         width:
//                                             MediaQuery.of(context).size.width,
//                                         height:
//                                             MediaQuery.of(context).size.height,
//                                         child: SingleChildScrollView(
//                                           child: Column(
//                                             children: [
//
//
//                                               Align(
//                                                 alignment: Alignment.topLeft,
//                                                 child: TextButton(
//                                                   onPressed: () {
//                                                     Navigator.pop(context);
//                                                   },
//                                                   child: const Icon(Icons.arrow_back),
//                                                 ),
//                                               ),
//
//
//                                               Text(
//                                                 "District Name: $selectedDistrict",
//                                                 style: GoogleFonts.poppins(
//                                                     fontSize: 14,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                               ),
//
//                                               Text(
//                                                 "Station Name: $selectedStation",
//                                                 style: GoogleFonts.poppins(
//                                                     fontSize: 14,
//                                                     fontWeight:
//                                                         FontWeight.w400),
//                                               ),
//                                               const SizedBox(
//                                                 height: 20,
//                                               ),
//                                               SfCartesianChart(
//                                                 backgroundColor: Colors.white,
//                                                 title: ChartTitle(
//                                                   text: 'Water Level Data',
//                                                   //backgroundColor: Colors.lightGreen,
//                                                   borderColor: Colors.black,
//                                                   borderWidth: 2,
//                                                   alignment:
//                                                       ChartAlignment.center,
//                                                   textStyle: TextStyle(
//                                                     color: Colors.black,
//                                                     fontStyle: FontStyle.italic,
//                                                     fontSize: 14,
//                                                   ),
//                                                 ),
//                                                 // tooltipBehavior: _tooltipBehavior,
//
//                                                 //Specifying date time interval type as hours
//                                                 primaryXAxis: DateTimeAxis(
//                                                   majorGridLines:
//                                                       MajorGridLines(width: 0),
//                                                   edgeLabelPlacement:
//                                                       EdgeLabelPlacement.shift,
//                                                   intervalType:
//                                                       DateTimeIntervalType.days,
//                                                   dateFormat:
//                                                       DateFormat('MMM dd'),
//                                                   labelRotation: 90,
//                                                 ),
//                                                 series: <LineSeries<SwStation,
//                                                     DateTime>>[
//                                                   LineSeries<SwStation,
//                                                       DateTime>(
//                                                     dataSource: graphProvider
//                                                         .surfaceWaterDailyStationList,
//                                                     xValueMapper: (SwStation
//                                                                 stations,
//                                                             _) =>
//                                                         DateTime.parse(
//                                                             stations.datetime!),
//                                                     yValueMapper: (SwStation
//                                                                 stations,
//                                                             _) =>
//                                                         double.parse(
//                                                             stations.value!),
//                                                     name: 'Sales',
//                                                     enableTooltip: true,
//                                                     markerSettings:
//                                                         MarkerSettings(
//                                                       isVisible: true,
//                                                       width: 10,
//                                                       height: 10,
//                                                       borderWidth: 2,
//                                                       borderColor: Colors.blue,
//                                                     ),
//                                                     dataLabelSettings:
//                                                         DataLabelSettings(
//                                                       isVisible: true,
//                                                       labelAlignment:
//                                                           ChartDataLabelAlignment
//                                                               .top,
//                                                       labelPosition:
//                                                           ChartDataLabelPosition
//                                                               .outside,
//                                                       labelIntersectAction:
//                                                           LabelIntersectAction
//                                                               .hide,
//                                                       textStyle: TextStyle(
//                                                         fontSize: 10,
//                                                         color: Colors.black,
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                       ),
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                               const SizedBox(
//                                                 height: 20,
//                                               ),
//
//                                               AspectRatio(
//                                                 aspectRatio: 1,
//                                                 child: ListView(
//
//                                                   children: groupedData.keys
//                                                       .map((date) {
//                                                     return Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(8.0),
//                                                           child: Text(
//                                                             date,
//                                                             style: TextStyle(
//                                                                 fontSize: 18,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                           ),
//                                                         ),
//                                                         SingleChildScrollView(
//                                                           scrollDirection: Axis.horizontal,
//                                                           child: Table(
//                                                             border:
//                                                                 TableBorder.all(),
//                                                             columnWidths: {
//                                                               0: FixedColumnWidth(
//                                                                   60.0),
//                                                               1: FixedColumnWidth(
//                                                                   60.0),
//                                                               2: FixedColumnWidth(
//                                                                   60.0),
//                                                               3: FixedColumnWidth(
//                                                                   60.0),
//                                                               4: FixedColumnWidth(
//                                                                   60.0),
//                                                             },
//                                                             children: [
//                                                               TableRow(
//                                                                 children: [
//                                                                   TableCell(
//                                                                     child:
//                                                                         Container(
//                                                                       padding:
//                                                                           EdgeInsets.all(
//                                                                               8.0),
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .center,
//                                                                       child: Text(
//                                                                         'Time',
//                                                                         style: TextStyle(
//                                                                             fontWeight:
//                                                                                 FontWeight.bold),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   TableCell(
//                                                                     child:
//                                                                         Container(
//                                                                       padding:
//                                                                           EdgeInsets.all(
//                                                                               8.0),
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .center,
//                                                                       child: Text(
//                                                                         '00.00',
//                                                                         style: TextStyle(
//                                                                             fontWeight:
//                                                                                 FontWeight.bold),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   TableCell(
//                                                                     child:
//                                                                         Container(
//                                                                       padding:
//                                                                           EdgeInsets.all(
//                                                                               8.0),
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .center,
//                                                                       child: Text(
//                                                                         '00.15',
//                                                                         style: TextStyle(
//                                                                             fontWeight:
//                                                                                 FontWeight.bold),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   TableCell(
//                                                                     child:
//                                                                         Container(
//                                                                       padding:
//                                                                           EdgeInsets.all(
//                                                                               8.0),
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .center,
//                                                                       child: Text(
//                                                                         '00.30',
//                                                                         style: TextStyle(
//                                                                             fontWeight:
//                                                                                 FontWeight.bold),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                   TableCell(
//                                                                     child:
//                                                                         Container(
//                                                                       padding:
//                                                                           EdgeInsets.all(
//                                                                               8.0),
//                                                                       alignment:
//                                                                           Alignment
//                                                                               .center,
//                                                                       child: Text(
//                                                                         '00.45',
//                                                                         style: TextStyle(
//                                                                             fontWeight:
//                                                                                 FontWeight.bold),
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                               ...groupedData[
//                                                                       date]!
//                                                                   .keys
//                                                                   .map((hour) {
//                                                                 return TableRow(
//                                                                   children: [
//                                                                     TableCell(
//                                                                       child:
//                                                                           Container(
//                                                                         padding:
//                                                                             EdgeInsets.all(
//                                                                                 8.0),
//                                                                         alignment:
//                                                                             Alignment
//                                                                                 .center,
//                                                                         child:
//                                                                             Text(
//                                                                           '$hour:00',
//                                                                           style: TextStyle(
//                                                                               fontWeight:
//                                                                                   FontWeight.bold),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     TableCell(
//                                                                       child:
//                                                                           Container(
//                                                                         padding:
//                                                                             EdgeInsets.all(
//                                                                                 8.0),
//                                                                         alignment:
//                                                                             Alignment
//                                                                                 .center,
//                                                                         child:
//                                                                             Text(
//                                                                           groupedData[date]![hour]![0]?.toString() ??
//                                                                               '',
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     TableCell(
//                                                                       child:
//                                                                           Container(
//                                                                         padding:
//                                                                             EdgeInsets.all(
//                                                                                 8.0),
//                                                                         alignment:
//                                                                             Alignment
//                                                                                 .center,
//                                                                         child:
//                                                                             Text(
//                                                                           groupedData[date]![hour]![15]?.toString() ??
//                                                                               '',
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     TableCell(
//                                                                       child:
//                                                                           Container(
//                                                                         padding:
//                                                                             EdgeInsets.all(
//                                                                                 8.0),
//                                                                         alignment:
//                                                                             Alignment
//                                                                                 .center,
//                                                                         child:
//                                                                             Text(
//                                                                           groupedData[date]![hour]![30]?.toString() ??
//                                                                               '',
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     TableCell(
//                                                                       child:
//                                                                           Container(
//                                                                         padding:
//                                                                             EdgeInsets.all(
//                                                                                 8.0),
//                                                                         alignment:
//                                                                             Alignment
//                                                                                 .center,
//                                                                         child:
//                                                                             Text(
//                                                                           groupedData[date]![hour]![45]?.toString() ??
//                                                                               '',
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 );
//                                                               }).toList(),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         const SizedBox(height: 35.0,)
//
//                                                       ],
//                                                     );
//                                                   }).toList(),
//                                                 ),
//                                               ),
//
//
//
//                                               // SfCartesianChart(
//                                               //     primaryXAxis:
//                                               //     CategoryAxis(
//                                               //         title: AxisTitle(
//                                               //             text:
//                                               //             'Date')),
//                                               //     primaryYAxis: NumericAxis(
//                                               //         title: AxisTitle(
//                                               //             text:
//                                               //             'RF(mm)')),
//                                               //     series: <CartesianSeries>[
//                                               //       // Renders line chart
//                                               //       BarSeries<
//                                               //           RfData,
//                                               //           String>(
//                                               //           dataSource: graphProvider
//                                               //               .rainfallDataList,
//                                               //           xValueMapper: (RfData
//                                               //           data,
//                                               //               _) =>
//                                               //           data
//                                               //               .logDate,
//                                               //           yValueMapper: (RfData
//                                               //           data,
//                                               //               _) =>
//                                               //               num.parse(
//                                               //                   data.rainfall!))
//                                               //     ]),
//                                               // const SizedBox(
//                                               //   height: 15,
//                                               // ),
//                                               // Padding(
//                                               //   padding:
//                                               //   const EdgeInsets
//                                               //       .all(10),
//                                               //   child: ListView
//                                               //       .builder(
//                                               //     physics:
//                                               //     NeverScrollableScrollPhysics(),
//                                               //     shrinkWrap: true,
//                                               //     itemCount:
//                                               //     graphProvider
//                                               //         .rainfallDataList
//                                               //         .length,
//                                               //     itemBuilder:
//                                               //         (BuildContext
//                                               //     context,
//                                               //         int index) {
//                                               //       return Card(
//                                               //         shape: RoundedRectangleBorder(
//                                               //             borderRadius:
//                                               //             BorderRadius.circular(
//                                               //                 10)),
//                                               //         elevation: 5,
//                                               //         color: Colors
//                                               //             .blue,
//                                               //         child: Column(
//                                               //           children: [
//                                               //             Text(
//                                               //               "Date: ${graphProvider.rainfallDataList[index].logDate}",
//                                               //               style: GoogleFonts.poppins(
//                                               //                   fontSize:
//                                               //                   14,
//                                               //                   fontWeight:
//                                               //                   FontWeight.w400,
//                                               //                   color: Colors.white),
//                                               //             ),
//                                               //             const SizedBox(
//                                               //               height:
//                                               //               5,
//                                               //             ),
//                                               //             Padding(
//                                               //               padding: const EdgeInsets
//                                               //                   .all(
//                                               //                   8.0),
//                                               //               child:
//                                               //               Table(
//                                               //                 border:
//                                               //                 TableBorder.all(color: Colors.white),
//                                               //                 children: [
//                                               //                   TableRow(children: [
//                                               //                     Center(
//                                               //                       child: Padding(
//                                               //                         padding: const EdgeInsets.all(5),
//                                               //                         child: Text(
//                                               //                           'Time',
//                                               //                           style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
//                                               //                         ),
//                                               //                       ),
//                                               //                     ),
//                                               //                     Center(
//                                               //                       child: Padding(
//                                               //                         padding: const EdgeInsets.all(5),
//                                               //                         child: Text(
//                                               //                           'RF(mm)',
//                                               //                           style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
//                                               //                         ),
//                                               //                       ),
//                                               //                     ),
//                                               //                   ]),
//                                               //                   TableRow(children: [
//                                               //                     Center(
//                                               //                       child: Padding(
//                                               //                         padding: const EdgeInsets.all(5),
//                                               //                         child: Text(
//                                               //                           "6:00",
//                                               //                           style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
//                                               //                         ),
//                                               //                       ),
//                                               //                     ),
//                                               //                     Center(
//                                               //                       child: Padding(
//                                               //                         padding: const EdgeInsets.all(5),
//                                               //                         child: Text(
//                                               //                           graphProvider.rainfallDataList[index].rainfall!,
//                                               //                           style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
//                                               //                         ),
//                                               //                       ),
//                                               //                     ),
//                                               //                   ]),
//                                               //                 ],
//                                               //               ),
//                                               //             ),
//                                               //             const SizedBox(
//                                               //               height:
//                                               //               5,
//                                               //             )
//                                               //           ],
//                                               //         ),
//                                               //       );
//                                               //     },
//                                               //   ),
//                                               // ),
//                                               // const SizedBox(
//                                               //   height: 10,
//                                               // ),
//                                               // ElevatedButton(
//                                               //   style: ElevatedButton.styleFrom(
//                                               //       elevation: 5,
//                                               //       backgroundColor:
//                                               //       Colors.blue,
//                                               //       shape: RoundedRectangleBorder(
//                                               //           borderRadius:
//                                               //           BorderRadius.circular(
//                                               //               8))),
//                                               //   onPressed: () =>
//                                               //       Navigator.pop(
//                                               //           context),
//                                               //   child: Text('OK',
//                                               //       style: GoogleFonts.poppins(
//                                               //           fontSize:
//                                               //           14,
//                                               //           fontWeight:
//                                               //           FontWeight
//                                               //               .w400,
//                                               //           color: Colors
//                                               //               .white)),
//                                               // ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   });
//                             } else if (graphProvider.rainfallDataList.isEmpty) {
//                               var snackBar = const SnackBar(
//                                   content: Text(
//                                       'Your selected date range has no data'));
//                               ScaffoldMessenger.of(context)
//                                   .showSnackBar(snackBar);
//                             }
//                           });
//                         }
//                       },
//                       child: Text('Show Data',
//                           style: GoogleFonts.poppins(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w400,
//                               color: Colors.white))),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // SingleChildScrollView(
// //   child: Column(
// //     children: [
// //       const SizedBox(
// //         height: 40,
// //       ),
// //       Text(
// //         "District Name: $selectedDistrict",
// //         style: GoogleFonts
// //             .poppins(
// //             fontSize:
// //             14,
// //             fontWeight:
// //             FontWeight
// //                 .w400),
// //       ),
// //
// //       Text(
// //         "Station Name: $selectedStation",
// //         style: GoogleFonts
// //             .poppins(
// //             fontSize:
// //             14,
// //             fontWeight:
// //             FontWeight
// //                 .w400),
// //       ),
// //       const SizedBox(
// //         height: 20,
// //       ),
// //       SfCartesianChart(
// //         backgroundColor: Colors.white,
// //         title: ChartTitle(
// //           text: 'Water Level Data',
// //           backgroundColor: Colors.lightGreen,
// //           borderColor: Colors.red,
// //           borderWidth: 5,
// //           alignment: ChartAlignment.near,
// //           textStyle: TextStyle(
// //             color: Colors.red,
// //             fontStyle: FontStyle.italic,
// //             fontSize: 14,
// //           ),
// //         ),
// //        // tooltipBehavior: _tooltipBehavior,
// //
// //         //Specifying date time interval type as hours
// //         primaryXAxis: DateTimeAxis(
// //           majorGridLines: MajorGridLines(width: 0),
// //           edgeLabelPlacement: EdgeLabelPlacement.shift,
// //           intervalType: DateTimeIntervalType.days,
// //           dateFormat: DateFormat('MMM dd'),
// //           labelRotation: 90,
// //         ),
// //         series: <LineSeries<SwStation, DateTime>>[
// //           LineSeries<SwStation, DateTime>(
// //             dataSource: graphProvider.surfaceWaterDailyStationList,
// //             xValueMapper: (SwStation stations, _) => DateTime.parse(stations.datetime!),
// //             yValueMapper: (SwStation stations, _) => double.parse(stations.value!),
// //             name: 'Sales',
// //             enableTooltip: true,
// //             markerSettings: MarkerSettings(
// //               isVisible: true,
// //               width: 10,
// //               height: 10,
// //               borderWidth: 2,
// //               borderColor: Colors.blue,
// //             ),
// //             dataLabelSettings: DataLabelSettings(
// //               isVisible: true,
// //               labelAlignment: ChartDataLabelAlignment.top,
// //               labelPosition: ChartDataLabelPosition.outside,
// //               labelIntersectAction: LabelIntersectAction.hide,
// //               textStyle: TextStyle(
// //                 fontSize: 10,
// //                 color: Colors.black,
// //                 fontWeight: FontWeight.bold,
// //               ),
// //             ),
// //           )
// //         ],
// //       ),
// //       const SizedBox(height: 20,),
// //
// //       SizedBox(
// //         height: 500,
// //         width: double.infinity,
// //         child: ListView(
// //           children: groupedData.keys.map((date) {
// //             return Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Padding(
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: Text(
// //                     date,
// //                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //                   ),
// //                 ),
// //                 Table(
// //                   border: TableBorder.all(),
// //                   columnWidths: {
// //                     0: FixedColumnWidth(80.0),
// //                     1: FixedColumnWidth(80.0),
// //                     2: FixedColumnWidth(80.0),
// //                     3: FixedColumnWidth(80.0),
// //                     4: FixedColumnWidth(80.0),
// //                   },
// //                   children: [
// //                     TableRow(
// //                       children: [
// //                         TableCell(
// //                           child: Container(
// //                             padding: EdgeInsets.all(8.0),
// //                             alignment: Alignment.center,
// //                             child: Text(
// //                               'Hour',
// //                               style: TextStyle(fontWeight: FontWeight.bold),
// //                             ),
// //                           ),
// //                         ),
// //                         TableCell(
// //                           child: Container(
// //                             padding: EdgeInsets.all(8.0),
// //                             alignment: Alignment.center,
// //                             child: Text(
// //                               '00.00',
// //                               style: TextStyle(fontWeight: FontWeight.bold),
// //                             ),
// //                           ),
// //                         ),
// //                         TableCell(
// //                           child: Container(
// //                             padding: EdgeInsets.all(8.0),
// //                             alignment: Alignment.center,
// //                             child: Text(
// //                               '00.15',
// //                               style: TextStyle(fontWeight: FontWeight.bold),
// //                             ),
// //                           ),
// //                         ),
// //                         TableCell(
// //                           child: Container(
// //                             padding: EdgeInsets.all(8.0),
// //                             alignment: Alignment.center,
// //                             child: Text(
// //                               '00.30',
// //                               style: TextStyle(fontWeight: FontWeight.bold),
// //                             ),
// //                           ),
// //                         ),
// //                         TableCell(
// //                           child: Container(
// //                             padding: EdgeInsets.all(8.0),
// //                             alignment: Alignment.center,
// //                             child: Text(
// //                               '00.45',
// //                               style: TextStyle(fontWeight: FontWeight.bold),
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     ...groupedData[date]!.keys.map((hour) {
// //                       return TableRow(
// //                         children: [
// //                           TableCell(
// //                             child: Container(
// //                               padding: EdgeInsets.all(8.0),
// //                               alignment: Alignment.center,
// //                               child: Text(
// //                                 '$hour:00',
// //                                 style: TextStyle(fontWeight: FontWeight.bold),
// //                               ),
// //                             ),
// //                           ),
// //                           TableCell(
// //                             child: Container(
// //                               padding: EdgeInsets.all(8.0),
// //                               alignment: Alignment.center,
// //                               child: Text(
// //                                 groupedData[date]![hour]![0]?.toString() ?? '',
// //                               ),
// //                             ),
// //                           ),
// //                           TableCell(
// //                             child: Container(
// //                               padding: EdgeInsets.all(8.0),
// //                               alignment: Alignment.center,
// //                               child: Text(
// //                                 groupedData[date]![hour]![15]?.toString() ?? '',
// //                               ),
// //                             ),
// //                           ),
// //                           TableCell(
// //                             child: Container(
// //                               padding: EdgeInsets.all(8.0),
// //                               alignment: Alignment.center,
// //                               child: Text(
// //                                 groupedData[date]![hour]![30]?.toString() ?? '',
// //                               ),
// //                             ),
// //                           ),
// //                           TableCell(
// //                             child: Container(
// //                               padding: EdgeInsets.all(8.0),
// //                               alignment: Alignment.center,
// //                               child: Text(
// //                                 groupedData[date]![hour]![45]?.toString() ?? '',
// //                               ),
// //                             ),
// //                           ),
// //                         ],
// //                       );
// //                     }).toList(),
// //                   ],
// //                 ),
// //               ],
// //             );
// //           }).toList(),
// //         ),
// //       ),
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //       // SfCartesianChart(
// //       //     primaryXAxis:
// //       //     CategoryAxis(
// //       //         title: AxisTitle(
// //       //             text:
// //       //             'Date')),
// //       //     primaryYAxis: NumericAxis(
// //       //         title: AxisTitle(
// //       //             text:
// //       //             'RF(mm)')),
// //       //     series: <CartesianSeries>[
// //       //       // Renders line chart
// //       //       BarSeries<
// //       //           RfData,
// //       //           String>(
// //       //           dataSource: graphProvider
// //       //               .rainfallDataList,
// //       //           xValueMapper: (RfData
// //       //           data,
// //       //               _) =>
// //       //           data
// //       //               .logDate,
// //       //           yValueMapper: (RfData
// //       //           data,
// //       //               _) =>
// //       //               num.parse(
// //       //                   data.rainfall!))
// //       //     ]),
// //       // const SizedBox(
// //       //   height: 15,
// //       // ),
// //       // Padding(
// //       //   padding:
// //       //   const EdgeInsets
// //       //       .all(10),
// //       //   child: ListView
// //       //       .builder(
// //       //     physics:
// //       //     NeverScrollableScrollPhysics(),
// //       //     shrinkWrap: true,
// //       //     itemCount:
// //       //     graphProvider
// //       //         .rainfallDataList
// //       //         .length,
// //       //     itemBuilder:
// //       //         (BuildContext
// //       //     context,
// //       //         int index) {
// //       //       return Card(
// //       //         shape: RoundedRectangleBorder(
// //       //             borderRadius:
// //       //             BorderRadius.circular(
// //       //                 10)),
// //       //         elevation: 5,
// //       //         color: Colors
// //       //             .blue,
// //       //         child: Column(
// //       //           children: [
// //       //             Text(
// //       //               "Date: ${graphProvider.rainfallDataList[index].logDate}",
// //       //               style: GoogleFonts.poppins(
// //       //                   fontSize:
// //       //                   14,
// //       //                   fontWeight:
// //       //                   FontWeight.w400,
// //       //                   color: Colors.white),
// //       //             ),
// //       //             const SizedBox(
// //       //               height:
// //       //               5,
// //       //             ),
// //       //             Padding(
// //       //               padding: const EdgeInsets
// //       //                   .all(
// //       //                   8.0),
// //       //               child:
// //       //               Table(
// //       //                 border:
// //       //                 TableBorder.all(color: Colors.white),
// //       //                 children: [
// //       //                   TableRow(children: [
// //       //                     Center(
// //       //                       child: Padding(
// //       //                         padding: const EdgeInsets.all(5),
// //       //                         child: Text(
// //       //                           'Time',
// //       //                           style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
// //       //                         ),
// //       //                       ),
// //       //                     ),
// //       //                     Center(
// //       //                       child: Padding(
// //       //                         padding: const EdgeInsets.all(5),
// //       //                         child: Text(
// //       //                           'RF(mm)',
// //       //                           style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
// //       //                         ),
// //       //                       ),
// //       //                     ),
// //       //                   ]),
// //       //                   TableRow(children: [
// //       //                     Center(
// //       //                       child: Padding(
// //       //                         padding: const EdgeInsets.all(5),
// //       //                         child: Text(
// //       //                           "6:00",
// //       //                           style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
// //       //                         ),
// //       //                       ),
// //       //                     ),
// //       //                     Center(
// //       //                       child: Padding(
// //       //                         padding: const EdgeInsets.all(5),
// //       //                         child: Text(
// //       //                           graphProvider.rainfallDataList[index].rainfall!,
// //       //                           style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
// //       //                         ),
// //       //                       ),
// //       //                     ),
// //       //                   ]),
// //       //                 ],
// //       //               ),
// //       //             ),
// //       //             const SizedBox(
// //       //               height:
// //       //               5,
// //       //             )
// //       //           ],
// //       //         ),
// //       //       );
// //       //     },
// //       //   ),
// //       // ),
// //       // const SizedBox(
// //       //   height: 10,
// //       // ),
// //       ElevatedButton(
// //         style: ElevatedButton.styleFrom(
// //             elevation: 5,
// //             backgroundColor:
// //             Colors.blue,
// //             shape: RoundedRectangleBorder(
// //                 borderRadius:
// //                 BorderRadius.circular(
// //                     8))),
// //         onPressed: () =>
// //             Navigator.pop(
// //                 context),
// //         child: Text('OK',
// //             style: GoogleFonts.poppins(
// //                 fontSize:
// //                 14,
// //                 fontWeight:
// //                 FontWeight
// //                     .w400,
// //                 color: Colors
// //                     .white)),
// //       ),
// //     ],
// //   ),
// // ),
//
// //
// // ListView(
// // shrinkWrap: true,
// // children: groupedData.keys.map((date) {
// // print('Sadi. $date');
// // return Column(
// // crossAxisAlignment: CrossAxisAlignment.start,
// // children: [
// // Padding(
// // padding: const EdgeInsets.all(8.0),
// // child: Text(
// // date,
// // style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // ),
// // ),
// // Table(
// // border: TableBorder.all(),
// // columnWidths: {
// // 0: FixedColumnWidth(100.0),
// // 1: FixedColumnWidth(80.0),
// // 2: FixedColumnWidth(80.0),
// // 3: FixedColumnWidth(80.0),
// // 4: FixedColumnWidth(80.0),
// // },
// // children: [
// // TableRow(
// // children: [
// // TableCell(
// // child: Container(
// // padding: EdgeInsets.all(8.0),
// // alignment: Alignment.center,
// // child: Text(
// // 'Hour',
// // style: TextStyle(fontWeight: FontWeight.bold),
// // ),
// // ),
// // ),
// // TableCell(
// // child: Container(
// // padding: EdgeInsets.all(8.0),
// // alignment: Alignment.center,
// // child: Text(
// // '00.00',
// // style: TextStyle(fontWeight: FontWeight.bold),
// // ),
// // ),
// // ),
// // TableCell(
// // child: Container(
// // padding: EdgeInsets.all(8.0),
// // alignment: Alignment.center,
// // child: Text(
// // '00.15',
// // style: TextStyle(fontWeight: FontWeight.bold),
// // ),
// // ),
// // ),
// // TableCell(
// // child: Container(
// // padding: EdgeInsets.all(8.0),
// // alignment: Alignment.center,
// // child: Text(
// // '00.30',
// // style: TextStyle(fontWeight: FontWeight.bold),
// // ),
// // ),
// // ),
// // TableCell(
// // child: Container(
// // padding: EdgeInsets.all(8.0),
// // alignment: Alignment.center,
// // child: Text(
// // '00.45',
// // style: TextStyle(fontWeight: FontWeight.bold),
// // ),
// // ),
// // ),
// // ],
// // ),
// // ...groupedData[date]!.keys.map((hour) {
// // return TableRow(
// // children: [
// // TableCell(
// // child: Container(
// // padding: EdgeInsets.all(8.0),
// // alignment: Alignment.center,
// // child: Text(
// // '$hour:00',
// // style: TextStyle(fontWeight: FontWeight.bold),
// // ),
// // ),
// // ),
// // TableCell(
// // child: Container(
// // padding: EdgeInsets.all(8.0),
// // alignment: Alignment.center,
// // child: Text(
// // groupedData[date]![hour]![0]?.toString() ?? '',
// // ),
// // ),
// // ),
// // TableCell(
// // child: Container(
// // padding: EdgeInsets.all(8.0),
// // alignment: Alignment.center,
// // child: Text(
// // groupedData[date]![hour]![15]?.toString() ?? '',
// // ),
// // ),
// // ),
// // TableCell(
// // child: Container(
// // padding: EdgeInsets.all(8.0),
// // alignment: Alignment.center,
// // child: Text(
// // groupedData[date]![hour]![30]?.toString() ?? '',
// // ),
// // ),
// // ),
// // TableCell(
// // child: Container(
// // padding: EdgeInsets.all(8.0),
// // alignment: Alignment.center,
// // child: Text(
// // groupedData[date]![hour]![45]?.toString() ?? '',
// // ),
// // ),
// // ),
// // ],
// // );
// // }).toList(),
// // ],
// // ),
// // ],
// // );
// // }).toList(),
// // ),


import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydroinformatics_data_management_system/providers/data_availability_provider.dart';
import 'package:hydroinformatics_data_management_system/providers/subdivision_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'data_availability_list_page.dart';

class WaterLevelAvailabilitySearchPage extends StatefulWidget {
  const WaterLevelAvailabilitySearchPage({super.key});

  static const waterLevelAvailabilitySearchPage =
      'waterLevelAvailabilitySearchPage';

  @override
  State<WaterLevelAvailabilitySearchPage> createState() =>
      _WaterLevelAvailabilitySearchPageState();
}

class _WaterLevelAvailabilitySearchPageState
    extends State<WaterLevelAvailabilitySearchPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  late SubdivisionProvider subdivisionProvider;
  late DataAvailabilityProvider dataAvailabilityProvider;
  bool callOnce = true;
  dynamic selectedDivision;
  dynamic selectedDivisionCode;

  @override
  void didChangeDependencies() {
    subdivisionProvider = Provider.of(context, listen: true);
    dataAvailabilityProvider = Provider.of(context);
    if (callOnce) {
      subdivisionProvider.getSubdivisionList();
      subdivisionProvider.getSubdivisionCodeList();
      callOnce = false;
    }
    super.didChangeDependencies();
    selectedDivision = subdivisionProvider.allSubDivisionList[0];
    selectedDivisionCode = subdivisionProvider.allDivisionCodeList[0];
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
          'Data Availability Search Page',
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  DropdownSearch<String>(
                    items: subdivisionProvider.allSubDivisionList,
                    popupProps: const PopupProps.menu(
                      showSearchBox: true,
                    ),
                    dropdownButtonProps: const DropdownButtonProps(
                      color: Colors.black,
                    ),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      textAlignVertical: TextAlignVertical.center,
                      dropdownSearchDecoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              top: 12, bottom: 12, left: 8, right: 8),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1))),
                    ),
                    onChanged: (value) {
                      selectedDivision = value.toString();
                      subdivisionProvider
                          .getfilteredSubdivisionCode(selectedDivision);
                      selectedDivisionCode =
                          subdivisionProvider.filteredSubdivisionCode;
                      setState(() {
                        print('test: $selectedDivisionCode');
                      });
                    },
                    selectedItem: selectedDivision,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'From Date',
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'To Date',
                        style: GoogleFonts.poppins(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Select a year';
                            }
                          },
                          controller: fromDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    String formattedDate =
                                    DateFormat('yyyy').format(pickedDate);
                                    print('From date: $formattedDate');
                                    setState(() {
                                      fromDateController.text = formattedDate;
                                    });
                                  } else {}
                                },
                                icon: const Icon(
                                  Icons.date_range,
                                  color: Colors.blue,
                                )),
                            contentPadding: const EdgeInsets.only(
                                left: 8, right: 8, top: 15, bottom: 15),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Select a year';
                            }
                          },
                          controller: toDateController,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    String formattedDate =
                                    DateFormat('yyyy').format(pickedDate);
                                    print('to date: ${formattedDate}');
                                    setState(() {
                                      toDateController.text = formattedDate;
                                    });
                                  } else {}
                                },
                                icon: const Icon(
                                  Icons.date_range,
                                  color: Colors.blue,
                                )),
                            contentPadding: const EdgeInsets.only(
                                left: 8, right: 8, top: 15, bottom: 15),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          EasyLoading.show();
                          dataAvailabilityProvider
                              .getWaterLevelAvailability(
                              context,
                              selectedDivisionCode,
                              fromDateController.text,
                              toDateController.text)
                              .then((value) {
                            EasyLoading.dismiss();
                            if (value != null) {
                              if (value["status"] == "success") {
                                Navigator.of(context).pushNamed(
                                    DataAvailabilityListPage
                                        .dataAvailabilityListPage);
                              }
                            }
                          });
                        }
                      },
                      child: Text('Show Data',
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

