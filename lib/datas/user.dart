import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:intl/intl.dart';

import 'package:ishapp/constants/configs.dart';
import 'package:ishapp/datas/pref_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:ishapp/datas/app_state.dart';

import 'RSAA.dart';

class User {
  int id;
  String token;
  String password;
  String name;
  String surname;
  String image;
  String email;
  DateTime birth_date;
  String phone_number;
  String user_cv_name;
  String vacancy_name;
  String experience_year;
  bool is_company;

  User(
      {this.id,
      this.token,
      this.password,
      this.name,
      this.surname,
      this.image,
      this.email,
      this.birth_date,
      this.phone_number,
      this.user_cv_name,
      this.experience_year,
      this.vacancy_name,
      this.is_company});

  factory User.fromJson(Map<String, dynamic> json) => new User(
        id: json["id"],
        name: json["name"],
        surname: json["lastname"],
        image: json['avatar'],
        email: json['email'],
        birth_date: DateTime.parse(json['birth_date']),
        phone_number: json['phone_number'],
        vacancy_name: json['vacancy_name'],
        user_cv_name: json['job_title'],
        experience_year: json['experience_year'].toString(),
        is_company: json['type'] == 'COMPANY',
      );

  String uploadImage1(_image){
    // string to uri
    var uri = Uri.parse(API_IP + API_REGISTER1);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    // if you need more parameters to parse, add those like this. i added "user_id". here this "user_id" is a key of the API request
    request.fields["id"] = this.id.toString();
    request.fields["password"] = this.password;
    request.fields["name"] = this.name;
    request.fields["lastname"] = this.surname;
    request.fields["email"] = this.email;
    request.fields["birth_date"] = formatter.format(this.birth_date);
    request.fields["active"] = '1';
    request.fields["phone_number"] = this.phone_number;
    request.fields["type"] = this.is_company ? 'COMPANY' : 'USER';

    // open a byteStream
    if (_image != null) {
      var stream =
          new http.ByteStream(DelegatingStream.typed(_image.openRead()));
      // get file length
      var length = _image.length();
      // multipart that takes file.. here this "image_file" is a key of the API request
      var multipartFile = new http.MultipartFile('avatar', stream, length,
          filename: basename(_image.path));
      // add file to multipart
      request.files.add(multipartFile);
    }

    // send request to upload image
    var mm;
    request.send().then((response) {
      // listen for response
      print(response);
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        var response = json.decode(value);
        if(response['status'] == 200){
          Prefs.setString(Prefs.PASSWORD, password);
          Prefs.setString(Prefs.TOKEN, response["token"]);
          Prefs.setInt(Prefs.USER_ID, response["id"]);
          Prefs.setString(Prefs.PROFILEIMAGE, response["avatar"]);
          Prefs.setString(Prefs.USER_TYPE, response["user_type"]);
          mm="OK";
//          return "OK";
        }
        else{
          mm="ERROR";
//          return "ERROR";
        }
      });
    }).catchError((e) {
      print(e);
    });
    return mm;
  }
  void uploadImage2(_image) async {
    // string to uri
    var uri = Uri.parse(API_IP + API_REGISTER+'/${this.id.toString()}');

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    // if you need more parameters to parse, add those like this. i added "user_id". here this "user_id" is a key of the API request
    request.fields["id"] = this.id.toString();
    request.fields["name"] = this.name;
    request.fields["lastname"] = this.surname;
    request.fields["email"] = this.email;
    request.fields["birth_date"] = formatter.format(this.birth_date);
    request.fields["phone_number"] = this.phone_number;

    // open a byteStream
    if (_image != null) {
      var stream =
      new http.ByteStream(DelegatingStream.typed(_image.openRead()));
      // get file length
      var length = await _image.length();
      // multipart that takes file.. here this "image_file" is a key of the API request
      var multipartFile = new http.MultipartFile('avatar', stream, length,
          filename: basename(_image.path));
      // add file to multipart
      request.files.add(multipartFile);
    }

    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        var response = json.decode(value);
//        Prefs.setString('username', username);
//        Prefs.setString('password', password);
//        Prefs.setString(Prefs.USERNAME, username);
//        Prefs.setString(Prefs.PASSWORD, password);
//        Prefs.setString(Prefs.TOKEN, response["token"]);
        Prefs.setString(Prefs.PROFILEIMAGE, response["avatar"]);
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> register() async {
    final url = API_IP + API_REGISTER;
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(userRequestBodyToJson(this)),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 999) {
        throw HttpException(responseData['status'].toString());
      } else if (responseData['status'] == 888) {
        throw HttpException(responseData['status'].toString());
      } else if (responseData['token'] != null) {
        this.token = responseData['token'];
        this.id = responseData['id'];
      }
    } catch (error) {
      throw error;
    }
  }

  static Map<String, dynamic> userRequestBodyToJson(User user) => {
        'password': user.password,
        'name': user.name,
        'surname': user.surname,
        'email': user.email,
        'birth_date': user.birth_date,
        'phone_number': user.phone_number,
      };

  bool get isAuth {
    return token != null;
  }

  Future<String> _authenticate(String email, String password) async {
    final url = API_IP + API_LOGIN;
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode(loginRequestBodyToJson(email, password)),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 999) {
        return "ERROR";
        throw HttpException(responseData['status'].toString());
      } else if (responseData['status'] == 888) {
        throw HttpException(responseData['status'].toString());
      } else if (responseData['token'] != null) {
        this.password = password;
        Prefs.setString('password', password);
        Prefs.setString(Prefs.EMAIL, email);
        Prefs.setString(Prefs.PASSWORD, password);
        Prefs.setInt(Prefs.USER_ID, responseData["id"]);
        Prefs.setString(Prefs.TOKEN, responseData["token"]);
        Prefs.setString(Prefs.PROFILEIMAGE, responseData["avatar"]);
        Prefs.setString(Prefs.USER_TYPE, responseData["user_type"]);
        return "OK";
      }
    } catch (error) {
      throw error;
    }
  }

  static Map<String, dynamic> loginRequestBodyToJson(
          String email, String password) =>
      {
        'email': email,
        'password': password,
      };

  static Future<bool> checkUsername(String email) async {
    final url = API_IP + API_CHECK_USER_EMAIL;
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({
          'email': email,
        }),
      );
      return json.decode(response.body);
    } catch (error) {
      throw error;
    }
  }

  static Future<bool> checkUserCv(int user_id) async {
    final url = API_IP + API_CHECK_USER_CV;
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({
          'user_id': user_id.toString(),
        }),
      );
      return json.decode(response.body);
    } catch (error) {
      throw error;
    }
  }

  static Future<String> sendMailOnForgotPassword(String email) async {
    final url = API_IP + API_FORGOT_PASSWORD;
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({
          'email': email,
          'language': Prefs.getString(Prefs.LANGUAGE),
        }),
      );
      return response.body;
    } catch (error) {
      throw error;
    }
  }

  static Future<String> validateUserCode({String email, String code}) async {
    final url = API_IP + API_VALIDATE_CODE;
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({
          'email': email,
          'code': code,
        }),
      );
      var body = json.decode(response.body);
      if(body == 'user code does not exist')
        return "ERROR";
      Prefs.setString(Prefs.EMAIL, email);
      Prefs.setString(Prefs.USER_ID, body["id"].toString());
      Prefs.setString(Prefs.PROFILEIMAGE, body["avatar"]);

      return "OK";
    } catch (error) {
      throw error;
    }
  }

  static Future<String> resetPassword({String email, String new_password}) async {
    final url = API_IP + API_RESET_PASSWORD;
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({
          'email': email,
          'new_password': new_password,
        }),
      );
      var body = json.decode(response.body);
      Prefs.setString(Prefs.TOKEN, body['token']);

      return "OK";
    } catch (error) {
      throw error;
    }
  }

  static Future<String> getCompanyLogo({int vacancy_id}) async {
    final url = API_IP + API_GET_COMPANY_AVATAR;
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({
          'vacancy_id': vacancy_id,
        }),
      );

      return response.body;
    } catch (error) {
      throw error;
    }
  }

  Future<String> login(String email, String password) async {
    return _authenticate(email, password);
  }

  Future<void> setPassword(String password) async {
    final url = API_IP +
        'api/change-password/' +
        Prefs.getInt(Prefs.USER_ID).toString();
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        "token": Prefs.getString(Prefs.TOKEN)
      };
      final response = await http.put(
        url,
        headers: headers,
        body: json.encode({"new_password": password}),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 999) {
        throw HttpException(responseData['status'].toString());
      } else if (responseData['status'] == 888) {
        throw HttpException(responseData['status'].toString());
      } else if (responseData['token'] != null) {
        Prefs.setString(Prefs.PASSWORD, password);
        Prefs.setInt(Prefs.USER_ID, responseData['id']);
        Prefs.setString(Prefs.TOKEN, responseData['token']);
        this.password = password;
      }
    } catch (error) {
      throw error;
    }
  }

  /*Future<void> resetPassword(User user, String new_password) async {
    final url = API_IP + 'api/resetpassword/';
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        "token": Prefs.getString(Prefs.TOKEN)
      };
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({
          "email": user.email,
          "old_password": user.password,
          "new_password": new_password,
        }),
      );
      final responseData = json.decode(response.body);
      if (responseData['status'] == 999) {
        throw HttpException(responseData['status'].toString());
      } else if (responseData['status'] == 888) {
        throw HttpException(responseData['status'].toString());
      } else if (responseData['token'] != null) {
        Prefs.setString(Prefs.TOKEN, responseData['token']);
        Prefs.setInt(Prefs.USER_ID, responseData['id']);
      }
    } catch (error) {
      throw error;
    }
  }*/

  void logout() async {
    var userId = 0;
    userId = Prefs.getInt(Prefs.USER_ID);
    final url = API_IP + 'api/logged';
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
        url,
        headers: headers,
        body: json.encode({"id": userId}),
      );
      final responseData = json.decode(response.body);
      if (responseData == "successfully") {}
    } catch (error) {
      throw error;
    }
  }
}

