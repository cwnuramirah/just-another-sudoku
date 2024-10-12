class CellModel {
  final int value;
  bool isFixed;
  bool isError;

  CellModel({
    required this.value,
    this.isFixed = false,
    this.isError = false,
  });
}