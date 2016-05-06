//
//  FDChessboardView.swift
//  FDChessboardView
//
//  Created by William Entriken on 2/2/16.
//  Copyright © 2016 William Entriken. All rights reserved.
//

import Foundation
import UIKit

public struct FDChessboardSquare {
    /// From 0...7
    public var file: Int

    /// From 0...7
    public var rank: Int

    /// A format like a4
    public var algebriac: String {
        get {
            return String(UnicodeScalar(96 + file)) + String(rank + 1)
        }
    }

    public var index: Int {
        get {
            return rank * 8 + file
        }
        set {
            file = index % 8
            rank = index / 8
        }
    }

    public init(index newIndex: Int) {
        file = newIndex % 8
        rank = newIndex / 8
    }
}

public enum FDChessboardPiece: String {
    case WhitePawn = "wp"
    case BlackPawn = "bp"
    case WhiteKnight = "wn"
    case BlackKnight = "bn"
    case WhiteBishop = "wb"
    case BlackBishop = "bb"
    case WhiteRook = "wr"
    case BlackRook = "br"
    case WhiteQueen = "wq"
    case BlackQueen = "bq"
    case WhiteKing = "wk"
    case BlackKing = "bk"
}

public protocol FDChessboardViewDataSource: class {
    /// What piece is on the square?
    func chessboardView(board: FDChessboardView, pieceForSquare square: FDChessboardSquare) -> FDChessboardPiece?

    /// The last move
    func chessboardViewLastMove(board: FDChessboardView) -> (from:FDChessboardSquare, to:FDChessboardSquare)?

    /// The premove
    func chessboardViewPremove(board: FDChessboardView) -> (from:FDChessboardSquare, to:FDChessboardSquare)?
}

public protocol FDChessboardViewDelegate: class {
    /// Where can this piece move to?
    func chessboardView(board: FDChessboardView, legalDestinationsForPieceAtSquare from: FDChessboardSquare) -> [FDChessboardSquare]

    /// Before a move happens (cannot be stopped)
    func chessboardView(board: FDChessboardView, willMoveFrom from: FDChessboardSquare, to: FDChessboardSquare)

    /// After a move happened
    func chessboardView(board: FDChessboardView, didMoveFrom from: FDChessboardSquare, to: FDChessboardSquare)

    /// Before a move happens (cannot be stopped)
    func chessboardView(board: FDChessboardView, willMoveFrom from: FDChessboardSquare, to: FDChessboardSquare, withPromotion promotion: FDChessboardPiece)

    /// After a move happened
    func chessboardView(board: FDChessboardView, didMoveFrom from: FDChessboardSquare, to: FDChessboardSquare, withPromotion promotion: FDChessboardPiece)
}

public class FDChessboardView: UIView {
    public var lightBackgroundColor = UIColor(red: 222.0/255, green:196.0/255, blue:160.0/255, alpha:1)
    public var darkBackgroundColor = UIColor(red: 160.0/255, green:120.0/255, blue:55.0/255, alpha:1)
    public var targetBackgroundColor = UIColor(hue: 0.75, saturation:0.5, brightness:0.5, alpha:1.0)
    public var legalBackgroundColor = UIColor(hue: 0.25, saturation:0.5, brightness:0.5, alpha:1.0)
    public var lastMoveColor = UIColor(hue: 0.35, saturation:0.5, brightness:0.5, alpha:1.0)
    public var premoveColor = UIColor(hue: 0.15, saturation:0.5, brightness:0.5, alpha:1.0)
    public var pieceGraphicsDirectoryPath: String? = nil

    public weak var dataSource: FDChessboardViewDataSource? = nil {
        didSet {
            reloadData()
        }
    }

    public weak var delegate: FDChessboardViewDelegate? = nil

    public var doesAnimate: Bool = true
    public var doesShowLegalSquares: Bool = true
    public var doesShowLastMove: Bool = true
    public var doesShowPremove: Bool = true

    private lazy var tilesAtIndex = [UIView]()

    private var pieceAtIndex = [Int : FDChessboardPiece]()

    private var pieceImageViewAtIndex = [Int : UIImageView]()

    private var lastMoveArrow: UIView? = nil

