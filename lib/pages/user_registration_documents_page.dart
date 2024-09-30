import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class UserRegistrationDocumentsPage extends StatefulWidget {
  const UserRegistrationDocumentsPage(
      {super.key,
      required this.data,
      required this.isItPdf,
      required this.isItImage,
      required this.mimeType});

  final String? data;
  final bool? isItPdf;
  final bool? isItImage;
  final String? mimeType;

  @override
  State<UserRegistrationDocumentsPage> createState() =>
      _UserRegistrationDocumentsPageState();
}

class _UserRegistrationDocumentsPageState
    extends State<UserRegistrationDocumentsPage> {
  @override
  void dispose() {
    PaintingBinding.instance.imageCache.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
// print("Widget data type: ${widget.dataType}");
//
//     bool? isItPdf =
//     widget.dataType?[1].contains('pdf');
//     bool? isItImage =
//     widget.dataType?[1].contains('image');
//     print('Pdf: $isItPdf');
//     print('Image: $isItImage');

    print('Is It pdf : ${widget.isItPdf}');
    print('Is It Image: ${widget.isItImage}');
    bool? isItPdf = widget.isItPdf;
    bool? isItImage = widget.isItImage;
    String? mimeType = widget.mimeType;

    // Uint8List bytesImage = const Base64Decoder().convert(widget.data!);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Center(
        //child: isItPdf! ? displayPdf() : displayImage(),
        child: isItPdf!
            ? displayPdf()
            : isItImage!
                ? displayImage()
                : FutureBuilder(
                    future: displayDoc(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return const Text('Opening document');
                      }
                    },
                  ),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       isItPdf!
      //         ? displayPdf()
      //         : isItImage!
      //           displayImage()
      //           :
      //     ],
      //   ),
      // ),
    );
  }

  Widget displayImage() {
    Uint8List bytesImage = const Base64Decoder().convert(widget.data!);
    return Image.memory(bytesImage);
  }

  Widget displayPdf() {
    Uint8List bytesImage = const Base64Decoder().convert(widget.data!);
    return SfPdfViewer.memory(bytesImage);
  }

  Future<void> displayDoc() async {
    try {
      Uint8List bytesImage = const Base64Decoder().convert(widget.data!);
      String? mimeType = widget.mimeType;
      String fileType = extractFileType(mimeType);

      // Get the temporary directory of the app
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/tempfile.$fileType';

      // Save the file to the temp directory
      File file = File(filePath);
      await file.writeAsBytes(bytesImage);

      // Open the file with the system viewer
      final result = await OpenFile.open(filePath);

      // Debugging: print the result of OpenFile.open()
      print("OpenFile result: ${result.message}");

      if (result.type == ResultType.noAppToOpen) {
        print('No app found to open this file type');

        // Show a dialog to inform the user
        if (!mounted) return;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("No App Found"),
              content: const Text(
                  "You don't have an app installed that can open this file. Please install an appropriate app (e.g., Microsoft Word or Google Docs)."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else if (result.type == ResultType.fileNotFound) {
        print('file not found.');
      } else if (result.type == ResultType.done) {
        print('File opened successfully');
      } else {
        print('An unknown error occured: ${result.message}');
      }
    } catch (e) {
      print("Error opening document: $e");
    }
  }

  String extractFileType(String? mimeType) {
    if (mimeType != null) {
      List<String> parts = mimeType.split('/');
      if (parts.length > 1) {
        // Check for known document types in the second part of the MIME type
        if (parts[1].contains('wordprocessingml.document')) {
          return 'docx';
        } else if (parts[1].contains('spreadsheetml.sheet')) {
          return 'xlsx';
        } else if (parts[1].contains('presentationml.presentation')) {
          return 'pptx';
        }
      }
    }
    return 'unknown';
  }
}
