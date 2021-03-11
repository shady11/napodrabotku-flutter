import 'dart:convert';

import 'package:ishapp/datas/actions.dart';
import 'package:ishapp/datas/user.dart';
import 'package:redux_api_middleware/redux_api_middleware.dart';
import 'package:ishapp/datas/vacancy.dart';

import 'RSAA.dart';

UserState userReducer(UserState state, FSA action) {
  UserState newState = state;

  switch (action.type) {
    case GET_USER_REQUEST:
      newState.user.error = null;
      newState.user.loading = true;
      newState.user.data = null;
      return newState;

    case GET_USER_SUCCESS:
      newState.user.error = null;
      newState.user.loading = false;
      newState.user.data = userFromJSONStr(action.payload);
      return newState;

    case GET_USER_FAILURE:
      newState.user.error = action.payload;
      newState.user.loading = false;
      newState.user.data = null;
      return newState;

    case GET_USER_CV_REQUEST:
      newState.user_cv.error = null;
      newState.user_cv.loading = true;
      newState.user_cv.data = null;
      return newState;

    case GET_USER_CV_SUCCESS:
      newState.user_cv.error = null;
      newState.user_cv.loading = false;
      newState.user_cv.data = userCvFromJSONStr(action.payload);
      return newState;

    case GET_USER_CV_FAILURE:
      newState.user_cv.error = action.payload;
      newState.user_cv.loading = false;
      newState.user_cv.data = null;
      return newState;

    default:
      return newState;
  }
}

User userFromJSONStr(dynamic payload) {
  return User.fromJson(json.decode(payload));
}

UserCv userCvFromJSONStr(dynamic payload) {
  return UserCv.fromJson(json.decode(payload)[0]);
}

