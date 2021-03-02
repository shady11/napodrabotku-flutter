import 'package:ishapp/datas/user.dart';
import 'package:ishapp/datas/vacancy.dart';

class AppState {
  VacancyState vacancy;
  UserState user;

  AppState(
      {this.user, this.vacancy});

  AppState.fromAppState(AppState another) {
    vacancy = another.vacancy;
    user = another.user;
  }

  factory AppState.initial() => AppState(
    vacancy: VacancyState.initial(),
    user: UserState.initial()
  );

  AppState copyWith({
    VacancyState vacancy, UserState user
  }) {
    return AppState(
      vacancy: vacancy ?? this.vacancy,
      user: user??this.user
    );
  }
}
