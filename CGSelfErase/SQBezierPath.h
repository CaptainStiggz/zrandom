#import <UIKit/UIKit.h>

@interface SQBezierPath : UIBezierPath

- (void)beginWithPoint:(CGPoint)p;
- (void)addNextPoint:(CGPoint)p;

@end
