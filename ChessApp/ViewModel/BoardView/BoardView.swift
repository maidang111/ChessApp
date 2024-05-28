//
//  BoardView.swift
//  ChessApp
//
//  Created by Mai Nguyen on 5/25/24.
//

import SwiftUI

struct BoardView: View {
    @StateObject var gameModel = GameModel(whiteStart: true)
    let rows = 8
    let columns = 8
//    init(whiteStart: Bool) {
//        self.gameModel = GameModel(whiteStart: whiteStart)
//        self.boardViewModel = gameModel.boardViewModel
//    }
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                ForEach(0..<8, id: \.self) { i in
                    HStack(spacing: 0) {
                        ForEach(0..<8, id: \.self) { j in
                            Rectangle()
                                .fill(gameModel.boardViewModel.boardColor[i][j] == 1 ? Color("White_Tile"): Color("Black_Tile"))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .aspectRatio(1, contentMode: .fit)
                        }
                    }
                }
            }
            
            VStack(spacing: 0){
                ForEach(0..<8, id: \.self) { i in
                    HStack(spacing: 0) {
                        ForEach(0..<8, id: \.self) { j in
                            if gameModel.boardViewModel.possibleMoves.contains(GridCoord(i,j)){
                                Rectangle()
                                    .fill(Color("Selected_Tile"))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .aspectRatio(1, contentMode: .fit)
                                    .opacity(0.4)
                                    .onTapGesture {
                                        gameModel.moveToTile(gameModel.selectedPos.first, gameModel.selectedPos.second, i, j)
                                    }
                            } else {
                                Rectangle()
                                    .fill(gameModel.boardViewModel.boardColor[i][j] == 1 ? Color("White_Tile"): Color("Black_Tile"))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .aspectRatio(1, contentMode: .fit)
                                    .onTapGesture {
                                        gameModel.isSelected = false
                                        gameModel.boardViewModel.possibleMoves = []
                                        gameModel.selected = 0
                                    }
                            }
                        }
                    }
                }
            }
            
            VStack(spacing: 0){
                ForEach(0..<8, id: \.self) { i in
                    HStack(spacing: 0) {
                        ForEach(0..<8, id: \.self) { j in
                            if (gameModel.boardViewModel.board[i][j] != 0 ) {
                                Image(gameModel.boardViewModel.piecesDict[gameModel.boardViewModel.board[i][j]]!.getImageName())
                                    .resizable()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .aspectRatio(1, contentMode: .fit)
                                    .onTapGesture {
                                        if ((gameModel.boardViewModel.board[i][j] > 0 && gameModel.isWhitesTrun) || (gameModel.boardViewModel.board[i][j] < 0 && !gameModel.isWhitesTrun)){
                                            if (gameModel.selected == gameModel.boardViewModel.board[i][j] && gameModel.isSelected) {
                                                gameModel.isSelected = false
                                            } else {
                                                gameModel.isSelected = true
                                                gameModel.selectedPos = GridCoord(i,j)
                                            }
                                            gameModel.selectTile(i,j)
                                            gameModel.selected = gameModel.boardViewModel.board[i][j]
                                        } else {
                                            if gameModel.boardViewModel.possibleMoves.contains(GridCoord(i,j)){
                                                gameModel.moveToTile(gameModel.selectedPos.first, gameModel.selectedPos.second, i, j)
                                            }
                                        }
                                    }
                            } else {
                                Rectangle()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .aspectRatio(1, contentMode: .fit)
                                    .opacity(0)
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    BoardView()
}
