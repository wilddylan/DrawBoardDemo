//
//  ;
//  
//
//  Created by XueYulun on 15/6/18.
//
//

#import "DLDarwShape.h"

@implementation DLDarwShape

- (instancetype)initWithStartPoint: (CGPoint)start
                         paintType: (DLPaintShapeType)pType
                             color: (UIColor *)color
                         lineWidth: (CGFloat)strokeWidth {
    
    
    self = [super init];
    if (self) {
        
        _startPoint = start;
        _paintType = pType;
        
        _strokeColor = color;
        _strokewidth = strokeWidth;
        
        _bezierPath = [UIBezierPath bezierPath];
        
        [_bezierPath setLineJoinStyle:kCGLineJoinRound];
        [_bezierPath setLineCapStyle:kCGLineCapRound];
        [_bezierPath moveToPoint:_startPoint];
    }
    return self;
}

- (NSMutableArray *)pathArray {
    
    if (!_pathArray) {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}

- (void)Draw {
    
    [_strokeColor setStroke];
    _bezierPath.lineWidth = _strokewidth;
    [_bezierPath stroke];
}

@end

@implementation DLDrawPointHandle

+ (void)OperateShapeAction:(DLDarwShape *)shape currentPoint:(CGPoint)cuPoint {
    
    switch (shape.paintType) {
        case DLPAINT_LINE:
            
            [shape.bezierPath addLineToPoint:cuPoint];
            break;
        case DLPAINT_OVAL:
            
            shape.bezierPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(shape.startPoint.x, shape.startPoint.y, cuPoint.x - shape.startPoint.x, cuPoint.y - shape.startPoint.y)];
            break;
            
        case DLPAINT_RECT:
            
            shape.bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(shape.startPoint.x, shape.startPoint.y, cuPoint.x - shape.startPoint.x, cuPoint.y - shape.startPoint.y)];
            break;
            
        default:
            break;
    }
    
    [shape.pathArray addObject:[NSValue valueWithCGPoint:cuPoint]];
}

@end
