//
//  Missile.h
//  Astroids
//
//  Created by iD Student on 7/1/13.
//  Copyright (c) 2013 Mike Hepfer. All rights reserved.
//

#import <UIKit/UIKit.h>

// for the cerod, this should never have been a UIViewController, so even though
// that probably won't fix the problem in itself, you shouldn't change it back!
@interface Missile : NSObject
{
    UIImageView* image;
    int valocityX, velocityY;
    int angle;
}
- (id) init;

@property(nonatomic, retain) UIImageView *image;
@property(nonatomic, readwrite) int velocityX, velocityY, angle;

@end
