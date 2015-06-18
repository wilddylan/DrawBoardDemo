# DrawBoardDemo

UIBezierPath 简介:

使用`UIBezierPath`类可以创建基于矢量的路径。此类是`Core Graphics`框架关于path的一个封装。使用此类可以定义简单的形状，如椭圆或者矩形，或者有多个直线和曲线段组成的形状。
    
1.Bezier Path 基础
   `UIBezierPath`对象是CGPathRef数据类型的封装。path如果是基于矢量形状的，都用直线和曲线段去创建。我们使用直线段去创建矩形和多边形，使用曲线段去创建弧（arc），圆或者其他复杂的曲线形状。每一段都包括一个或者多个点，绘图命令定义如何去诠释这些点。每一个直线段或者曲线段的结束的地方是下一个的开始的地方。每一个连接的直线或者曲线段的集合成为subpath。一个`UIBezierPath`对象定义一个完整的路径包括一个或者多个subpaths。

   创建和使用一个path对象的过程是分开的。创建path是第一步，包含一下步骤：
- 创建一个path对象。
- 使用方法`moveToPoint:`去设置初始线段的起点。
- 添加line或者curve去定义一个或者多个subpaths。
- 改变`UIBezierPath`对象跟绘图相关的属性。例如，我们可以设置`stroked path`的属性`lineWidth`和`lineJoinStyle`。也可以设置filled path的属性`usesEvenOddFillRule`。

   当创建path，我们应该管理path上面的点相对于原点（0，0），这样我们在随后就可以很容易的移动path了。为了绘制path对象，我们要用到stroke和fill方法。这些方法在`current graphic context`下渲染path的line和curve段。


2.在path下面添加线或者多边形。
线和多边形是一些简单的形状，我们可以用`moveToPoint:`或者`addLineToPoint:`方法去构建。方法`moveToPoint:`设置我们想要创建形状的起点。从这点开始，我们可以用方法`addLineToPoint:`去创建一个形状的线段。我们可以连续的创建line，每一个line的起点都是先前的终点，终点就是指定的点。

逻辑构造：
DLPaintView: 画板
DLDrawShape: 工具

我这里只实现了3中工具 矩形 椭圆 线 线宽 颜色, 还有很多的工具大家可以自己加了试一下。 按照官方的注释。

```objc
```

DLPaint.h

```objc
#import "DLDarwShape.h"

//! @abstract DLPaint View
@interface DLPaintView : UIView

//! @abstract Shape Array With Shape objects

/*!
 *  Add New Shape Object When Touch begin, Change ShapeObject.bezierPath.
 */
@property (nonatomic, strong) NSMutableArray *allShape;

//! @abstract Darw Shape type
@property (nonatomic, assign) DLPaintShapeType dType;

//! @abstract Darw Line Width
@property (nonatomic, assign) CGFloat lineWidth;

//! @abstract Draw Linw Color
@property (nonatomic, strong) UIColor * drawColor;

/*!
 *  un do last step
 */
- (void)backout;

/*!
 *  clean white board
 */
- (void)cleanBoard;

@end

```

DLPaintView.m

```objc
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

```

DLDrawShape:

.h

```objc
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, DLPaintShapeType){

    DLPAINT_LINE = 1UL << 0,
    DLPAINT_RECT = 1UL << 1,
    DLPAINT_OVAL = 1UL << 2
};

//! @abstract Shape Base Object
@interface DLDarwShape : NSObject

//! @abstract stroke Color for shape obejct
@property (nonatomic, strong) UIColor *strokeColor;

//! @abstract Stroke width for shape object
@property (nonatomic, assign) CGFloat strokewidth;

//! @abstract Shape Start point
@property (nonatomic, assign) CGPoint startPoint;

//! @abstract The bezier
@property (nonatomic, retain) UIBezierPath *bezierPath;

//! @abstract Type
@property (nonatomic, assign) DLPaintShapeType paintType;

//! @abstract path array
@property (nonatomic, strong) NSMutableArray * pathArray;

/*!
 *  Load Shape With start point and type
 *
 *  @param start     touch begin Point
 *  @param pType     shape type
 *  @param color     shape object . bezierPath strokeColor
 *  @param lineWidth shape object . bezierPath strokewidth
 *
 *  @return instance for shape object
 */
- (instancetype)initWithStartPoint: (CGPoint)start
                         paintType: (DLPaintShapeType)pType
                             color: (UIColor *)color
                         lineWidth: (CGFloat)strokeWidth;
/*!
 *  Draw
 */
- (void)Draw;

@end

@interface DLDrawPointHandle : NSObject

/*!
 *  Handle Shape Object Action
 *
 *  @param shape   Shape Object
 *  @param cuPoint current point, When Touch moved
 */
+ (void)OperateShapeAction: (DLDarwShape *)shape currentPoint: (CGPoint)cuPoint;

@end

```

.m

```objc
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

```

效果： 


![屏幕快照 2015-06-18 下午2.09.31.png](http://upload-images.jianshu.io/upload_images/144590-e7601b323adfb212.png)


copyRight@Wild Dylan. 2015-6-18