class UserState {
  UserDetailState user;
  ListUserDetailState submitted_user_list;
  UserCvState user_cv;
  UserFullInfoState user_full_info;


  UserState({
    this.user,
    this.user_cv,
    this.submitted_user_list,
    this.user_full_info
  });

  factory UserState.initial() => UserState(
        user: UserDetailState.initial(),
        user_cv: UserCvState.initial(),
        submitted_user_list: ListUserDetailState.initial(),
        user_full_info: UserFullInfoState.initial(),
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

class ListUserDetailState {
  dynamic error;
  bool loading;
  List<User> data;

  ListUserDetailState({
    this.error,
    this.loading,
    this.data,
  });

  factory ListUserDetailState.initial() => ListUserDetailState(
    error: null,
    loading: false,
    data: [],
  );
}

class UserCvState {
  dynamic error;
  bool loading;
  UserCv data;

  UserCvState({
    this.error,
    this.loading,
    this.data,
  });

  factory UserCvState.initial() => UserCvState(
        error: null,
        loading: false,
        data: new UserCv(),
      );
}

class UserFullInfoState {
  dynamic error;
  bool loading;
  UserFullInfo data;

  UserFullInfoState({
    this.error,
    this.loading,
    this.data,
  });

  factory UserFullInfoState.initial() => UserFullInfoState(
    error: null,
    loading: false,
    data: new UserFullInfo(),
  );
}

class EducationType {
  int id;
  String name;
}

class UserCv {
  int id;
  int experience_year;
  String job_title;
  List<UserExperience> user_experiences;
  List<UserEducation> user_educations;
  List<UserCourse> user_courses;

  UserCv(
      {this.id,
      this.experience_year,
      this.job_title,
      this.user_experiences,
      this.user_educations,
      this.user_courses});

  factory UserCv.fromJson(Map<String, dynamic> json) => new UserCv(
        id: json["id"],
        job_title: json["job_title"],
        experience_year: json["experience_year"],
        user_courses: coursesToList(json['courses']),
        user_educations: educationsToList(json['educations']),
        user_experiences: experiencesToList(json['experiences']),
      );

  void save() async {
    // string to uri
    var uri = Uri.parse(API_IP + API_USER_CV_SAVE);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = Prefs.getString(Prefs.TOKEN);

    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    request.fields["user_id"] = Prefs.getInt(Prefs.USER_ID);
    request.fields["user_cv_id"] = this.id.toString();
    request.fields["experience_year"] = this.experience_year.toString();
    request.fields["job_title"] = this.job_title;
//    request.fields["user_experiences"] = json.encode(this.user_experiences);
//    request.fields["user_educations"] = json.encode(this.user_educations);
//    request.fields["user_courses"] = json.encode(this.user_courses);

    // open a byteStream
//    if (_image != null) {
//      var stream =
//      new http.ByteStream(DelegatingStream.typed(_image.openRead()));
//      // get file length
//      var length = await _image.length();
//      // multipart that takes file.. here this "image_file" is a key of the API request
//      var multipartFile = new http.MultipartFile('file', stream, length,
//          filename: basename(_image.path));
//      // add file to multipart
//      request.files.add(multipartFile);
//    }

    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        return value;
//        Prefs.setString('username', username);
//        Prefs.setString('password', password);
//        Prefs.setString(Prefs.USERNAME, username);
//        Prefs.setString(Prefs.PASSWORD, password);
//        Prefs.setString(Prefs.TOKEN, response["token"]);
//        Prefs.setString(Prefs.PROFILEIMAGE, response["avatar"]);
      });
    }).catchError((e) {
      print(e);
    });
  }

  static List<UserExperience> experiencesToList(var j) {
    List<UserExperience> result = new List<UserExperience>();
    for (var i in j) {
      result.add(new UserExperience(
        id: i['id'],
        job_title: i['job_title'],
        start_date: DateTime.parse(i['start_date']),
        end_date: DateTime.parse(i['end_date']),
        organization_name: i['organization_name'],
        description: i['description'],
      ));
    }
    return result;
  }

  static List<UserEducation> educationsToList(var j) {
    List<UserEducation> result = new List<UserEducation>();
    for (var i in j) {
      result.add(new UserEducation(
        id: i['id'],
        type: i['type'],
        title: i['title'],
        faculty: i['faculty'],
        speciality: i['speciality'],
        end_year: i['end_year'].toString(),
      ));
    }
    return result;
  }

  static List<UserCourse> coursesToList(var j) {
    if(j ==null)
      return null;
    List<UserCourse> result = [];
    print(j);
    for (var i in j) {
      result.add(new UserCourse(
        id: i['id'],
        name: i['name'],
        organization_name: i['organization_name'],
        duration: i['duration'],
        end_year: i['end_year'].toString(),
      ));
    }
    return result;
  }
}

