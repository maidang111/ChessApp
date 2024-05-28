//
//  PiecesModel.swift
//  ChessApp
//
//  Created by Mai Nguyen on 5/25/24.
//

import Foundation

enum PieceType{
    case PAWN, KNIGHT, BISHOP, ROOK, QUEEN, KING, NONE
}

class Piece {
    let isWhite : Bool
    let type : PieceType
    let id : Int
    
    init(_ id: Int,_ isWhite: Bool, _ type: PieceType) {
        self.isWhite = isWhite
        self.type = type
        self.id = id
    }
    
    func getImageName() -> String {
        return "lock"
    }
    
    func getPossibleMoves(_ row: Int, _ col : Int, _ boardViewModel : BoardViewModel) -> Set<GridCoord>{
        return []
    }
    
}

class Pawn: Piece{
    override func getImageName() -> String {
        if isWhite {
            return "White_Pawn"
        } else {
            return "Black_Pawn"
        }
    }
    
    override func getPossibleMoves(_ row: Int, _ col : Int, _ boardViewModel : BoardViewModel) -> Set<GridCoord>{
        var possibleMoves : Set<GridCoord> = []
        let board = boardViewModel.board
        // for player with white pieces
        if ((boardViewModel.whiteStart && isWhite) || (!boardViewModel.whiteStart && !isWhite)){
            // move 1 space forward
            if ((row - 1 >= 0) && (board[row-1][col] == 0)){
                possibleMoves.insert(GridCoord(row-1, col))
                // move 2 space forward
                if((row - 2 >= 0) && (board[row - 2][col] == 0) && (row == 6)) {
                    possibleMoves.insert(GridCoord(row-2, col))
                }
            }
            
            // takes on the left
            if ((col-1 >= 0) && (row-1 >= 0) && (board[row-1][col-1] * board[row][col] < 0 )){
                possibleMoves.insert(GridCoord(row-1, col-1))
            }
            
            // takes on the right
            if ((col+1 < 8) && (row-1 >= 0) && (board[row-1][col+1] * board[row][col] < 0)){
                possibleMoves.insert(GridCoord(row-1, col+1))
            }
        } else {
            // move 1 space forward
            if ((row + 1 < 8) && (board[row+1][col] == 0)){
                possibleMoves.insert(GridCoord(row+1, col))
                // move 2 space forward
                if((row + 2 < 8) && (board[row + 2][col] == 0) && (row == 1)) {
                    possibleMoves.insert(GridCoord(row+2, col))
                }
            }
            
            // takes on the left
            if ( (row+1 < 8) && (col-1 >= 0) && (board[row+1][col-1] * board[row][col] < 0)){
                possibleMoves.insert(GridCoord(row+1, col-1))
            }
            
            // takes on the right
            if ((col+1 < 8) && (row+1 < 8) && (board[row+1][col+1] * board[row][col] < 0)){
                possibleMoves.insert(GridCoord(row+1, col+1))
            }
        }
        
        // for player with black pieces
        return possibleMoves
    }
}

class Rook: Piece{
    override func getImageName() -> String {
        if isWhite {
            return "White_Rook"
        } else {
            return "Black_Rook"
        }
    }
    
    override func getPossibleMoves(_ row: Int, _ col : Int, _ boardViewModel : BoardViewModel) -> Set<GridCoord>{
        var possibleMoves : Set<GridCoord> = []
        let board = boardViewModel.board
        // for player with white pieces
        // moves forwards
        var temp_row = row
        while (temp_row > 0){
            temp_row -= 1
            if board[temp_row][col] != 0 {
                if (board[temp_row][col] * board[row][col] < 0){
                    possibleMoves.insert(GridCoord(temp_row,col))
                }
                break
            }
            possibleMoves.insert(GridCoord(temp_row,col))
        }
        
        // moves backwards
        temp_row = row
        while (temp_row < 7){
            temp_row += 1
            if board[temp_row][col] != 0 {
                if (board[temp_row][col] * board[row][col] < 0){
                    possibleMoves.insert(GridCoord(temp_row,col))
                }
                break
            }
            possibleMoves.insert(GridCoord(temp_row,col))
        }
        
        // moves left
        var temp_col = col
        while (temp_col > 0){
            temp_col -= 1
            if board[row][temp_col] != 0 {
                if (board[row][temp_col] * board[row][col] < 0){
                    possibleMoves.insert(GridCoord(row,temp_col))
                }
                break
            }
            possibleMoves.insert(GridCoord(row,temp_col))
        }
        
        // moves right
        temp_col = col
        while (temp_col < 7){
            temp_col += 1
            if board[row][temp_col] != 0 {
                if (board[row][temp_col] * board[row][col] < 0){
                    possibleMoves.insert(GridCoord(row,temp_col))
                }
                break
            }
            possibleMoves.insert(GridCoord(row,temp_col))
        }
        return possibleMoves
    }
}


