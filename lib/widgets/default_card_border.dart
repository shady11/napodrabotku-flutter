import 'package:flutter/material.dart';


/// Default Card border
RoundedRectangleBorder defaultCardBorder() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(28),
    topRight: Radius.circular(28),
    topLeft: Radius.circular(8),
    bottomRight: Radius.circular(8),
  ));
}
