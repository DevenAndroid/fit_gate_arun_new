import 'dart:convert';

import 'package:http/http.dart' as http;
import '../global_functions.dart';
import '../models/profile_details_model.dart';


Future<ProfileModel> profileDetailsRepo({required id}) async {

  var apiUrl = "https://admin.fitgate.live/api/user-profile";
  http.Response response =
  await http.get(Uri.parse("${apiUrl}?user_id=$id"), headers: await header,);

  if (response.statusCode == 200) {
    print("<<<<<<<Profile details repo repository=======>${response.body}");
    return ProfileModel.fromJson(json.decode(response.body));
  } else {
    throw Exception(response.body);
  }
}