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

  // Convert CellModel to JSON
  Map<String, dynamic> toJson() => {
    'value': value,
    'isFixed': isFixed,
    'isError': isError,
    'notes': notes.toList(), // Convert Set to List for JSON compatibility
  };

  // Create CellModel from JSON
  factory CellModel.fromJson(Map<String, dynamic> json) => CellModel(
    value: json['value'],
    isFixed: json['isFixed'],
    isError: json['isError'],
    notes: Set<int>.from(json['notes'] ?? []),
  );
}
