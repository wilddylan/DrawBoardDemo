//
//  DLPaintView.h
//  
//
//  Created by XueYulun on 15/6/18.
//
//

#import <UIKit/UIKit.h>

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
