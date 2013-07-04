//
//  Astroid.m
//  Astroids
//
//  Created by iD Student on 7/1/13.
//  Copyright (c) 2013 Mike Hepfer. All rights reserved.
//

#import "Asteroid.h"

@interface Asteroid ()

@end

@implementation Asteroid

@synthesize image, velocityX, velocityY, scoreValue, size;

- (id) init
{
    self.image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"asteroid.png"]];
    self.image.tag = 100; //this is the tag number we'll use to remove all asteroids from the screen
    self.velocityX = 0;
    self.velocityY = 0;
    scoreValue = 5;
    return self;
}

-(void) randomizeVelocity
{
    velocityX = arc4random() % 6 - 3;
    velocityY = arc4random() % 6 - 3;
}
-(void) makeLarge
{
    CGRect oldRect = self.image.frame;
    self.image.frame = CGRectMake(arc4random() % 320, oldRect.origin.y, 64, 64);
    size = 3;
}
-(void) makeMedium
{
    CGRect oldRect = self.image.frame;
    self.image.frame = CGRectMake(oldRect.origin.x, oldRect.origin.y, 32, 32);
    size = 2;
}
-(void) makeSmall
{
    CGRect oldRect = self.image.frame;
    self.image.frame = CGRectMake(oldRect.origin.x, oldRect.origin.y, 16, 16);
    size = 1;
}

@end
