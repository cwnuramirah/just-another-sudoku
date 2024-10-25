class CellModel {
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