class UserFullInfo {
  int id;
  int experience_year;
  String job_title;
  String surname_name;
  String avatar;
  String email;
  String attachment;
  DateTime birth_date;
  String phone_number;
  List<UserExperience> user_experiences;
  List<UserEducation> user_educations;
  List<UserCourse> user_courses;

  UserFullInfo(
      {this.id,
        this.experience_year,
        this.job_title,
        this.surname_name,
        this.avatar,
        this.email,
        this.birth_date,
        this.phone_number,
        this.attachment,
        this.user_experiences,
        this.user_educations,
        this.user_courses});

  factory UserFullInfo.fromJson(Map<String, dynamic> json) => new UserFullInfo(
    id: json["id"],
    job_title: json["job_title"],
    surname_name: json["surname_name"],
    avatar: json["avatar"],
    email: json["email"],
    birth_date: DateTime.parse(json['birth_date']),
    phone_number: json["phone_number"],
    attachment: json["attachment"],
    experience_year: json["experience_year"],
    user_courses: coursesToList(json['courses']),
    user_educations: educationsToList(json['educations']),
    user_experiences: experiencesToList(json['experiences']),
  );

  static List<UserExperience> experiencesToList(var j) {
    List<UserExperience> result = new List<UserExperience>();
    for (var i in j) {
      result.add(new UserExperience(
        id: i['id'],
        job_title: i['job_title'],
        start_date: DateTime.parse(i['start_date']),
        end_date: DateTime.parse(i['end_date']),
        organization_name: i['organization_name'],
        description: i['description'],
      ));
    }
    return result;
  }

