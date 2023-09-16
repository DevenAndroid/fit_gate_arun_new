import 'dart:convert';
import 'dart:io' as IO;
import 'package:fit_gate/global_functions.dart';
import 'package:fit_gate/utils/end_points.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  var imagePicker = ImagePicker();
  bool isCamera = true;
  String? imgUrl;
  // File? img;
  getProfileImage(context) async {
    var image = await imagePicker.pickImage(
        source: isCamera == true ? ImageSource.camera : ImageSource.gallery);
    if (image != null) {
      // var path = File(image.path);
      final byte = await IO.File(image.path).readAsBytes();
      var url = base64Encode(byte);
      String type = getFileExtension(image.path);
      imgUrl = await uploadPhotoApi(url, type);
      print("IMAGE URLLLLLLLLLLLL $imgUrl");
      update();
      return imgUrl;
    }
  }

  getFileExtension(String? fileName) {
    return ".${fileName?.split('.').last}";
  }

  uploadPhotoApi(url, type) async {
    loading(value: true);
    http.Response response = await http.post(
      Uri.parse(EndPoints.base64),
      body: jsonEncode({
        "extension": type,
        "avatar": url,
      }),
      headers: await header,
    );
    // var response = await DataBaseHelper.post(context, EndPoints.base64, {
    //   "extension": type,
    //   "avatar": url,
    // });
    loading(value: false);
    var parsedData = jsonDecode(response.body);
    if (parsedData['statusCode'] == 200) {
      var imgUrl = "${EndPoints.imgBaseUrl}${parsedData['data']}";
      // print("IMAGE URLLLLLLLLLLLL $imgUrl");
      update();
      return imgUrl;
    }
  }
}
