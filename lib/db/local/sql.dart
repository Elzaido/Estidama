import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http; //dont forget to give it a name
import 'dart:convert'; //converts json to normal and opposite
import 'package:path/path.dart'; //this is for image uploading

String _basicAuth = 'Basic ' + base64Encode(utf8.encode('zamel_db:estidama12'));
//THIS IS THE PATHWAY FOR API
Map<String, String> myheaders = {'authorization': _basicAuth};
postRequest(String url, Map data) async {
  //async refers to internet waiting request
  try {
    var response =
        await http.post(Uri.parse(url), body: data, headers: myheaders);
    if (response.statusCode == 200) {
      //404 error
      var response_body = jsonDecode(response.body);
      return response_body;
    } else {
      log("Error caused by: ${response.statusCode}");
      return;
    }
  } catch (e) {
    log("Error caused by: ${e}");
    return;
  }
}

getRequest(String url) async {
  //async refers to internet waiting request
  try {
    var response = await http.get(Uri.parse(url), headers: myheaders);
    if (response.statusCode == 200) {
      //404 error
      var response_body = jsonDecode(response.body);
      return response_body;
    } else {
      log("Error caused by: ${response.statusCode}");
    }
  } catch (e) {
    log("Error caused by: ${e}");
  }
}

//this function is only used for files uploading
postRequestWithFile(String url, File? file, Map data) async {
  //make sure its dart io not html
  var request = http.MultipartRequest("POST", Uri.parse(url));
  var length = await file!.length();
  var stream = http.ByteStream(file.openRead());
  var multipartFile = http.MultipartFile("complain_image_path", stream, length,
      filename: basename(file.path) //to use basename  u shall import path lib
      ); //request from php make sure the request name file is same as in php
  request.headers.addAll(myheaders);

  request.files.add(multipartFile);
  // request.fields['title'] = data['title'];
  data.forEach((key, value) {
    //we use for each to make it dynamic
    request.fields[key] = value;
  });
  var myrequest = await request.send();
  var response = await http.Response.fromStream(myrequest);

  if (myrequest.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    log("error${myrequest.statusCode}");
  }
}
// }
