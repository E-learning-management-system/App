import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:image/image.dart' as img;
class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  late File _pickedImage;

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

//convert XFile to File
    final File? imagefile = File(image!.path);

    setState(() {
      _pickedImage = imagefile!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        child: new Material(
          child: new InkWell(
            onTap: _pickImage,
            child: new Container(
              width: 75.0,
              height: 75.0,
              child: InkWell(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 40,
                  backgroundImage:
                      _pickedImage != null ? FileImage(_pickedImage) : null,
                  // child: SizedBox(
                  //   width: 60,
                  //   height: 60,
                  //   child: ClipOval(
                  //     child: Image.asset(
                  //       "assets/images/ic_profile.png",
                  //     ),
                  //   ),
                  // ),
                ),
              ),
            ),
          ),
          color: Colors.transparent,
        ),
      ),
    );
  }
}














// class ImageFromGalleryEx extends StatefulWidget {
//   final type;
//   ImageFromGalleryEx(this.type);

//   @override
//   ImageFromGalleryExState createState() => ImageFromGalleryExState(this.type);
// }

// class ImageFromGalleryExState extends State<ImageFromGalleryEx> {
//   var _image;
//   var imagePicker;
//   var type;

//   ImageFromGalleryExState(this.type);

//   @override
//   void initState() {
//     super.initState();
//     imagePicker = new ImagePicker();
//   }




// class ImageFromGalleryEx extends StatefulWidget {
//   final type;
//   ImageFromGalleryEx(this.type);

//   @override
//   ImageFromGalleryExState createState() => ImageFromGalleryExState(this.type);
// }

// class ImageFromGalleryExState extends State<ImageFromGalleryEx> {
//   var _image;
//   var imagePicker;
//   var type;

//   ImageFromGalleryExState(this.type);

//   @override
//   void initState() {
//     super.initState();
//     imagePicker = new ImagePicker();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text(type == ImageSourceType.camera
//               ? "Image from Camera"
//               : "Image from Gallery")),
//       body: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 52,
//           ),
//           Center(
//             child: GestureDetector(
//               onTap: () async {
//                 var source = type == ImageSourceType.camera
//                     ? ImageSource.camera
//                     : ImageSource.gallery;
//                 XFile image = await imagePicker.pickImage(
//                     source: source, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
//                 setState(() {
//                   _image = File(image.path);
//                 });
//               },
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                     color: Colors.red[200]),
//                 child: _image != null
//                     ? Image.file(
//                           _image,
//                           width: 200.0,
//                           height: 200.0,
//                           fit: BoxFit.fitHeight,
//                         )
//                     : Container(
//                         decoration: BoxDecoration(
//                             color: Colors.red[200]),
//                         width: 200,
//                         height: 200,
//                         child: Icon(
//                           Icons.camera_alt,
//                           color: Colors.grey[800],
//                         ),
//                       ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }