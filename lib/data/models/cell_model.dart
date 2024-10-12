class CellModel {
  int value; 
  bool isFixed;
  bool isError;
  Set<int> notes;

  CellModel({
    required this.value,
    this.isFixed = false,
    this.isError = false,
    Set<int>? notes,
  }) : notes = notes ?? {};

  void addNote(int number) {
    if (number >= 1 && number <= 9) {
      notes.add(number);
    }
  }

  void removeNote(int number) {
    notes.remove(number);
  }

  void clearNotes() {
    notes.clear();
  }
}
