class Move {
  int column;
  int row;
  int prevValue;
  int newValue;

  Move({
    required this.column,
    required this.row,
    this.prevValue = 0,
    required this.newValue,
  });

  // Convert Move to JSON
  Map<String, dynamic> toJson() => {
    'column': column,
    'row': row,
    'prevValue': prevValue,
    'newValue': newValue,
  };

  // Create Move from JSON
  factory Move.fromJson(Map<String, dynamic> json) => Move(
    column: json['column'],
    row: json['row'],
    prevValue: json['prevValue'],
    newValue: json['newValue'],
  );
}
