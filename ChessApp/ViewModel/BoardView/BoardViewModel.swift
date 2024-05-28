//
//  BoardViewModel.swift
//  ChessApp
//
//  Created by Mai Nguyen on 5/25/24.
//
import Foundation

class BoardViewModel : ObservableObject {
    @Published var board : [[Int]]
    @Published var boardColor : [[Int]]
    @Published var possibleMoves : Set<GridCoord> = []
    let piecesDict = [ 0 : Piece(0, false, PieceType.NONE),
                       
                       1 : Rook( 1, true, PieceType.ROOK),
                      -1 : Rook(-1, false, PieceType.ROOK),
                       8 : Rook( 8, true, PieceType.ROOK),
                      -8 : Rook(-8, false, PieceType.ROOK),
                       
                       3 : Bishop(2, true, PieceType.BISHOP),
                      -3 : Bishop(-2, false, PieceType.BISHOP),
                       6 : Bishop(7, true, PieceType.BISHOP),
                      -6 : Bishop(-7, false, PieceType.BISHOP),
                       
                       2 : Knight(3, true, PieceType.KNIGHT),
                      -2 : Knight(-3, false, PieceType.KNIGHT),
                       7 : Knight(6, true, PieceType.KNIGHT),
                      -7 : Knight(-6, false, PieceType.KNIGHT),
                       
                       4 : Queen(4, true, PieceType.QUEEN),
                      -4 : Queen(-4, false, PieceType.QUEEN),
                       
                       5 : King(5, true, PieceType.KING),
                      -5 : King(-5, false, PieceType.KING),
    
                       11 : Pawn(11, true, PieceType.PAWN),
                      -11 : Pawn(-11, false, PieceType.PAWN),
                       12 : Pawn(12, true, PieceType.PAWN),
                      -12 : Pawn(-12, false, PieceType.PAWN),
                       13 : Pawn(13, true, PieceType.PAWN),
                      -13 : Pawn(-13, false, PieceType.PAWN),
                       14 : Pawn(14, true, PieceType.PAWN),
                      -14 : Pawn(-14, false, PieceType.PAWN),
                       15 : Pawn(15, true, PieceType.PAWN),
                      -15 : Pawn(-15, false, PieceType.PAWN),
                       16 : Pawn(16, true, PieceType.PAWN),
                      -16 : Pawn(-16, false, PieceType.PAWN),
                       17 : Pawn(17, true, PieceType.PAWN),
                      -17 : Pawn(-17, false, PieceType.PAWN),
                       18 : Pawn(18, true, PieceType.PAWN),
                      -18 : Pawn(-18, false, PieceType.PAWN)]
    let whiteStart: Bool
    init(whiteStart : Bool){
        // white: [pawn : 1 , knight : 2, bishop : 3, rook : 4, queen : 5, king : 6]
        // black: pawn : -1 , knight : -2, bishop : -3, rook : -4, queen : -5, king : -6
        
        // boardColor:
        if whiteStart {
            self.board = [[-1,-2,-3,-4,-5,-6,-7,-8],[-11,-12,-13,-14,-15,-16,-17,-18],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[11,12,13,14,15,16,17,18],[1,2,3,4,5,6,7,8]]
            self.boardColor = [[1,0,1,0,1,0,1,0],
                               [0,1,0,1,0,1,0,1],
                               [1,0,1,0,1,0,1,0],
                               [0,1,0,1,0,1,0,1],
                               [1,0,1,0,1,0,1,0],
                               [0,1,0,1,0,1,0,1],
                               [1,0,1,0,1,0,1,0],
                               [0,1,0,1,0,1,0,1]]
        } else {
            self.board = [[1,2,3,5,4,6,7,8],[11,12,13,14,15,16,17,18],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],[-11,-12,-13,-14,-15,-16,-17,-18],[-1,-2,-3,-5,-4,-6,-7,-8]]
            self.boardColor =  [[0,1,0,1,0,1,0,1],
                                [1,0,1,0,1,0,1,0],
                                [0,1,0,1,0,1,0,1],
                                [1,0,1,0,1,0,1,0],
                                [0,1,0,1,0,1,0,1],
                                [1,0,1,0,1,0,1,0],
                                [0,1,0,1,0,1,0,1],
                                [1,0,1,0,1,0,1,0]]
        }
        self.whiteStart = whiteStart
    }
}
