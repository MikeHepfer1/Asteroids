//
//  SillySubclass.m
//  Astroids
//
//  Created by iD Student on 7/3/13.
//  Copyright (c) 2013 Mike Hepfer. All rights reserved.
//

#import "SillySubclass.h"

@implementation SillySubclass

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setCenter:(CGPoint)center {
    if (center.x == 160 && center.y == 212) {
        NSLog(@"someone's evil.");
    }
    [super setCenter:center];
    return;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