    private var premoveArrow: UIView? = nil

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setup() {
        self.translatesAutoresizingMaskIntoConstraints = false

        for index in 0..<64 {
            let square = FDChessboardSquare(index: index)
            let tile = UIView()
            tile.backgroundColor = (index + index/8) % 2 == 0 ? darkBackgroundColor : lightBackgroundColor
            tile.translatesAutoresizingMaskIntoConstraints = false
            addSubview(tile)
            tilesAtIndex.append(tile)

            switch square.rank {
            case 0:
                addConstraint(NSLayoutConstraint(item: tile, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0))
            case 7:
                addConstraint(NSLayoutConstraint(item: tile, attribute: .Bottom, relatedBy: .Equal, toItem: tilesAtIndex[index - 8], attribute: .Top, multiplier: 1, constant: 0))
                addConstraint(NSLayoutConstraint(item: tile, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: 0))
                addConstraint(NSLayoutConstraint(item: tile, attribute: .Height, relatedBy: .Equal, toItem: tilesAtIndex[index - 8], attribute: .Height, multiplier: 1, constant: 0))
            default:
                addConstraint(NSLayoutConstraint(item: tile, attribute: .Bottom, relatedBy: .Equal, toItem: tilesAtIndex[index - 8], attribute: .Top, multiplier: 1, constant: 0))
                addConstraint(NSLayoutConstraint(item: tile, attribute: .Height, relatedBy: .Equal, toItem: tilesAtIndex[index - 8], attribute: .Height, multiplier: 1, constant: 0))
            }
            switch square.file {
            case 0:
                addConstraint(NSLayoutConstraint(item: tile, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 0))
            case 7:
                addConstraint(NSLayoutConstraint(item: tile, attribute: .Left, relatedBy: .Equal, toItem: tilesAtIndex[index - 1], attribute: .Right, multiplier: 1, constant: 0))
                addConstraint(NSLayoutConstraint(item: tile, attribute: .Right, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: 0))
                addConstraint(NSLayoutConstraint(item: tile, attribute: .Width, relatedBy: .Equal, toItem: tilesAtIndex[index - 1], attribute: .Width, multiplier: 1, constant: 0))
            default:
                addConstraint(NSLayoutConstraint(item: tile, attribute: .Left, relatedBy: .Equal, toItem: tilesAtIndex[index - 1], attribute: .Right, multiplier: 1, constant: 0))
                addConstraint(NSLayoutConstraint(item: tile, attribute: .Width, relatedBy: .Equal, toItem: tilesAtIndex[index - 1], attribute: .Width, multiplier: 1, constant: 0))
            }
        }
        self.layoutIfNeeded()
    }

    /*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
UITouch *touch = [touches anyObject];
CGPoint point = [touch locationInView:self];
NSInteger x = point.x*8/self.frame.size.width;
NSInteger y = 8-point.y*8/self.frame.size.height;
UIView *tile = self.tilesPerSquare[y*8+x];
tile.backgroundColor = self.targetBackgroundColor;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
UITouch *touch = [touches anyObject];
CGPoint point = [touch locationInView:self];
if (![self pointInside:point withEvent:event])
return;
NSInteger x = point.x*8/self.frame.size.width;
NSInteger y = 8-point.y*8/self.frame.size.height;
UIView *tile = self.tilesPerSquare[y*8+x];
tile.backgroundColor = self.legalBackgroundColor;
}
*/

    public func setPiece(piece: FDChessboardPiece?, forSquare square: FDChessboardSquare){
        let index = square.index
        pieceAtIndex[index] = piece
        self.pieceImageViewAtIndex[index]?.removeFromSuperview()
        self.pieceImageViewAtIndex.removeValueForKey(index)
        guard let piece = piece else {
            return
        }

        let pieceImageView: UIImageView
        let fileName = piece.rawValue
        let bundle = NSBundle(forClass: self.dynamicType)
        let image = UIImage(named: fileName, inBundle: bundle, compatibleWithTraitCollection: nil)
        pieceImageView = UIImageView(image: image)
        pieceImageView.translatesAutoresizingMaskIntoConstraints = false
        self.pieceImageViewAtIndex[index] = pieceImageView
        self.addSubview(pieceImageView)

        let squareOne = self.tilesAtIndex.first!
        self.addConstraint(NSLayoutConstraint(item: pieceImageView, attribute: .Width, relatedBy: .Equal, toItem: squareOne, attribute: .Width, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: pieceImageView, attribute: .Height, relatedBy: .Equal, toItem: squareOne, attribute: .Height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: pieceImageView, attribute: .Top, relatedBy: .Equal, toItem: self.tilesAtIndex[index], attribute: .Top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: pieceImageView, attribute: .Leading, relatedBy: .Equal, toItem: self.tilesAtIndex[index], attribute: .Leading, multiplier: 1, constant: 0))
        self.layoutIfNeeded()
    }

    public func reloadData() {
        for index in 0 ..< 64 {
            let square = FDChessboardSquare(index: index)
            let newPiece = dataSource?.chessboardView(self, pieceForSquare:square)
            setPiece(newPiece, forSquare: square)
        }
        self.layoutIfNeeded()
    }

    public func movePieceAtCoordinate(from: FDChessboardSquare, toCoordinate to: FDChessboardSquare) -> Bool {
        return true
    }

    public func movePieceAtCoordinate(from: FDChessboardSquare, toCoordinate to: FDChessboardSquare, andPromoteTo piece: FDChessboardPiece) -> Bool {
        return true
    }

    public func premovePieceAtCoordinate(from: FDChessboardSquare, toCoordinate to: FDChessboardSquare) -> Bool {
        return true
    }

    public func premovePieceAtCoordinate(from: FDChessboardSquare, toCoordinate to: FDChessboardSquare, andPromoteTo piece: FDChessboardPiece) -> Bool {
        return true
    }

}