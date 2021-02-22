import 'package:ishapp/datas/vacancy.dart';

class AppState{
  List<Vacancy> vacancyList = new List<Vacancy>();
  List<Vacancy> likedVacancyList = new List<Vacancy>();
  List<Vacancy> submittedVacancyList = new List<Vacancy>();

  AppState({this.vacancyList, this.likedVacancyList});

  AppState.fromAppState(AppState another) {
    vacancyList = another.vacancyList;
    likedVacancyList = another.likedVacancyList;
    submittedVacancyList = another.submittedVacancyList;
  }
}