class Bishop: Piece{
    override func getImageName() -> String {
        if isWhite {
            return "White_Bishop"
        } else {
            return "Black_Bishop"
        }
    }
    
    override func getPossibleMoves(_ row: Int, _ col : Int, _ boardViewModel : BoardViewModel) -> Set<GridCoord>{
        var possibleMoves : Set<GridCoord> = []
        let board = boardViewModel.board
        
        // left up
        var temp_row = row
        var temp_col = col
        while (temp_row > 0 && temp_col > 0){
            temp_row -= 1
            temp_col -= 1
            if board[temp_row][temp_col] != 0 {
                if (board[temp_row][temp_col] * board[row][col] < 0){
                    possibleMoves.insert(GridCoord(temp_row,temp_col))
                }
                break
            }
            possibleMoves.insert(GridCoord(temp_row, temp_col))
        }
        
        // right down
        temp_row = row
        temp_col = col
        while (temp_row < 7 && temp_col < 7){
            temp_row += 1
            temp_col += 1
            if board[temp_row][temp_col] != 0 {
                if (board[temp_row][temp_col] * board[row][col] < 0){
                    possibleMoves.insert(GridCoord(temp_row,temp_col))
                }
                break
            }
            possibleMoves.insert(GridCoord(temp_row, temp_col))
        }
        
        // right up
        temp_row = row
        temp_col = col
        while (temp_row > 0 && temp_col < 7){
            temp_row -= 1
            temp_col += 1
            if board[temp_row][temp_col] != 0 {
                if (board[temp_row][temp_col] * board[row][col] < 0){
                    possibleMoves.insert(GridCoord(temp_row,temp_col))
                }
                break
            }
            possibleMoves.insert(GridCoord(temp_row, temp_col))
        }
        
        // left down
        temp_row = row
        temp_col = col
        while (temp_row < 7 && temp_col > 0){
            temp_row += 1
            temp_col -= 1
            if board[temp_row][temp_col] != 0 {
                if (board[temp_row][temp_col] * board[row][col] < 0){
                    possibleMoves.insert(GridCoord(temp_row,temp_col))
                }
                break
            }
            possibleMoves.insert(GridCoord(temp_row, temp_col))
        }
        
        return possibleMoves
    }
}

class Knight: Piece{
    override func getImageName() -> String {
        if isWhite {
            return "White_Knight"
        } else {
            return "Black_Knight"
        }
    }
    
    override func getPossibleMoves(_ row: Int, _ col : Int, _ boardViewModel : BoardViewModel) -> Set<GridCoord>{
        var possibleMoves : Set<GridCoord> = []
        let board = boardViewModel.board
        
        if((row+1 < 8) && (col + 2 < 8) && (board[row+1][col+2] * board[row][col] <= 0)){
            possibleMoves.insert(GridCoord(row+1, col+2))
        }
        
        if((row+2 < 8) && (col+1 < 8) && (board[row+2][col+1] * board[row][col] <= 0)){
            possibleMoves.insert(GridCoord(row+2, col+1))
        }
        
        if((row+2 < 8) && (col-1 >= 0 ) && (board[row+2][col-1] * board[row][col] <= 0)){
            possibleMoves.insert(GridCoord(row+2, col-1))
        }
        
        if((row+1 < 8) && (col-2 >= 0) && (board[row+1][col-2] * board[row][col] < 0)){
            possibleMoves.insert(GridCoord(row+1, col-2))
        }
        
        if((row-2 >= 0) && (col-1 >= 0) && (board[row-2][col-1] * board[row][col] <= 0)){
            possibleMoves.insert(GridCoord(row-2, col-1))
        }
        
        if((row-1 >= 0) && (col-2 >= 0) && (board[row-1][col-2] * board[row][col] <= 0)){
            possibleMoves.insert(GridCoord(row-1, col-2))
        }
        
        if((row-1 >= 0) && (col + 2 < 8) && (board[row-1][col+2] * board[row][col] <= 0)){
            possibleMoves.insert(GridCoord(row-1, col+2))
        }
        
        if((row-2 >= 0) && (col+1 < 8) && (board[row-2][col+1] * board[row][col] <= 0)){
            possibleMoves.insert(GridCoord(row-2, col+1))
        }
        
        print(possibleMoves)
        return possibleMoves
    }
}

class Queen: Piece{
    override func getImageName() -> String {
        if isWhite {
            return "White_Queen"
        } else {
            return "Black_Queen"
        }
    }
    
