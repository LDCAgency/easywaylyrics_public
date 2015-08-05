//
//  LoadingAnimationDrawing.m
//  EasyWayLyrics
//
//  Created by Paulo Miguel Almeida on 5/19/14.
//  Copyright (c) 2014 Loducca Publicidade. All rights reserved.
//

#import "LoadingAnimationDrawing.h"

@interface LoadingAnimationDrawing()

@property(nonatomic,strong) UIColor *backgroundColor;

@end

@implementation LoadingAnimationDrawing

UIColor *backgroundColor;
int sizeOfFirstEllipse = 160;
int widthEllipseBorder = 8;

#pragma mark - UIViewController lifecycle methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)awakeFromNib{
    backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [backgroundColor setFill];
    UIRectFill( rect );
    
    if (self.showLevel == 7) {
        [self showLevel:1 InRect:rect AndContext:context];
    }
    if (self.showLevel == 6) {
        [self showLevel:2 InRect:rect AndContext:context];
        [self showLevel:1 InRect:rect AndContext:context];
    }
    if (self.showLevel == 5) {
        [self showLevel:3 InRect:rect AndContext:context];
        [self showLevel:2 InRect:rect AndContext:context];
        [self showLevel:1 InRect:rect AndContext:context];
    }
    
    if (self.showLevel == 4) {
        [self showLevel:4 InRect:rect AndContext:context];
        [self showLevel:3 InRect:rect AndContext:context];
        [self showLevel:2 InRect:rect AndContext:context];
        [self showLevel:1 InRect:rect AndContext:context];
    }
    
    if (self.showLevel == 3) {
        [self showLevel:3 InRect:rect AndContext:context];
        [self showLevel:2 InRect:rect AndContext:context];
        [self showLevel:1 InRect:rect AndContext:context];
    }
    if (self.showLevel == 2) {
        [self showLevel:2 InRect:rect AndContext:context];
        [self showLevel:1 InRect:rect AndContext:context];
    }
    
    if (self.showLevel == 1) {
        [self showLevel:1 InRect:rect AndContext:context];
    }
    
}

-(void) draw:(CGContextRef) context Ellipse:(CGRect) rect WithColor:(UIColor*) color
{
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    [color set];
    CGContextFillEllipseInRect(context, rect);
}

-(void) draw:(CGContextRef) context Ellipse:(CGRect) rect
{
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] set];
    CGContextFillEllipseInRect(context, rect);
}

#pragma mark - UI Methods

-(void) showNextLevel
{
    if ((self.showLevel + 1) > 8 )
    {
        self.showLevel = 0;
    }
    self.showLevel++;
    [self setNeedsDisplay];
}

-(void)clearLevel
{
    self.showLevel = 0;
    [self setNeedsDisplay];
}

