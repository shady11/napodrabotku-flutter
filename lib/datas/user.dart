import 'dart:convert';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'package:ishapp/constants/configs.dart';
import 'package:ishapp/datas/pref_manager.dart';
import 'package:path_provider/path_provider.dart';

class User {
  int id;
  String token;
  String username;
  String password;
  String name;
  String surname;
  String image;
  String email;
  String linked_link;
  String phone_number;
  bool is_company;
  final String userFullname;
  final String userPhotoLink;
  final String userSchool;
  final String jobTitle;
  final String userDistance;
  List<UserEducation> user_educations;
  List<UserExperience> user_experiences;


  User(
      {this.id,
      this.token,
      this.username,
      this.password,
      this.name,
      this.surname,
      this.image,
      this.email,
      this.linked_link,
      this.phone_number,
      this.is_company,
      this.userFullname,
      this.userPhotoLink,
      this.userSchool,
      this.jobTitle,
      this.userDistance,
      this.user_educations,
      this.user_experiences});

  factory User.fromJson(Map<String, dynamic> json) => new User(
    id: json["id"],
    username: json["name"],
    name: json["description"],
    surname: json["address"],
    image: json['salary'],
    email: json['company'],
    linked_link: json['company_name'],
    phone_number: json['busyness'],
    is_company: json['schedule'],
  );

