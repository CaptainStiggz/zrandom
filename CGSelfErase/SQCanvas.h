#import <UIKit/UIKit.h>
#import "SQBezierPath.h"

@interface SQCanvas : UIView

- (void)touchBegan:(UITouch *)touch;
- (void)touchMoved:(UITouch *)touch;
- (void)updateDrawColor:(UIColor *)color;
- (void)reset;

@end
