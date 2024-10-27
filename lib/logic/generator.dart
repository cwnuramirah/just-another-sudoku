import 'dart:math';

const int boardSize = 9;

// Check if it's valid to place the number `num` in the position `board[row][col]`
bool isValid(List<List<int>> board, int row, int col, int num) {
  for (int i = 0; i < boardSize; i++) {
    if (board[row][i] == num || board[i][col] == num) return false;
  }

  // Check 3x3 grid
  int boxRow = (row ~/ 3) * 3;
  int boxCol = (col ~/ 3) * 3;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[boxRow + i][boxCol + j] == num) return false;
    }
  }

  return true;
}

// Generate a fully solved, random Sudoku board using a shuffled list of numbers
bool solveSudoku(List<List<int>> board) {
  List<int> numbers = List.generate(9, (index) => index + 1)
    ..shuffle(); // Shuffle numbers 1-9

  for (int row = 0; row < boardSize; row++) {
    for (int col = 0; col < boardSize; col++) {
      if (board[row][col] == 0) {
        for (int num in numbers) {
          if (isValid(board, row, col, num)) {
            board[row][col] = num;
            if (solveSudoku(board)) return true;
            board[row][col] = 0; // Backtrack
          }
        }
        return false;
      }
    }
  }
  return true; // Board is fully filled and valid
}

// Generates a fully solved Sudoku board
List<List<int>> generateFullBoard() {
  List<List<int>> board =
      List.generate(boardSize, (_) => List.filled(boardSize, 0));
  solveSudoku(board);
  return board;
}

// Shuffles rows, columns, and 3x3 blocks for added randomness
void shuffleBoard(List<List<int>> board) {
  Random random = Random();

  // Shuffle rows within each 3x3 block
  for (int block = 0; block < boardSize; block += 3) {
    for (int i = 0; i < 3; i++) {
      int row1 = block + i;
      int row2 = block + random.nextInt(3);
      List<int> temp = board[row1];
      board[row1] = board[row2];
      board[row2] = temp;
    }
  }

  // Shuffle columns within each 3x3 block
  for (int block = 0; block < boardSize; block += 3) {
    for (int i = 0; i < 3; i++) {
      int col1 = block + i;
      int col2 = block + random.nextInt(3);
      for (int row = 0; row < boardSize; row++) {
        int temp = board[row][col1];
        board[row][col1] = board[row][col2];
        board[row][col2] = temp;
      }
    }
  }
}

// Count the number of solutions for a given Sudoku board
int countSolutions(List<List<int>> board) {
  int solutions = 0;

  bool backtrackSolver(int row, int col) {
    if (row == boardSize) {
      solutions++;
      return solutions == 1; // Stop after finding the second solution
    }

    if (col == boardSize) return backtrackSolver(row + 1, 0);
    if (board[row][col] != 0) return backtrackSolver(row, col + 1);

    for (int num = 1; num <= 9; num++) {
      if (isValid(board, row, col, num)) {
        board[row][col] = num;
        if (!backtrackSolver(row, col + 1)) return false;
        board[row][col] = 0; // Backtrack
      }
    }
    return true;
  }

  backtrackSolver(0, 0);
  return solutions;
}

// Check if the board has a unique solution
bool hasUniqueSolution(List<List<int>> board) {
  return countSolutions(board) == 1;
}

//   // First, ensure each 3x3 box has at least 1 cell removed
//   for (int boxRow = 0; boxRow < 9; boxRow += 3) {
//     for (int boxCol = 0; boxCol < 9; boxCol += 3) {
//       bool removed = false;
//       while (!removed) {
//         int row = boxRow + random.nextInt(3);
//         int col = boxCol + random.nextInt(3);
//         if (board[row][col] != 0) {
//           int temp = board[row][col];
//           board[row][col] = 0;
//           if (hasUniqueSolution(board)) {
//             removed = true;
//             cellsToRemove--;
//           } else {
//             board[row][col] = temp;  // Restore if no unique solution
//           }
//         }
//       }
//     }
//   }
List<List<int>> generatePuzzle({required int minClues}) {
  List<List<int>> board = generateFullBoard();
  shuffleBoard(board);
  for (List<int> row in board) {
    print(row);
  }
  Random random = Random();

  int totalCells = 81;
  int emptyCellsCount = totalCells - minClues;
  Set<String> cellsToRemove = {};

  // Determine which cells to remove
  while (cellsToRemove.length != emptyCellsCount) {
    int row = random.nextInt(9);
    int col = random.nextInt(9);

    String cellKey = "$row-$col";

    if (!cellsToRemove.contains(cellKey) && board[row][col] != 0) {
      int backup = board[row][col];
      board[row][col] = 0;

      if (hasUniqueSolution(board)) {
        cellsToRemove.add(cellKey);
      }

      // Restore the cell for now
      board[row][col] = backup;
    }
  }

  // Permanently remove cells from the board
  for (String cellKey in cellsToRemove) {
    List<String> parts = cellKey.split('-');
    int row = int.parse(parts[0]);
    int col = int.parse(parts[1]);

    board[row][col] = 0;
  }

  return board;
}
