import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

File? image;
Future<void> getImageFromGallery() async {
  final ImagePicker picker = ImagePicker();
  try {
    image = (await picker.pickImage(source: ImageSource.gallery)) as File?;
    if (image != null) {
      // getFile( );
    }
  } catch (e) {
    // Handle errors or cancelations here.
    log('Error: $e');
  }
}

File? getFile() => image;
void openCamerWithFocus(myFile, filePath) async {
  PermissionStatus photos = await Permission.camera.request();
  if (photos != PermissionStatus.granted) {
    openAppSettings();
  }
  //HERE WE OPEN GALLERY OR CAMERA TO ADD IMAGE
  XFile? xFileCamera =
      await ImagePicker().pickImage(source: ImageSource.camera);
  myFile = File(xFileCamera!.path);
  filePath = myFile!.path;
}
