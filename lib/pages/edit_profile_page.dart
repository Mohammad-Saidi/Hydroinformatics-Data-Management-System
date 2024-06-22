import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../custom/button_widget.dart';
import '../custom/drawer.dart';

import 'dart:io';

import '../custom/profile_widget.dart';
import '../custom/textfield_widget.dart';
import '../models/user.dart';
import '../utils/user_preferences.dart';

// class EditProfilePage extends StatefulWidget {
//   const EditProfilePage({super.key});
//
//   static const String editProfilePage = 'editProfilePage';
//
//   @override
//   State<EditProfilePage> createState() => _EditProfilePageState();
// }
//
// class _EditProfilePageState extends State<EditProfilePage> {
//   File? imageFile;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0XFF64B5F6),
//       drawer: HomePageDrawer(),
//       appBar: AppBar(
//         backgroundColor: Colors.blue,
//         title: Text(
//           'Edit Profile Page',
//           style: GoogleFonts.poppins(
//               fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             imageFile == null
//                 ? Image.asset(
//               'images/profile.png',
//               height: 300.0,
//               width: 300.0,
//             )
//                 : ClipRRect(
//               borderRadius: BorderRadius.circular(150.0),
//               child: Image.file(
//                 imageFile!,
//                 height: 300.0,
//                 width: 300.0,
//                 fit: BoxFit.fill,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 Map<Permission, PermissionStatus> statuses = await [
//                   Permission.storage,
//                   Permission.camera,
//                 ].request();
//
//                 if (statuses[Permission.storage]!.isGranted &&
//                     statuses[Permission.camera]!.isGranted) {
//                   showImagePicker(context);
//                 } else {
//                   print('no permisson provided');
//                 }
//               },
//               child: const Text('Select Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   final picker = ImagePicker();
//
//   void showImagePicker(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (builder) {
//         return Card(
//           child: Container(
//             width: MediaQuery
//                 .of(context)
//                 .size
//                 .width,
//             height: MediaQuery
//                 .of(context)
//                 .size
//                 .height / 5.2,
//             margin: const EdgeInsets.only(top: 8.0),
//             padding: const EdgeInsets.all(12),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: InkWell(
//                     child: const Column(
//                       children: [
//                         Icon(
//                           Icons.image,
//                           size: 60.0,
//                         ),
//                         SizedBox(
//                           height: 12.0,
//                         ),
//                         Text(
//                           'Gallery',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 16, color: Colors.black),
//                         )
//                       ],
//                     ),
//                     onTap: () {
//                       _imgFromGallery();
//                       Navigator.of(context);
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: InkWell(
//                     child: const Column(
//                       children: [
//                         Icon(
//                           Icons.image,
//                           size: 60.0,
//                         ),
//                         SizedBox(
//                           height: 12.0,
//                         ),
//                         Text(
//                           'Gallery',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(fontSize: 16, color: Colors.black),
//                         )
//                       ],
//                     ),
//                     onTap: () {
//                       _imgFromCamera();
//                       Navigator.of(context);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   void _imgFromGallery() async {
//     await picker
//         .pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 50,
//     )
//         .then((value) {
//       if (value != null) {
//         _cropImage(File(value.path));
//       }
//     });
//   }
//
//   void _imgFromCamera() async {
//     await picker.pickImage(
//         source: ImageSource.camera, imageQuality: 50
//     ).then((value) {
//       if (value != null) {
//         _cropImage(File(value.path));
//       }
//     });
//   }
//
//   _cropImage(File imgFile) async {
//     final croppedFile = await ImageCropper().cropImage(
//         sourcePath: imgFile.path,
//         aspectRatioPresets: Platform.isAndroid
//             ? [
//           CropAspectRatioPreset.square,
//           CropAspectRatioPreset.ratio3x2,
//           CropAspectRatioPreset.original,
//           CropAspectRatioPreset.ratio4x3,
//           CropAspectRatioPreset.ratio16x9
//         ] : [
//           CropAspectRatioPreset.original,
//           CropAspectRatioPreset.square,
//           CropAspectRatioPreset.ratio3x2,
//           CropAspectRatioPreset.ratio4x3,
//           CropAspectRatioPreset.ratio5x3,
//           CropAspectRatioPreset.ratio5x4,
//           CropAspectRatioPreset.ratio7x5,
//           CropAspectRatioPreset.ratio16x9
//         ],
//         uiSettings: [AndroidUiSettings(
//             toolbarTitle: "Image Cropper",
//             toolbarColor: Colors.deepOrange,
//             toolbarWidgetColor: Colors.white,
//             initAspectRatio: CropAspectRatioPreset.original,
//             lockAspectRatio: false),
//           IOSUiSettings(
//             title: "Image Cropper",
//           )
//         ]);
//     if (croppedFile != null) {
//
//       imageCache.clear();
//       setState(() {
//         imageFile = File(croppedFile.path);
//       });
//       // reload();
//     }
//   }
//
// }


class EditProfilePage extends StatefulWidget {
  static const String editProfilePage = 'editProfilePage';
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late User user;

  @override
  void initState() {
    super.initState();

    user = UserPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Edit Profile Page'),
    ),
    body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 32),
      physics: BouncingScrollPhysics(),
      children: [
        ProfileWidget(
          imagePath: user.imagePath,
          isEdit: true,
          onClicked: () async {
            final image = await ImagePicker()
                .pickImage(source: ImageSource.gallery);

            if (image == null) return;

            final directory = await getApplicationDocumentsDirectory();
            final name = basename(image.path);
            final imageFile = File('${directory.path}/$name');
            final newImage =
            await File(image.path).copy(imageFile.path);

            setState(() => user = user.copy(imagePath: newImage.path));
          },
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          hintText: 'Enter your full name',
          label: 'Full Name',
          text: '',
          onChanged: (name) => user = user.copy(name: name),
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          hintText: 'Enter your email',
          label: 'Email',
          text: '',
          onChanged: (email) => user = user.copy(email: email),
        ),
        const SizedBox(height: 24),
        TextFieldWidget(
          hintText: 'Enter about yourself',
          label: 'About',
          text: '',
          maxLines: 5,
          onChanged: (about) => user = user.copy(about: about),
        ),
        const SizedBox(height: 24),
        ButtonWidget(
          text: 'Save',
          onClicked: () {
            UserPreferences.setUser(user);
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
  );
}


