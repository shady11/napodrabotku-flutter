import 'package:ishapp/constants/configs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Vacancy {
  int id;
  String company_name;
  String company_logo_image;
  String name;
  String description;
  String experience;

  Vacancy(
      {
        this.id,
        this.company_name,
        this.company_logo_image,
        this.name,
        this.description,
        this.experience
      }
  );

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
}

class JobType{
  int id;
  String name;

  JobType({this.id, this.name});
}

class VacancyType{
  int id;
  String name;

  VacancyType({this.id, this.name});
}

class Busyness{
  int id;
  String name;

  Busyness({this.id, this.name});
}


class Schedule{
  int id;
  String name;

  Schedule({this.id, this.name});
}