  static List<UserEducation> educationsToList(var j) {
    List<UserEducation> result = new List<UserEducation>();
    for (var i in j) {
      result.add(new UserEducation(
        id: i['id'],
        type: i['type'],
        title: i['title'],
        faculty: i['faculty'],
        speciality: i['speciality'],
        end_year: i['end_year'].toString(),
      ));
    }
    return result;
  }

  static List<UserCourse> coursesToList(var j) {
    if(j ==null)
      return null;
    List<UserCourse> result = [];
    print(j);
    for (var i in j) {
      result.add(new UserCourse(
        id: i['id'],
        name: i['name'],
        organization_name: i['organization_name'],
        duration: i['duration'],
        end_year: i['end_year'].toString(),
      ));
    }
    return result;
  }
}

class UserExperience {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  int id;
  String job_title;
  DateTime start_date;
  DateTime end_date;
  String organization_name;
  String description;

  UserExperience(
      {this.id,
      this.job_title,
      this.start_date,
      this.end_date,
      this.organization_name,
      this.description});

  Map toJson() => {
    'id': id.toString(),
    'job_title': job_title.toString(),
    'start_date': formatter.format(start_date).toString(),
    'end_date': formatter.format(end_date).toString(),
    'organization_name': organization_name.toString(),
    'description': description.toString(),
  };

