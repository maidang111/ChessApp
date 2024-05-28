//
//  GameModel.swift
//  ChessApp
//
//  Created by Mai Nguyen on 5/26/24.
//

import Foundation

struct GridCoord: Hashable {
    let first: Int
    let second: Int
    init(_ first: Int, _ second: Int) {
        self.first = first
        self.second = second
    }
}

class GameModel : ObservableObject {
    //TODO: Create CheckMate
    @Published var isSelected : Bool
    @Published var boardViewModel : BoardViewModel
    @Published var selected : Int
    @Published var selectedPos : GridCoord
    @Published var isWhitesTrun : Bool = true
    
    init(whiteStart: Bool){
        isSelected = false
        boardViewModel = BoardViewModel(whiteStart: whiteStart)
        selectedPos = GridCoord(4,4)
        selected = 0
    }
    
    func selectTile(_ row: Int, _ column : Int){
        if isSelected {
            boardViewModel.possibleMoves = boardViewModel.piecesDict[boardViewModel.board[row][column]]!.getPossibleMoves(row, column, boardViewModel)
        } else {
            boardViewModel.possibleMoves = []
        }
        return
    }
    
    func moveToTile(_ currRow: Int, _ currColumn : Int, _ newRow : Int, _ newColumn : Int){
        boardViewModel.board[newRow][newColumn] = selected
        boardViewModel.board[currRow][currColumn] = 0
        isSelected = false
        boardViewModel.possibleMoves = []
        isWhitesTrun = !isWhitesTrun
    }
}