  void uploadImage1(_image) async {

    // string to uri
    var uri = Uri.parse(API_IP+API_REGISTER);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // if you need more parameters to parse, add those like this. i added "user_id". here this "user_id" is a key of the API request
    request.fields["login"] = this.username;
    request.fields["password"] = this.password;
    request.fields["name"] = this.name;
    request.fields["lastname"] = this.surname;
    request.fields["email"] = this.email;
    request.fields["linked_link"] = this.linked_link;
    request.fields["active"] = '1';
    request.fields["phone_number"] = this.phone_number;
    request.fields["type"] = this.is_company?'COMPANY':'USER';

    // open a byteStream
    if(_image != null) {
      var stream = new http.ByteStream(
          DelegatingStream.typed(_image.openRead()));
      // get file length
      var length = await _image.length();
      // multipart that takes file.. here this "image_file" is a key of the API request
      var multipartFile = new http.MultipartFile('avatar', stream, length, filename: basename(_image.path));
      // add file to multipart
      request.files.add(multipartFile);

    }


    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        var response = json.decode(value);
        Prefs.setString('username', username);
        Prefs.setString('password', password);
        Prefs.setString(Prefs.USERNAME, username);
        Prefs.setString(Prefs.PASSWORD, password);
        Prefs.setString(Prefs.TOKEN, response["token"]);
        Prefs.setString(Prefs.PROFILEIMAGE, response["avatar"]);
      });

    }).catchError((e) {
      print(e);
    });
  }

  Future<void> register() async {
    final url =
        API_IP+API_REGISTER;
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers:headers,
        body: json.encode(
            userRequestBodyToJson(this)
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 999) {
        throw HttpException(responseData['status'].toString());
      }
      else if (responseData['status'] == 888) {
        throw HttpException(responseData['status'].toString());
      }
      else if(responseData['token'] != null) {
        this.token = responseData['token'];
        this.id = responseData['id'];
      }
    }
    catch (error) {
      throw error;
    }
  }

  static Map<String, dynamic> userRequestBodyToJson(User user) =>
      {
        'username': user.username,
        'password': user.password,
        'name': user.name,
        'surname': user.surname,
        'email': user.email,
        'linked_link': user.linked_link,
        'phone_number': user.phone_number,
      };

  bool get isAuth {
    return token != null;
  }

  Future<void> _authenticate(
      String username, String password) async {
    final url =
        API_IP+API_LOGIN;
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers:headers,
        body: json.encode(
            loginRequestBodyToJson(username, password)
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 999) {
        throw HttpException(responseData['status'].toString());
      }
      else if (responseData['status'] == 888) {
        throw HttpException(responseData['status'].toString());
      }
      else if(responseData['token'] != null) {
        this.username = username;
        this.password = password;
        Prefs.setString('username', username);
        Prefs.setString('password', password);
        Prefs.setString(Prefs.USERNAME, username);
        Prefs.setString(Prefs.PASSWORD, password);
        Prefs.setString(Prefs.TOKEN, responseData["token"]);
        Prefs.setString(Prefs.PROFILEIMAGE, responseData["avatar"]);
      }
    }
    catch (error) {
      throw error;
    }
  }

  static Map<String, dynamic> loginRequestBodyToJson(String username, String password) =>
      {
        'username': username,
        'password': password,
      };

  Future<bool> checkUsername(String username) async {
    final url =
        API_IP+'api/userexist';
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers:headers,
        body: json.encode(
            {
              'username': username,
            }
        ),
      );
      return json.decode(response.body);
    }
    catch (error) {
      throw error;
    }
  }


  Future<void> login(String email, String password) async {
    return _authenticate(email, password);
  }

  Future<void> setPassword(String password) async {
    final url =
        API_IP+'api/change-password/'+ Prefs.getInt(Prefs.USER_ID).toString();
    try {
      Map<String, String> headers = {"Content-type": "application/json","token": Prefs.getString(Prefs.TOKEN)};
      final response = await http.put(
        url,
        headers:headers,
        body: json.encode(
            {"new_password": password}),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 999) {
        throw HttpException(responseData['status'].toString());
      }
      else if (responseData['status'] == 888) {
        throw HttpException(responseData['status'].toString());
      }
      else if(responseData['token'] != null) {
        Prefs.setString(Prefs.PASSWORD, password);
        Prefs.setInt(Prefs.USER_ID, responseData['id']);
        Prefs.setString(Prefs.TOKEN, responseData['token']);
        this.password = password;
      }
    }
    catch (error) {
      throw error;
    }
  }

  Future<void> resetPassword(User user, String new_password) async {
    final url =
        API_IP+'api/resetpassword/';
    try {
      Map<String, String> headers = {"Content-type": "application/json","token": Prefs.getString(Prefs.TOKEN)};
      final response = await http.post(
        url,
        headers:headers,
        body: json.encode(
            {
              "username": user.username,
              "old_password": user.password,
              "new_password": new_password,
            }),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 999) {
        throw HttpException(responseData['status'].toString());
      }
      else if (responseData['status'] == 888) {
        throw HttpException(responseData['status'].toString());
      }
      else if(responseData['token'] != null) {
        Prefs.setString(Prefs.TOKEN, responseData['token']);
        Prefs.setInt(Prefs.USER_ID, responseData['id']);
      }
    }
    catch (error) {
      throw error;
    }
  }

  void logout() async{
    var userId=0;
    userId = Prefs.getInt(Prefs.USER_ID);
    final url =
        API_IP+'api/logged';
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers:headers,
        body: json.encode(
            {"id": userId}),
      );
      final responseData = json.decode(response.body);
      if(responseData == "successfully") {
      }
    }
    catch (error) {
      throw error;
    }
  }
}

class UserState {
  UserDetailState user;

  UserState({
    this.user,
  });

  factory UserState.initial() => UserState(
    user: UserDetailState.initial(),
  );
}

class UserDetailState {
  dynamic error;
  bool loading;
  User data;

  UserDetailState({
    this.error,
    this.loading,
    this.data,
  });

  factory UserDetailState.initial() => UserDetailState(
    error: null,
    loading: false,
    data: new User(),
  );
}

class UserEducation{
  int id;
  EducationType education_type;
  String place;
  DateTime start;
  DateTime end;
  String title;
}

class EducationType{
  int id;
  String name;
}

class UserExperience{
  int id;
  String company_name;
  DateTime start;
  DateTime end;
  String job;
}
