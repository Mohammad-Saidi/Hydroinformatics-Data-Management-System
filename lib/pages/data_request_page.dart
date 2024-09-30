import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hydroinformatics_data_management_system/pages/data_request_details_page.dart";
import "package:provider/provider.dart";

import "../providers/data_request_provider.dart";

class DataRequestPage extends StatefulWidget {
  const DataRequestPage({super.key});

  static const String dataRequestPage = 'dataRequestPage';

  @override
  State<DataRequestPage> createState() => _DataRequestPageState();
}

class _DataRequestPageState extends State<DataRequestPage>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  bool callOnce = true;

  late DataRequestProvider dataRequestProvider;

  String labelText = 'Username';

  @override
  void initState() {
    // TODO: implement initState
    dataRequestProvider = Provider.of(context, listen: false);
    dataRequestProvider.getDataRequestInfo(context, 1).then((value) {
      dataRequestProvider.getDataRequestList();
    });
    setState(() {

    });
    super.initState();



    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);

    print("ami prit hossi");

  }

  void _handleTabSelection() {

    if (_tabController.indexIsChanging) {
      if (_tabController.index == 0) {
        dataRequestProvider.getDataRequestInfo(context, 1).then((value) {
          dataRequestProvider.getDataRequestList();
        });
        setState(() {

        });
      } else if (_tabController.index == 1) {
        dataRequestProvider.getDataRequestInfo(context, 2).then((value) {
          dataRequestProvider.getDataRequestList();
        });
        setState(() {

        });
      }
    }


  }



  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  void _updateLabelText(String newText) {
    setState(() {
      labelText = newText;
    });
  }

  // @override
  // void initState() {
  //   dataRequestProvider = Provider.of(context, listen: false);
  //   if (callOnce) {
  //     dataRequestProvider.getDataRequestInfo(context).then((value) {
  //       dataRequestProvider.getDataRequestList();
  //     });
  //     callOnce = false;
  //   }
  //   // TODO: implement initState
  //   super.initState();
  // }

  // @override
  // void didChangeDependencies() {
  //   dataRequestProvider = Provider.of(context, listen: true);
  //   if (callOnce) {
  //     dataRequestProvider.getDataRequestInfo(context, 1).then((value) {
  //       dataRequestProvider.getDataRequestList();
  //     });
  //     callOnce = false;
  //   }
  //
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        title: Text(
          'Data Request (Pending)',
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: Colors.blue[900],
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3.0,
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              child: Text('Online Data Request', style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400, color: Colors.white),),
            ),
            Tab(
              child: Text('Offline Data Request', style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400, color: Colors.white),),
            ),
          ],
        ),

        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.list),
        //   ),
        // ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: dataRequestProvider.dataRequestList.isEmpty
                    ? Center(
                    child: Text(
                      'No pending data request .....',
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ))
                    : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                //provider.search(value);
                                dataRequestProvider.search(labelText, value);
                                print('TextField Value: $value');
                              },
                              decoration: InputDecoration(
                                labelText: labelText,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert),
                            onSelected: (String value) {
                              print(value);
                              _updateLabelText(value);
                            },
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem<String>(
                                  value: 'Username',
                                  child: Text('Username'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'Gmail',
                                  child: Text('Gmail'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'Contact Number',
                                  child: Text('Contact Number'),
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        //itemCount: dataRequestProvider.dataRequestList.length,
                        itemCount: dataRequestProvider
                            .searchedDataRequestInfoModel.data?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  DataRequestDetailsPage
                                      .dataRequestDetailsPage,
                                  arguments: dataRequestProvider
                                      .dataRequestList[index].reqMasId);
                            },
                            child: Card(
                                color: Colors.lightBlue.withOpacity(.5),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        color: Colors.blueAccent)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        //'User Name: ${dataRequestProvider.dataRequestList[index].userName}',
                                        //'User Name: ${dataRequestProvider.searchedDataRequestInfoModel.dataRequestInfo?[index].userName}',
                                          dataRequestProvider
                                              .searchedDataRequestInfoModel
                                              .data?[index]
                                              .userName as String,
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        //'Email: ${dataRequestProvider.dataRequestList[index].email}',
                                          'Email: ${dataRequestProvider.searchedDataRequestInfoModel.data?[index].email}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        // 'Contact: ${dataRequestProvider.dataRequestList[index].mobileNo}',
                                          'Contact: ${dataRequestProvider.searchedDataRequestInfoModel.data?[index].mobileNo}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        // 'Request Type: ${dataRequestProvider.dataRequestList[index].category}',
                                          'Request Type: ${dataRequestProvider.searchedDataRequestInfoModel.data?[index].category}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        // 'Invoice Date: ${dataRequestProvider.dataRequestList[index].requestDate}',
                                          'Invoice Date: ${dataRequestProvider.searchedDataRequestInfoModel.data?[index].requestDate}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                    ],
                                  ),
                                )),
                          );
                        }),
                  ],
                ),
              )),
          Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: dataRequestProvider.dataRequestList.isEmpty
                    ? Center(
                    child: Text(
                      'No pending data request .....',
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ))
                    : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                //provider.search(value);
                                dataRequestProvider.search(labelText, value);
                                print('TextField Value: $value');
                              },
                              decoration: InputDecoration(
                                labelText: labelText,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert),
                            onSelected: (String value) {
                              print(value);
                              _updateLabelText(value);
                            },
                            itemBuilder: (BuildContext context) {
                              return [
                                PopupMenuItem<String>(
                                  value: 'Username',
                                  child: Text('Username'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'Gmail',
                                  child: Text('Gmail'),
                                ),
                                PopupMenuItem<String>(
                                  value: 'Contact Number',
                                  child: Text('Contact Number'),
                                ),
                              ];
                            },
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        //itemCount: dataRequestProvider.dataRequestList.length,
                        itemCount: dataRequestProvider
                            .searchedDataRequestInfoModel.data?.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  DataRequestDetailsPage
                                      .dataRequestDetailsPage,
                                  arguments: dataRequestProvider
                                      .dataRequestList[index].reqMasId);
                            },
                            child: Card(
                                color: Colors.lightBlue.withOpacity(.5),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                        color: Colors.blueAccent)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        //'User Name: ${dataRequestProvider.dataRequestList[index].userName}',
                                        //'User Name: ${dataRequestProvider.searchedDataRequestInfoModel.dataRequestInfo?[index].userName}',
                                          dataRequestProvider
                                              .searchedDataRequestInfoModel
                                              .data?[index]
                                              .userName as String,
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        //'Email: ${dataRequestProvider.dataRequestList[index].email}',
                                          'Email: ${dataRequestProvider.searchedDataRequestInfoModel.data?[index].email}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        // 'Contact: ${dataRequestProvider.dataRequestList[index].mobileNo}',
                                          'Contact: ${dataRequestProvider.searchedDataRequestInfoModel.data?[index].mobileNo}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        // 'Request Type: ${dataRequestProvider.dataRequestList[index].category}',
                                          'Request Type: ${dataRequestProvider.searchedDataRequestInfoModel.data?[index].category}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        // 'Invoice Date: ${dataRequestProvider.dataRequestList[index].requestDate}',
                                          'Invoice Date: ${dataRequestProvider.searchedDataRequestInfoModel.data?[index].requestDate}',
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                    ],
                                  ),
                                )),
                          );
                        }),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