  Future<void> save(id) async {
    // string to uri
    var uri = Uri.parse(API_IP + API_USER_CV_EXPERIENCE_SAVE);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = Prefs.getString(Prefs.TOKEN);

    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    request.fields["user_id"] = "11";
    request.fields["user_cv_id"] = id.toString();
    request.fields["job_title"] = this.job_title.toString();
    request.fields["start_date"] = formatter.format(start_date).toString();
    request.fields["end_date"] = formatter.format(end_date).toString();
    request.fields["organization_name"] = this.organization_name.toString();
    request.fields["description"] = this.description.toString();

    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        var response = json.decode(value);
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> update(id) async {
    // string to uri
    var uri = Uri.parse(API_IP + API_USER_CV_EXPERIENCE_UPDATE + id.toString());

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = Prefs.getString(Prefs.TOKEN);

    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    request.fields["id"] = id.toString();
    request.fields["job_title"] = this.job_title.toString();
    request.fields["start_date"] = formatter.format(start_date).toString();
    request.fields["end_date"] = formatter.format(end_date).toString();
    request.fields["organization_name"] = this.organization_name.toString();
    request.fields["description"] = this.description.toString();

    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        var response = json.decode(value);
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> delete(id) async {
    // string to uri
    var uri = Uri.parse(API_IP + API_USER_CV_EXPERIENCE_DELETE + id.toString());

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = Prefs.getString(Prefs.TOKEN);

    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        var response = json.decode(value);
      });
    }).catchError((e) {
      print(e);
    });
  }
}

