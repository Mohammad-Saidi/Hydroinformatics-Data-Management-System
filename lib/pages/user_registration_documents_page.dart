import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';




class UserRegistrationDocumentsPage extends StatefulWidget {
  const UserRegistrationDocumentsPage({super.key, required this.data});
  final String? data;

  @override
  State<UserRegistrationDocumentsPage> createState() => _UserRegistrationDocumentsPageState();
}

class _UserRegistrationDocumentsPageState extends State<UserRegistrationDocumentsPage> {












  @override
  Widget build(BuildContext context) {

    print('User Registration Documents Page: ${widget.data}');


    Uint8List bytesImage = const Base64Decoder().convert(widget.data!);




    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        child: Image.memory(bytesImage),
      ),
    );
  }
}
