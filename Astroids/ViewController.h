//
//  ViewController.h
//  Astroids
//
//  Created by iD Student on 7/1/13.
//  Copyright (c) 2013 Mike Hepfer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Asteroid.h"
#import "Missile.h"

@interface ViewController : UIViewController
{
    UIImageView *spaceShip;
    IBOutlet UIImageView * bgImage;
    BOOL upPressed, downPressed, leftPressed, rightPressed;
    int angle;
    int score;
    int pause;
    NSTimer *gameTimer;
    NSTimer *asteroidTimer;
    NSMutableArray *asteroidList;
    NSMutableArray *missileList;
    
    NSMutableArray * imageFiles;
    int imageIndex;
    
    //Pause Button Code
    IBOutlet UIButton *pauseButton;
    IBOutlet UIButton *unPauseButton;
}

-(void) gameUpdate;
-(void) checkForGameOver;
-(void) resetGame;
-(void) gameWin;

-(void) moveAsteroids;
-(void) spawnAsteroids;
-(void) breakAsteroid;

-(void) updateMissiles;
-(void) checkForMissileCollisions;
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

-(IBAction)upButtonPressed:(id)sender;
-(IBAction)downButtonressed:(id)sender;
-(IBAction)leftButtonPressed:(id)sender;
-(IBAction)rightButtonPressed:(id)sender;
-(IBAction)buttonReleased:(id)sender;

- (BOOL)checkIntersection:(Asteroid *)anAsteroid;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

//Pause Button code
- (IBAction)Pause;
- (IBAction)Resume;
-(void)pauseLayer:(CALayer*)Layer;
-(void)resumeLayer:(CALayer*)Layer;




@end
