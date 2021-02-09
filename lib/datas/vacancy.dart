import 'package:ishapp/constants/configs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Vacancy {
  int id;
  String company_name;
  String name;
  String title;
  String description;
  String address;
  String salary;
  int busyness;
  int schedule;
  int job_type;
  int type;
  int company;

  Vacancy(
      {this.id,
      this.company_name,
      this.name,
      this.title,
      this.description,
      this.address,
      this.salary,
      this.busyness,
      this.schedule,
      this.job_type,
      this.type,
      this.company});

  static Future<List<dynamic>> getLists(String model) async {
    final url = API_IP + model;
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.get(url, headers: headers);

      return json.decode(utf8.decode(response.bodyBytes));
    } catch (error) {
      throw error;
    }
  }

  factory Vacancy.fromJson(Map<String, dynamic> json) => new Vacancy(
      id: json["id"],
      name: json["name"],
      title: json["title"],
      description: json["description"],
      address: json["address"],
      salary: json['salary'],
      company: json['company'],
      company_name: json['company_name'],
      busyness: json['busyness'],
      schedule: json['schedule'],
      job_type: json['job_type'],
      type: json['type'],
  );

  static Future<List<Vacancy>> getVacancyList(
    int limit,
    int offset,
    List<int> job_type_ids,
    List<int> schedule_ids,
    List<int> busyness_ids,
    List<int> vacancy_type_ids,
  ) async {
    final url = API_IP + API_VACANCY_LIST;
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(url,
          headers: headers,
          body: json.encode({'limit': limit, 'offset': offset}));
      print(response.body);
      List<Vacancy> result_list = [];
      for(var i in json.decode(utf8.decode(response.bodyBytes))){

        Vacancy model= Vacancy.fromJson(i);
        result_list.add(model);
      }

      return result_list;
    } catch (error) {
      throw error;
    }
  }

  static Future<List<Vacancy>> getVacancyListByType(
      int limit,
      int offset,
      String type,
      ) async {
    final url = API_IP + API_VACANCY_USER_LIST;
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(url,
          headers: headers,
          body: json.encode({'limit': limit, 'offset': offset, 'type': type}));
      print(response.body);
      List<Vacancy> result_list = [];
      for(var i in json.decode(utf8.decode(response.bodyBytes))){

        Vacancy model= Vacancy.fromJson(i);
        result_list.add(model);
      }

      return result_list;
    } catch (error) {
      throw error;
    }
  }
}

class JobType {
  int id;
  String name;

  JobType({this.id, this.name});
}

class VacancyType {
  int id;
  String name;

  VacancyType({this.id, this.name});
}

class Busyness {
  int id;
  String name;

  Busyness({this.id, this.name});
}

class Schedule {
  int id;
  String name;

  Schedule({this.id, this.name});
}
