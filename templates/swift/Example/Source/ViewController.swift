//
//  ViewController.swift
//  PROJECT
//
//  Created by William Entriken on 2/3/16.
//  Copyright © 2016 William Entriken. All rights reserved.
//

import UIKit
import PROJECT

class ViewController: UIViewController {
    @IBOutlet var chessboard: PROJECT!

    var piecesByIndex = [Int : FDChessboardPiece]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let position: String = "RNBQKBNRPPPPPPPP................................pppppppprnbqkbnr"

        for (index, letter) in position.characters.enumerate() {
            switch letter {
            case "K":
                piecesByIndex[index] = .WhiteKing
            case "k":
                piecesByIndex[index] = .BlackKing
            case "Q":
                piecesByIndex[index] = .WhiteQueen
            case "q":
                piecesByIndex[index] = .BlackQueen
            case "R":
                piecesByIndex[index] = .WhiteRook
            case "r":
                piecesByIndex[index] = .BlackRook
            case "B":
                piecesByIndex[index] = .WhiteBishop
            case "b":
                piecesByIndex[index] = .BlackBishop
            case "N":
                piecesByIndex[index] = .WhiteKnight
            case "n":
                piecesByIndex[index] = .BlackKnight
            case "P":
                piecesByIndex[index] = .WhitePawn
            case "p":
                piecesByIndex[index] = .BlackPawn
            default:
                break
            }
        }
        self.chessboard.dataSource = self
    }
}

extension ViewController: PROJECTDataSource {
    func chessboardView(board: PROJECT, pieceForSquare square: FDChessboardSquare) -> FDChessboardPiece? {
        return piecesByIndex[square.index]
    }

    func chessboardViewLastMove(board: PROJECT) -> (from: FDChessboardSquare, to: FDChessboardSquare)? {
        return nil
    }

    func chessboardViewPremove(board: PROJECT) -> (from: FDChessboardSquare, to: FDChessboardSquare)? {
        return nil
    }
}
