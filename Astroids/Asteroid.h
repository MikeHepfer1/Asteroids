///Users/Student/MikeHepfer1_Projects/Astroids/Astroids/Asteroid.m
//  Astroid.h
//  Astroids
//
//  Created by iD Student on 7/1/13.
//  Copyright (c) 2013 Mike Hepfer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Asteroid : NSObject
{
    UIImageView* image;
    int scoreValue;
    int size;
    
    float velocityX, velocityY;
}
-(id) init;
-(void) randomizeVelocity;
-(void) makeLarge;
-(void) makeMedium;
-(void) makeSmall;

@property(nonatomic, retain) UIImageView *image;
@property(nonatomic, readwrite) int scoreValue;
@property(nonatomic, readwrite) float velocityX, velocityY;
@property(nonatomic, readwrite) int size;

@end
