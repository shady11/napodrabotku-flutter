import 'package:ishapp/constants/configs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ishapp/datas/pref_manager.dart';
import 'package:ishapp/datas/user.dart';

class Vacancy {
  int id;
  String company_name;
  String name;
  String title;
  String description;
  String address;
  String salary;
  String busyness;
  String schedule;
  String job_type;
  String type;
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

  static List<Vacancy> getListOfVacancies() {
    getVacancyList(
        limit: 10,
        offset: 0,
        job_type_ids: [],
        region_ids: [],
        schedule_ids: [],
        busyness_ids: [],
        vacancy_type_ids: []).then((value) {
      return value;
    });
  }

  static Future<List<Vacancy>> getVacancyList({
    int limit,
    int offset,
    List job_type_ids,
    List region_ids,
    List schedule_ids,
    List busyness_ids,
    List vacancy_type_ids,
  }) async {
    final url = API_IP + API_VACANCY_LIST;
    try {
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            'limit': limit,
            'offset': offset,
            'type_ids': vacancy_type_ids,
            'job_type_ids': job_type_ids,
            'schedule_ids': schedule_ids,
            'region_ids': region_ids,
            'busyness_ids': busyness_ids
          }));
      print(response.body);
      List<Vacancy> result_list = [];
      for (var i in json.decode(utf8.decode(response.bodyBytes))) {
        Vacancy model = Vacancy.fromJson(i);
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
    final url = API_IP + API_LIKED_USER_VACANCY_LIST;
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": '616bcc21ca95a4d1367ef5b6870f50e8c865205f'
      };
      final response = await http.post(url,
          headers: headers,
          body:
              json.encode({'limit': limit, 'offset': offset, 'type': 'LIKE'}));
      print(response.body);
      List<Vacancy> result_list = [];
      for (var i in json.decode(utf8.decode(response.bodyBytes))) {
        Vacancy model = Vacancy.fromJson(i);
        result_list.add(model);
      }

      return result_list;
    } catch (error) {
      throw error;
    }
  }

  static void saveVacancyUser({
    int vacancy_id,
    String type,
  }) async {
    final url = API_IP + API_VACANCY_USER_SAVE;
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": Prefs.getString(Prefs.TOKEN)
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({'vacancy_id': vacancy_id, 'type': type}));
      print(response.body);
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

class VacancyState {
  List job_type_ids;
  String type;
  List region_ids;
  List schedule_ids;
  List busyness_ids;
  List vacancy_type_ids;
  ListVacancysState list;
  LikedVacancyListState liked_list;
  ListSubmittedVacancyState submitted_list;
  UserState user;

  factory VacancyState.initial() => VacancyState(
        list: ListVacancysState.initial(),
        liked_list: LikedVacancyListState.initial(),
        submitted_list: ListSubmittedVacancyState.initial(),
        job_type_ids: [],
        region_ids: [],
        schedule_ids: [],
        busyness_ids: [],
        vacancy_type_ids: [],
        type: 'all',
        user: UserState.initial()
      );

  VacancyState(
      {
        this.job_type_ids,
        this.region_ids,
        this.schedule_ids,
        this.busyness_ids,
        this.vacancy_type_ids,
        this.list,
        this.liked_list,
        this.type,
        this.submitted_list,
        this.user
      });
}

class ListVacancysState {
  dynamic error;
  bool loading;
  List<Vacancy> data;

  ListVacancysState({
    this.error,
    this.loading,
    this.data,
  });

  factory ListVacancysState.initial() => ListVacancysState(
        error: null,
        loading: false,
        data: [],
      );
}

class ListSubmittedVacancyState {
  dynamic error;
  bool loading;
  List<Vacancy> data;

  ListSubmittedVacancyState({
    this.error,
    this.loading,
    this.data,
  });

  factory ListSubmittedVacancyState.initial() => ListSubmittedVacancyState(
    error: null,
    loading: false,
    data: [],
  );
}

class LikedVacancyListState {
  dynamic error;
  bool loading;
  List<Vacancy> data;

  LikedVacancyListState({
    this.error,
    this.loading,
    this.data,
  });

  factory LikedVacancyListState.initial() => LikedVacancyListState(
        error: null,
        loading: false,
        data: [],
      );
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
