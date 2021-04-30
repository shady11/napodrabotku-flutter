import 'package:ishtapp/constants/configs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ishtapp/datas/pref_manager.dart';
import 'package:ishtapp/datas/user.dart';

class Vacancy {
  int id;
  String company_name;
  String company_logo;
  String name;
  String title;
  String description;
  String address;
  String salary;
  String busyness;
  String schedule;
  String region;
  String job_type;
  String type;
  int company;

  Vacancy(
      {this.id,
      this.company_name,
      this.company_logo,
      this.name,
      this.title,
      this.description,
      this.address,
      this.salary,
      this.busyness,
      this.schedule,
      this.job_type,
      this.region,
      this.type,
      this.company});

  static Future<List<dynamic>> getLists(String model) async {
    final url = API_IP + model + '?lang=' + Prefs.getString(Prefs.LANGUAGE);
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
        company_logo: json['company_logo'],
        busyness: json['busyness'],
        schedule: json['schedule'],
        job_type: json['job_type'],
        region: json['region'],
        type: json['type'],
      );

  static Map<String, dynamic> vacancyToJsonMap(Vacancy vacancy) => {
        'company_id': Prefs.getInt(Prefs.USER_ID).toString(),
        'name': vacancy.name,
        'salary': vacancy.salary,
        'description': vacancy.description,
        'region': vacancy.region,
        'busyness': vacancy.busyness,
        'schedule': vacancy.schedule,
        'job_type': vacancy.job_type,
        'type': vacancy.type,
      };

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

  static Future<Vacancy> getVacancyByOffset({
    int limit,
    int offset,
    String type,
    List job_type_ids,
    List region_ids,
    List schedule_ids,
    List busyness_ids,
    List vacancy_type_ids,
  }) async {
    final url =
        API_IP + API_VACANCY_LIST + '?lang=' + Prefs.getString(Prefs.LANGUAGE);
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": Prefs.getString(Prefs.TOKEN)
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            'limit': 1,
            'offset': offset,
            'type_ids': vacancy_type_ids,
            'type': type,
            'job_type_ids': job_type_ids,
            'schedule_ids': schedule_ids,
            'region_ids': region_ids,
            'busyness_ids': busyness_ids
          }));
      for (var i in json.decode(utf8.decode(response.bodyBytes))) {
        Vacancy model = Vacancy.fromJson(i);
        return model;
      }
      return null;
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

  static Future<String> saveVacancyUser({
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
      return "OK";
    } catch (error) {
      return "ERROR";
      throw error;
    }
  }

  static Future<String> saveCompanyVacancy({Vacancy vacancy}) async {
    final url = API_IP + API_VACANCY_SAVE;
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": Prefs.getString(Prefs.TOKEN)
      };
      final response = await http.post(url,
          headers: headers, body: json.encode(vacancyToJsonMap(vacancy)));
      return "OK";
    } catch (error) {
      return "ERROR";
      throw error;
    }
  }

  static Future<String> deleteCompanyVacancy({
    int vacancy_id,
  }) async {
    final url = API_IP + API_COMPANY_VACANCY_DELETE;
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": Prefs.getString(Prefs.TOKEN)
      };
      final response = await http.post(url,
          headers: headers, body: json.encode({'vacancy_id': vacancy_id}));
      return "OK";
    } catch (error) {
      return "ERROR";
      throw error;
    }
  }

  static Future<String> activateDeactiveVacancy(
      {int vacancy_id, bool active}) async {
    final url = API_IP + API_COMPANY_VACANCY_ACTIVATE_DEACTIVATE;
    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": Prefs.getString(Prefs.TOKEN)
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({'vacancy_id': vacancy_id, 'active': active}));
      return "OK";
    } catch (error) {
      return "ERROR";
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
  int number_of_likeds;
  int number_of_submiteds;
  int number_of_active_vacancies;
  int number_of_inactive_vacancies;
  List region_ids;
  List schedule_ids;
  List busyness_ids;
  List vacancy_type_ids;
  ListVacancysState list;
  ListVacancysState inactive_list;
  LikedVacancyListState liked_list;
  ListSubmittedVacancyState submitted_list;
  UserState user;

  factory VacancyState.initial() => VacancyState(
      list: ListVacancysState.initial(),
      inactive_list: ListVacancysState.initial(),
      liked_list: LikedVacancyListState.initial(),
      submitted_list: ListSubmittedVacancyState.initial(),
      job_type_ids: [],
      region_ids: [],
      schedule_ids: [],
      busyness_ids: [],
      vacancy_type_ids: [],
      type: 'all',
      number_of_likeds: null,
      number_of_submiteds: 0,
      user: UserState.initial());

  VacancyState(
      {this.job_type_ids,
      this.region_ids,
      this.schedule_ids,
      this.busyness_ids,
      this.vacancy_type_ids,
      this.list,
      this.liked_list,
      this.type,
      this.submitted_list,
      this.user,
      this.number_of_submiteds,
      this.number_of_likeds,
      this.inactive_list});
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