-(void) showLevel:(int) level InRect:(CGRect) rect AndContext:(CGContextRef) context
{
    if (level == 4) {
        /** Third Level **/
        CGRect thirdLevelEllipse = CGRectMake(
                                              ((rect.size.width - sizeOfFirstEllipse) / 2) - (widthEllipseBorder * 6) ,
                                              ((rect.size.height - sizeOfFirstEllipse) / 2) - (widthEllipseBorder * 6),
                                              sizeOfFirstEllipse + (widthEllipseBorder * 12),
                                              sizeOfFirstEllipse + (widthEllipseBorder * 12));
        [self logCGRectInfo:thirdLevelEllipse WithMessage:@"thirdLevelEllipse"];
        
        CGRect thirdLevelInnerEllipse = CGRectMake(
                                                   thirdLevelEllipse.origin.x + widthEllipseBorder,
                                                   thirdLevelEllipse.origin.y + widthEllipseBorder,
                                                   thirdLevelEllipse.size.width - widthEllipseBorder*2,
                                                   thirdLevelEllipse.size.height - widthEllipseBorder*2);
        [self logCGRectInfo:thirdLevelInnerEllipse WithMessage:@"thirdLevelInnerEllipse"];
        [self draw:context Ellipse:thirdLevelEllipse];
        [self draw:context Ellipse:thirdLevelInnerEllipse WithColor:backgroundColor];
    }
    
    if (level == 3) {
        /** Second Level **/
        CGRect secondLevelEllipse = CGRectMake(
                                               ((rect.size.width - sizeOfFirstEllipse) / 2) - (widthEllipseBorder * 4) ,
                                               ((rect.size.height - sizeOfFirstEllipse) / 2) - (widthEllipseBorder * 4),
                                               sizeOfFirstEllipse + (widthEllipseBorder * 8),
                                               sizeOfFirstEllipse + (widthEllipseBorder * 8));
        [self logCGRectInfo:secondLevelEllipse WithMessage:@"secondLevelEllipse"];
        
        CGRect secondLevelInnerEllipse = CGRectMake(
                                                    secondLevelEllipse.origin.x + widthEllipseBorder,
                                                    secondLevelEllipse.origin.y + widthEllipseBorder,
                                                    secondLevelEllipse.size.width - widthEllipseBorder*2,
                                                    secondLevelEllipse.size.height - widthEllipseBorder*2);
        [self logCGRectInfo:secondLevelInnerEllipse WithMessage:@"secondLevelInnerEllipse"];
        [self draw:context Ellipse:secondLevelEllipse];
        [self draw:context Ellipse:secondLevelInnerEllipse WithColor:backgroundColor];
        
    }
    
    if (level == 2) {
        /** First Level **/
        CGRect firstLevelEllipse = CGRectMake(
                                              ((rect.size.width - sizeOfFirstEllipse) / 2) - (widthEllipseBorder * 2) ,
                                              ((rect.size.height - sizeOfFirstEllipse) / 2) - (widthEllipseBorder * 2),
                                              sizeOfFirstEllipse + (widthEllipseBorder * 4),
                                              sizeOfFirstEllipse + (widthEllipseBorder * 4));
        [self logCGRectInfo:firstLevelEllipse WithMessage:@"firstLevelEllipse"];
        
        CGRect firstLevelInnerEllipse = CGRectMake(
                                                   firstLevelEllipse.origin.x + widthEllipseBorder,
                                                   firstLevelEllipse.origin.y + widthEllipseBorder,
                                                   firstLevelEllipse.size.width - widthEllipseBorder*2,
                                                   firstLevelEllipse.size.height - widthEllipseBorder*2);
        [self logCGRectInfo:firstLevelInnerEllipse WithMessage:@"firstLevelInnerEllipse"];
        
        [self draw:context Ellipse:firstLevelEllipse];
        [self draw:context Ellipse:firstLevelInnerEllipse WithColor:backgroundColor];
    }
    
    if (level == 1) {
        /** Base Level */
        CGRect baseEllipse = CGRectIntersection( CGRectMake(
                                                            (rect.size.width - sizeOfFirstEllipse) / 2,
                                                            (rect.size.height - sizeOfFirstEllipse) / 2,
                                                            sizeOfFirstEllipse,
                                                            sizeOfFirstEllipse), rect );
        [self logCGRectInfo:baseEllipse WithMessage:@"baseEllipse"];
        
        CGRect baseInnerEllipse = CGRectMake(
                                             baseEllipse.origin.x + widthEllipseBorder,
                                             baseEllipse.origin.y + widthEllipseBorder,
                                             baseEllipse.size.width - widthEllipseBorder*2,
                                             baseEllipse.size.height - widthEllipseBorder*2);
        [self logCGRectInfo:baseEllipse WithMessage:@"baseInnerEllipse"];
        
        
        
        [self draw:context Ellipse:baseEllipse];
        [self draw:context Ellipse:baseInnerEllipse WithColor:backgroundColor];
    }
}

#pragma mark - Utility methods

-(void) logCGRectInfo:(CGRect) rect WithMessage: (NSString*) baseMessage
{
#ifdef DEBUG
//    NSLog(@"%s %@ base x: %f y:%f width: %f height: %f",__PRETTY_FUNCTION__,baseMessage, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
#endif
}

@end
