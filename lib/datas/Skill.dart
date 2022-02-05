import 'package:ishtapp/constants/configs.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ishtapp/datas/pref_manager.dart';

class Skill {
  int id;
  int categoryId;
  String name;

  Skill({this.id, this.categoryId, this.name});
}

class SkillCategory {
  int id;
  String name;
  List<Skill> skill = [];

  SkillCategory({this.id, this.name, this.skill});

  Future<String> saveUserSkills(List<String> list, int categoryId) async {
    // string to uri
    var uri = Uri.parse(API_IP + API_USER_SKILL_SAVE);

    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": Prefs.getString(Prefs.TOKEN)
      };
      final response = await http.post(
        uri,
        headers: headers,
        body: json.encode({
          "user_id": Prefs.getInt(Prefs.USER_ID).toString(),
          "user_skills": list,
          "category_id": categoryId,
        }),
      );
      json.decode(response.body);
      print(json.decode(response.body));
      return "OK";
    } catch (error) {
      throw error;
    }
  }

  Future<String> saveVacancySkills(List<String> list, int categoryId) async {
    // string to uri
    var uri = Uri.parse(API_IP + API_VACANCY_SKILL_SAVE);

    try {
      Map<String, String> headers = {
        "Content-type": "application/json",
        "Authorization": Prefs.getString(Prefs.TOKEN)
      };
      final response = await http.post(
        uri,
        headers: headers,
        body: json.encode({
          "vacancy_id": Prefs.getInt(Prefs.USER_ID).toString(),
          "vacancy_skills": list,
          "category_id": categoryId,
        }),
      );
      json.decode(response.body);
      print(json.decode(response.body));
      return "OK";
    } catch (error) {
      throw error;
    }
  }

}