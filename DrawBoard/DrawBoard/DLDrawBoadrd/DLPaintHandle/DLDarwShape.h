//
//  DLDarwShape.h
//  
//
//  Created by XueYulun on 15/6/18.
//
//

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
