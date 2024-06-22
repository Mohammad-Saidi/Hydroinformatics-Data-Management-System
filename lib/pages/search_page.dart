import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom/drawer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF64B5F6),
      //backgroundColor: Colors.red,
      drawer: HomePageDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Search Page',
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'This searching page is under construction. Thanks for using this app',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
