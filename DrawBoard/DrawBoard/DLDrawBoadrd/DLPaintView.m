//
//  DLPaintView.m
//  
//
//  Created by XueYulun on 15/6/18.
//
//

#import "DLPaintView.h"
#import "DLDarwShape.h"

@implementation DLPaintView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self DefaultInit];
    }
    return self;
}

- (void)awakeFromNib {
    
    [self DefaultInit];
}

- (void)DefaultInit {
    
    _dType = DLPAINT_LINE;
    _lineWidth = 2;
    _drawColor = [UIColor blackColor];
}

// - //

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint startPoint = [[touches anyObject] locationInView:self];
    DLDarwShape * shape = [[DLDarwShape alloc] initWithStartPoint:startPoint paintType:_dType color:_drawColor lineWidth:_lineWidth];
    
    [_allShape addObject:shape];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint currentPoint = [[touches anyObject] locationInView:self];
    [DLDrawPointHandle OperateShapeAction:_allShape.lastObject currentPoint:currentPoint];
    
    [self setNeedsDisplay];
}

// - //

- (void)drawRect:(CGRect)rect {
    
    [self.allShape enumerateObjectsUsingBlock:^(DLDarwShape * ShapeObject, NSUInteger idx, BOOL *stop) {
        
        [ShapeObject Draw];
    }];
}

- (void)backout {
    
    [self.allShape removeLastObject];
    [self setNeedsDisplay];
}

- (void)cleanBoard {
    
    [self.allShape removeAllObjects];
    [self setNeedsDisplay];
}

- (NSMutableArray *)allShape {
    
    if (!_allShape) {
        
        _allShape = [NSMutableArray array];
    }
    
    return _allShape;
}

@end
