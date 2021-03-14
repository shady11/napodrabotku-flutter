import 'dart:convert';

import 'package:ishapp/datas/actions.dart';
import 'package:ishapp/datas/user.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';
import 'package:ishapp/datas/vacancy.dart';

import 'RSAA.dart';

VacancyState vacancyReducer(VacancyState state, FSA action) {
  VacancyState newState = state;

  switch (action.type) {
    case LIST_VACANCIES_REQUEST:
      newState.list.error = null;
      newState.list.loading = true;
      newState.list.data = null;
      return newState;

    case LIST_VACANCIES_SUCCESS:
      newState.list.error = null;
      newState.list.loading = false;
      newState.list.data = usersFromJSONStr(action.payload);
      return newState;

    case LIST_VACANCIES_FAILURE:
      newState.list.error = action.payload;
      newState.list.loading = false;
      newState.list.data = null;
      return newState;


    case GET_LIKED_VACANCY_REQUEST:
      newState.liked_list.error = null;
      newState.liked_list.loading = true;
      newState.liked_list.data = null;
      return newState;

    case GET_LIKED_VACANCY_SUCCESS:
      newState.liked_list.error = null;
      newState.liked_list.loading = false;
      newState.liked_list.data = usersFromJSONStr(action.payload);
      return newState;

    case GET_LIKED_VACANCY_FAILURE:
      newState.liked_list.error = action.payload;
      newState.liked_list.loading = false;
      newState.liked_list.data = null;
      return newState;

    case GET_SUBMITTED_VACANCY_REQUEST:
      newState.submitted_list.error = null;
      newState.submitted_list.loading = true;
      newState.submitted_list.data = null;
      return newState;

    case GET_SUBMITTED_VACANCY_SUCCESS:
      newState.submitted_list.error = null;
      newState.submitted_list.loading = false;
      newState.submitted_list.data = usersFromJSONStr(action.payload);
      return newState;

    case GET_SUBMITTED_VACANCY_FAILURE:
      newState.submitted_list.error = action.payload;
      newState.submitted_list.loading = false;
      newState.submitted_list.data = null;
      return newState;

    case GET_LIKED_VACANCY_NUMBER_REQUEST:
      newState.number_of_likeds = 0;
      return newState;

    case GET_LIKED_VACANCY_NUMBER_SUCCESS:
      newState.number_of_likeds = int.parse(action.payload);
      return newState;

    case GET_LIKED_VACANCY_NUMBER_FAILURE:
      newState.number_of_likeds = 0;
      return newState;

    case GET_SUBMITTED_VACANCY_NUMBER_REQUEST:
      newState.number_of_submiteds = 0;
      return newState;

    case GET_SUBMITTED_VACANCY_NUMBER_SUCCESS:
      newState.number_of_submiteds = int.parse(action.payload);
      return newState;

    case GET_SUBMITTED_VACANCY_NUMBER_FAILURE:
      newState.number_of_submiteds = 0;
      return newState;

    case DELETE_ITEM:
      newState.list.error = null;
      newState.list.loading = true;
      newState.list.data = null;
      return newState;

    default:
      return newState;
  }
}
List<Vacancy> usersFromJSONStr(dynamic payload) {
  Iterable jsonArray = json.decode(payload);
  return jsonArray.map((j) => Vacancy.fromJson(j)).toList();
}

//User userFromJSONStr(dynamic payload) {
//  return User.fromJson(json.decode(payload));
//}

List<Vacancy> deleteItem(List<Vacancy> items, RemoveLikedItemAction action) {
  return List.from(items)..removeLast();
}
