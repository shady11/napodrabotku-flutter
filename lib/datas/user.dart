class User {
  int id;
  final String userFullname;
  final String userPhotoLink;
  final String userSchool;
  final String jobTitle;
  final String userDistance;
  List<UserEducation> user_educations;
  List<UserExperience> user_experiences;

  // Constructor
  User({
    this.userFullname,
    this.userPhotoLink,
    this.userSchool,
    this.jobTitle,
    this.userDistance
  });
}

class UserEducation{
  int id;
  EducationType education_type;
  String place;
  DateTime start;
  DateTime end;
  String title;
}

class EducationType{
  int id;
  String name;
}

class UserExperience{
  int id;
  String company_name;
  DateTime start;
  DateTime end;
  String job;
}
