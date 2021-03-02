import 'dart:convert';

import 'package:ishapp/constants/configs.dart';
import 'package:ishapp/datas/pref_manager.dart';
import 'package:ishapp/datas/vacancy.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';

import 'package:ishapp/datas/app_state.dart';

const LIST_VACANCIES_REQUEST = 'LIST_VACANCIES_REQUEST';
const LIST_VACANCIES_SUCCESS = 'LIST_VACANCIES_SUCCESS';
const LIST_VACANCIES_FAILURE = 'LIST_VACANCIES_FAILURE';

RSAA getVacanciesRequest({
  List job_type_ids,
  List region_ids,
  List schedule_ids,
  List busyness_ids,
  List vacancy_type_ids,
  String type
}) {
  return
    RSAA(
      method: 'POST',
      endpoint: API_IP+API_VACANCY_LIST,
      body: json.encode({
        'limit': 10,
        'offset': 0,
        'type': type,
        'type_ids': vacancy_type_ids,
        'job_type_ids': job_type_ids,
        'schedule_ids': schedule_ids,
        'region_ids': region_ids,
        'busyness_ids': busyness_ids
      }),
      types: [
        LIST_VACANCIES_REQUEST,
        LIST_VACANCIES_SUCCESS,
        LIST_VACANCIES_FAILURE,
      ],
      headers: {
        'Content-Type': 'application/json',
        'Authorization': Prefs.getString(Prefs.TOKEN ),
      },
    );
}

ThunkAction<AppState> getVacancies() => (Store<AppState> store) => store.dispatch(getVacanciesRequest(
    job_type_ids: store.state.vacancy.job_type_ids,
    region_ids: store.state.vacancy.region_ids,
    schedule_ids: store.state.vacancy.schedule_ids,
    busyness_ids: store.state.vacancy.busyness_ids,
    vacancy_type_ids: store.state.vacancy.vacancy_type_ids,
    type: store.state.vacancy.type
));
ThunkAction<AppState> deleteItem() => (Store<AppState> store) => store.state.vacancy.list.data.removeLast();

ThunkAction<AppState> setFilter({
  List job_type_ids,
  List region_ids,
  List schedule_ids,
  List busyness_ids,
  List vacancy_type_ids,
}) => (Store<AppState> store) {
  store.state.vacancy.job_type_ids = job_type_ids;
  store.state.vacancy.schedule_ids = schedule_ids;
  store.state.vacancy.region_ids = region_ids;
  store.state.vacancy.vacancy_type_ids = vacancy_type_ids;
  store.state.vacancy.busyness_ids = busyness_ids;
};

ThunkAction<AppState> setTimeFilter({
  String type
}) => (Store<AppState> store) {
  store.state.vacancy.type = type;
};


const GET_LIKED_VACANCY_REQUEST = 'GET_LIKED_VACANCY_REQUEST';
const GET_LIKED_VACANCY_SUCCESS = 'GET_LIKED_VACANCY_SUCCESS';
const GET_LIKED_VACANCY_FAILURE = 'GET_LIKED_VACANCY_FAILURE';
const DELETE_ITEM = 'DELETE_ITEM';

RSAA getLikedVacancyRequest() {
  return
    RSAA(
      method: 'GET',
      endpoint: API_IP+API_LIKED_USER_VACANCY_LIST,
      types: [
        GET_LIKED_VACANCY_REQUEST,
        GET_LIKED_VACANCY_SUCCESS,
        GET_LIKED_VACANCY_FAILURE,
      ],
      headers: {
        'Content-Type': 'application/json',
        'Authorization': Prefs.getString(Prefs.TOKEN ),
      },
    );
}

ThunkAction<AppState> getLikedVacancies() => (Store<AppState> store) => store.dispatch(getLikedVacancyRequest());

const GET_SUBMITTED_VACANCY_REQUEST = 'GET_SUBMITTED_VACANCY_REQUEST';
const GET_SUBMITTED_VACANCY_SUCCESS = 'GET_SUBMITTED_VACANCY_SUCCESS';
const GET_SUBMITTED_VACANCY_FAILURE = 'GET_SUBMITTED_VACANCY_FAILURE';
RSAA getSubmittedVacancyRequest() {
  return
    RSAA(
      method: 'GET',
      endpoint: API_IP+API_SUBMITTED_USER_VACANCY_LIST,
      types: [
        GET_SUBMITTED_VACANCY_REQUEST,
        GET_SUBMITTED_VACANCY_SUCCESS,
        GET_SUBMITTED_VACANCY_FAILURE,
      ],
      headers: {
        'Content-Type': 'application/json',
        'Authorization': Prefs.getString(Prefs.TOKEN ),
      },
    );
}

ThunkAction<AppState> getSubmittedVacancies() => (Store<AppState> store) => store.dispatch(getSubmittedVacancyRequest());

ThunkAction <AppState> deleteItem1() => (Store<AppState> store) => store.state.vacancy.list.data.removeLast();


const GET_USER_REQUEST = 'GET_USER_REQUEST';
const GET_USER_SUCCESS = 'GET_USER_SUCCESS';
const GET_USER_FAILURE = 'GET_USER_FAILURE';
RSAA getUserRequest() {
  return
    RSAA(
      method: 'GET',
      endpoint: API_IP+API_GET_USER,
      types: [
        GET_USER_REQUEST,
        GET_USER_SUCCESS,
        GET_USER_FAILURE,
      ],
      headers: {
        'Content-Type': 'application/json',
        'Authorization': Prefs.getString(Prefs.TOKEN ),
      },
    );
}

ThunkAction<AppState> getUser() => (Store<AppState> store) => store.dispatch(getUserRequest());
