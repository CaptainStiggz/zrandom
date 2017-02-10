// https://code.tutsplus.com/tutorials/smooth-freehand-drawing-on-ios--mobile-13164

#import "SQCanvas.h"

@implementation SQCanvas {
    SQBezierPath *path;
    SQBezierPath *eraser;
    UIImage *incrementalImage;
    UIColor *drawColor;
}

- (id)init {
    self = [super init];
    if (self) {
        [self setMultipleTouchEnabled:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        path = [SQBezierPath bezierPath];
        [path setLineWidth:4.0];
        eraser = [SQBezierPath bezierPath];
        [eraser setLineWidth:4.5];
        drawColor = [UIColor blackColor];
    }
    return self;
}

- (void)updateDrawColor:(UIColor *)color {
    drawColor = color;
}

- (void)drawRect:(CGRect)rect {
    [[drawColor colorWithAlphaComponent:0.5] setStroke];
    [path stroke];
    
    [[UIColor whiteColor] setStroke];
    [eraser stroke];
}

- (void)touchBegan:(UITouch *)touch {
    [path beginWithPoint:[touch locationInView:self]];
    [eraser beginWithPoint:[touch locationInView:self]];
}

- (void)touchMoved:(UITouch *)touch {
    CGPoint p = [touch locationInView:self];
    [path addNextPoint:p];
    [self setNeedsDisplay];
    
    double delayInSeconds = 0.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [eraser addNextPoint:p];
        [self setNeedsDisplay];
    });
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

- (void)reset {
    [path removeAllPoints];
    [eraser removeAllPoints];
}

@end
