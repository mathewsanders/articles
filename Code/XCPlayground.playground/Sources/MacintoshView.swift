import UIKit

/// A coordinate pair
typealias Coordinate = (x: CGFloat, y: CGFloat)

/// Creates a UIBezierPath from a list of Coordinate tuples
///
/// :param: coordinates An array of Coordinate tuples
/// :returns: A UIBezierPath that starts with the first tuple in `coordinates`
/// and draws a line through each successive Coordinate.
func pathFromPoints(coordinates: [Coordinate]) -> UIBezierPath {
    let path = UIBezierPath()
    if let first = coordinates.first {
        path.move(to: CGPoint(x: first.x, y: first.y))
        for coordinate in coordinates.dropFirst() {
            path.addLine(to: CGPoint(x: coordinate.x, y: coordinate.y))
        }
    }
    
    path.apply(CGAffineTransform(translationX: 0.5, y: 0.5))
    return path
}

/// Nostalgia in UIView form.
public class MacintoshView : UIView {
    
    /// A list of shapes to draw, each stored as a list of Coordinate tuples
    let shapes: [[Coordinate]] = [
        [(3, 26), (3, 2), (5, 0), (25, 0), (27, 2), (27, 26)],
        [(7, 3), (22, 3), (23, 4), (23, 16), (22, 17), (7, 17), (6, 16), (6, 4)],
        [(4, 27), (26, 27), (26, 31), (4, 31), (4, 27)],
        [(6, 23), (7, 23)],
        [(18, 22), (23, 22)]
    ]
    
    /// A list of bezier paths that make up the Macintosh icon
    var paths: [UIBezierPath] {
        return shapes.map(pathFromPoints)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        for path in paths {
            path.stroke()
        }
    }
}

