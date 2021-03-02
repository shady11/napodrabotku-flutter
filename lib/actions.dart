import 'package:ishapp/datas/vacancy.dart';

class AddItemAction {
  final Vacancy item;

  AddItemAction(this.item);
}

class ToggleItemStateAction {
  final Vacancy item;

  ToggleItemStateAction(this.item);
}