class UserEducation {
  int id;
  String type;
  String title;
  String faculty;
  String speciality;
  String end_year;

  UserEducation(
      {this.id,
      this.type,
      this.title,
      this.faculty,
      this.speciality,
      this.end_year});

  Map toJson() => {
    'id': id,
    'type': type,
    'title': title,
    'faculty': faculty,
    'speciality': speciality,
    'end_year': end_year,
  };

  Future<String> save(id) async {
    // string to uri
    var uri = Uri.parse(API_IP + API_USER_CV_EDUCATION_SAVE);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = Prefs.getString(Prefs.TOKEN);

    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    request.fields["user_id"] = "11";
    request.fields["user_cv_id"] = id.toString();
    request.fields["title"] = this.title.toString();
    request.fields["faculty"] = this.faculty.toString();
    request.fields["speciality"] = this.speciality.toString();
    request.fields["type"] = this.type.toString();
    request.fields["end_year"] = this.end_year.toString();

    // send request to upload image
    return await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        if(value=="OK")
          return value;
      });
    }).catchError((e) {
      return "ERROR";
      print(e);
    });
  }

  Future<void> update(id) async {
    // string to uri
    var uri = Uri.parse(API_IP + API_USER_CV_EDUCATION_UPDATE + id.toString());

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = Prefs.getString(Prefs.TOKEN);

    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    request.fields["id"] = id.toString();
    request.fields["title"] = this.title.toString();
    request.fields["faculty"] = this.faculty.toString();
    request.fields["speciality"] = this.speciality.toString();
    request.fields["type"] = this.type.toString();
    request.fields["end_year"] = this.end_year.toString();

    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        var response = json.decode(value);
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<String> delete(id) async {
    // string to uri
    var uri = Uri.parse(API_IP + API_USER_CV_EDUCATION_DELETE + id.toString());

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = Prefs.getString(Prefs.TOKEN);

    // send request to upload image
    return await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        return value;
      });
    }).catchError((e) {
      print(e);
    });
  }
}

class UserCourse {
  int id;
  String name;
  String organization_name;
  String duration;
  String end_year;

  UserCourse(
      {this.id,
      this.name,
      this.organization_name,
      this.duration,
      this.end_year});

  Map toJson() => {
    'id': id,
    'name': name,
    'organization_name': organization_name,
    'duration': duration,
    'end_year': end_year,
  };

  Future<void> save(id) async {
    // string to uri
    var uri = Uri.parse(API_IP + API_USER_CV_COURSE_SAVE);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = Prefs.getString(Prefs.TOKEN);

    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    request.fields["user_id"] = "11";
    request.fields["user_cv_id"] = id.toString();
    request.fields["name"] = this.name.toString();
    request.fields["organization_name"] = this.organization_name.toString();
    request.fields["duration"] = this.duration.toString();
    request.fields["end_year"] = this.end_year.toString();

    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        var response = json.decode(value);
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> update(id) async {
    // string to uri
    var uri = Uri.parse(API_IP + API_USER_CV_COURSE_UPDATE + id.toString());

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = Prefs.getString(Prefs.TOKEN);

    final DateFormat formatter = DateFormat('yyyy-MM-dd');

    request.fields["id"] = id.toString();
    request.fields["name"] = this.name.toString();
    request.fields["organization_name"] = this.organization_name.toString();
    request.fields["duration"] = this.duration.toString();
    request.fields["end_year"] = this.end_year.toString();

    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        var response = json.decode(value);
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> delete(id) async {
    // string to uri
    var uri = Uri.parse(API_IP + API_USER_CV_COURSE_DELETE + id.toString());

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);
    request.headers['Authorization'] = Prefs.getString(Prefs.TOKEN);

    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        var response = json.decode(value);
      });
    }).catchError((e) {
      print(e);
    });
  }
}
