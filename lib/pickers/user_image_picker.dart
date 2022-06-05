import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  late XFile _imageFileList;
  final ImagePicker _picker = ImagePicker();
  var _image;
  void _pickImage() async {
    XFile? pickedImageFile =
        await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedImageFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _image != null
            ? Image.file(
                _image,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.fitHeight,
              )
            :
            // CircleAvatar(
            //   radius: 40,
            //   backgroundColor: Colors.grey,
            //   backgroundImage:
            //       _image != null ? XFileImage(_imageFileList) : null,
            // ),
            FlatButton.icon(
                textColor: Theme.of(context).primaryColor,
                onPressed: _pickImage,
                icon: Icon(Icons.image),
                label: Text('Add Image'),
              ),
      ],
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