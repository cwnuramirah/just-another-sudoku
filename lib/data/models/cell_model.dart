import 'package:flutter/material.dart';

class CellModel with ChangeNotifier {
  int value;
  bool isFixed;
  bool isError;
  Set<int> notes;

  CellModel({
    int? value,
    this.isFixed = false,
    this.isError = false,
    Set<int>? notes,
  })  : notes = notes ?? {},
        value = value ?? 0;
}