    override func getPossibleMoves(_ row: Int, _ col : Int, _ boardViewModel : BoardViewModel) -> Set<GridCoord>{
        var possibleMoves : Set<GridCoord> = []
        let board = boardViewModel.board
        // for player with white pieces
        // moves forwards
        var temp_row = row
        while (temp_row > 0){
            temp_row -= 1
            if board[temp_row][col] != 0 {
                if (board[temp_row][col] * board[row][col] < 0){
                    possibleMoves.insert(GridCoord(temp_row,col))
                }
                break
            }
            possibleMoves.insert(GridCoord(temp_row,col))
        }
        
        // moves backwards
        temp_row = row
        while (temp_row < 7){
            temp_row += 1
            if board[temp_row][col] != 0 {
                if (board[temp_row][col] * board[row][col] < 0){
                    possibleMoves.insert(GridCoord(temp_row,col))
                }
                break
            }
            possibleMoves.insert(GridCoord(temp_row,col))
        }
        
        // moves left
        var temp_col = col
        while (temp_col > 0){
            temp_col -= 1
            if board[row][temp_col] != 0 {
                if (board[row][temp_col] * board[row][col] < 0){
                    possibleMoves.insert(GridCoord(row,temp_col))
                }
                break
            }
            possibleMoves.insert(GridCoord(row,temp_col))
        }
        
        // moves right
        temp_col = col
        while (temp_col < 7){
            temp_col += 1
            if board[row][temp_col] != 0 {
                if (board[row][temp_col] * board[row][col] < 0){
                    possibleMoves.insert(GridCoord(row,temp_col))
                }
                break
            }
            possibleMoves.insert(GridCoord(row,temp_col))
        }
        
        // left up
        temp_row = row
        temp_col = col
        while (temp_row > 0 && temp_col > 0){
            temp_row -= 1
            temp_col -= 1
            if board[temp_row][temp_col] != 0 {
                if (board[temp_row][temp_col] * board[row][col] < 0){
                    possibleMoves.insert(GridCoord(temp_row,temp_col))
                }
                break
            }
            possibleMoves.insert(GridCoord(temp_row, temp_col))
        }
        
        // right down
        temp_row = row
        temp_col = col
        while (temp_row < 7 && temp_col < 7){
            temp_row += 1
            temp_col += 1
            if board[temp_row][temp_col] != 0 {
                if (board[temp_row][temp_col] * board[row][col] < 0){
                    possibleMoves.insert(GridCoord(temp_row,temp_col))
                }
                break
            }
            possibleMoves.insert(GridCoord(temp_row, temp_col))
        }
        
        // right up
        temp_row = row
        temp_col = col
        while (temp_row > 0 && temp_col < 7){
            temp_row -= 1
            temp_col += 1
            if board[temp_row][temp_col] != 0 {
                if (board[temp_row][temp_col] * board[row][col] < 0){
                    possibleMoves.insert(GridCoord(temp_row,temp_col))
                }
                break
            }
            possibleMoves.insert(GridCoord(temp_row, temp_col))
        }
        
        // left down
        temp_row = row
        temp_col = col
        while (temp_row < 7 && temp_col > 0){
            temp_row += 1
            temp_col -= 1
            if board[temp_row][temp_col] != 0 {
                if (board[temp_row][temp_col] * board[row][col] < 0){
                    possibleMoves.insert(GridCoord(temp_row,temp_col))
                }
                break
            }
            possibleMoves.insert(GridCoord(temp_row, temp_col))
        }
        
        return possibleMoves
    }
}

class King: Piece{
    override func getImageName() -> String {
        if isWhite {
            return "White_King"
        } else {
            return "Black_King"
        }
    }
    
    override func getPossibleMoves(_ row: Int, _ col : Int, _ boardViewModel : BoardViewModel) -> Set<GridCoord>{
        var possibleMoves : Set<GridCoord> = []
        let board = boardViewModel.board
        // basic directions
        if ((row+1 < 8) && (board[row+1][col] * board[row][col] <= 0)) {
            possibleMoves.insert(GridCoord(row+1,col))
        }
        if ((row-1 >= 0) && (board[row-1][col] * board[row][col] <= 0)) {
            possibleMoves.insert(GridCoord(row-1,col))
        }
        if ((col+1 < 8) && (board[row][col+1] * board[row][col] <= 0)) {
            possibleMoves.insert(GridCoord(row,col+1))
        }
        if ((col-1 < 8) && (board[row][col-1] * board[row][col] <= 0)) {
            possibleMoves.insert(GridCoord(row,col-1))
        }
        
        //diags
        if ((row+1 < 8 && col+1 < 8) && (board[row+1][col+1] * board[row][col] <= 0)) {
            possibleMoves.insert(GridCoord(row+1,col+1))
        }
        if ((row-1 >= 0 && col+1 < 8) && (board[row-1][col+1] * board[row][col] <= 0)) {
            possibleMoves.insert(GridCoord(row-1,col+1))
        }
        if ((row+1 < 8 && col-1 >= 0) && (board[row+1][col-1] * board[row][col] <= 0)) {
            possibleMoves.insert(GridCoord(row+1,col-1))
        }
        if ((row-1 >= 0 && col-1 < 8) && (board[row-1][col-1] * board[row][col] <= 0)) {
            possibleMoves.insert(GridCoord(row-1,col-1))
        }
        
        return possibleMoves
    }
}

