//
//  Missile.m
//  Astroids
//
//  Created by iD Student on 7/1/13.
//  Copyright (c) 2013 Mike Hepfer. All rights reserved.
//

#import "Missile.h"

@interface Missile ()

@end

@implementation Missile

@synthesize image, velocityX, velocityY, angle;

-(id) init
{
    self.image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"missile.png"]];
    self.image.tag = 100; //this is the tag number we'll use to remove all missiles from the screen
    self.velocityX = 0;
    self. velocityY = 0;
    self.angle = 0;
    return self;
}

@end
