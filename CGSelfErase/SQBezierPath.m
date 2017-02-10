// https://code.tutsplus.com/tutorials/smooth-freehand-drawing-on-ios--mobile-13164

#import "SQBezierPath.h"

@implementation SQBezierPath {
    CGPoint pts[5]; // we now need to keep track of the four points of a Bezier segment and the first control point of the next segment
    uint ctr;
}

- (void)beginWithPoint:(CGPoint)p {
    ctr = 0;
    pts[0] = p;
}

- (void)addNextPoint:(CGPoint)p {
    ctr++;
    pts[ctr] = p;
    if (ctr == 4) {
        pts[3] = CGPointMake((pts[2].x + pts[4].x)/2.0, (pts[2].y + pts[4].y)/2.0); // move the endpoint to the middle of the line joining the second control point of the first Bezier segment and the first control point of the second Bezier segment
        
        [self moveToPoint:pts[0]];
        [self addCurveToPoint:pts[3] controlPoint1:pts[1] controlPoint2:pts[2]]; // add a cubic Bezier from pt[0] to pt[3], with control points pt[1] and pt[2]
        
        // replace points and get ready to handle the next segment
        pts[0] = pts[3];
        pts[1] = pts[4];
        ctr = 1;
    }
}

@end
