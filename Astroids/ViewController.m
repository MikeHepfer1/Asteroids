//
//  ViewController.m
//  Astroids
//
//  Created by iD Student on 7/1/13.
//  Copyright (c) 2013 Mike Hepfer. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()



@end

@implementation ViewController

@synthesize scoreLabel;

- (void)viewDidLoad
{
    imageIndex = 0;
    imageFiles = [NSMutableArray arrayWithArray:@[@"space.jpeg"]];
    for (int i = 2; i < 10; i++) {
        NSString * fileName = [NSString stringWithFormat:@"Space%d.jpeg", i];
        [imageFiles addObject:fileName];
    }

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(gameUpdate) userInfo:nil repeats:YES];
    asteroidTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(spawnAsteroids) userInfo:nil repeats:YES];
    angle = -90;
    asteroidList = [[NSMutableArray alloc] init];
    missileList = [NSMutableArray array];
    score = 0;
    
    spaceShip = [[UIImageView alloc] initWithFrame:CGRectMake(spaceShip.frame.size.width - 15, spaceShip.frame.size.width + 15, 32, 32)];
    spaceShip.tag = 100; //the mark-for-removal tag
    [spaceShip setImage:[UIImage imageNamed:@"spaceship.png"]];
    spaceShip.transform = CGAffineTransformMakeRotation(angle);
    // this is the initial center that the ship will have
    spaceShip.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    spaceShip.transform = CGAffineTransformMakeRotation(-M_PI/2);
    spaceShip.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:spaceShip];
    
    //PauseButton code
    [unPauseButton setHidden:YES];
    [pauseButton setHidden:YES];
}

- (IBAction)upButtonPressed:(id)sender;
{
    upPressed = YES;
    NSLog(@"x = %f y = %f", spaceShip.center.x, spaceShip.center.y);
}

- (IBAction)downButtonressed:(id)sender;
{
    downPressed = YES;
    NSLog(@"x = %f y = %f", spaceShip.center.x, spaceShip.center.y);
}

- (IBAction)leftButtonPressed:(id)sender;
{
    leftPressed = YES;
    NSLog(@"x = %f y = %f", spaceShip.center.x, spaceShip.center.y);
}

- (IBAction)rightButtonPressed:(id)sender;
{
    rightPressed = YES;
    NSLog(@"x = %f y = %f", spaceShip.center.x, spaceShip.center.y);
}

- (IBAction)buttonReleased:(id)sender;
{
    upPressed = NO;
    downPressed = NO;
    leftPressed = NO;
    rightPressed = NO;
}

-(void)gameUpdate
{
    scoreLabel.text = [NSString stringWithFormat:@"Score: %d", score];
    if (upPressed)
    {
        spaceShip.center = CGPointMake(spaceShip.center.x + 5 * cos(angle * M_PI/180), spaceShip.center.y + 5 * sin(angle * M_PI/180));
    }
    if (downPressed)
    {
        spaceShip.center = CGPointMake(spaceShip.center.x + -5 * cos(angle * M_PI/180), spaceShip.center.y + -5 * sin(angle * M_PI/180));
    }
    
    
    if (rightPressed)
    {
        angle += 5;
        spaceShip.layer.transform = CATransform3DMakeRotation(angle * M_PI/180, 0, 0, 1);
        
    }
    if (leftPressed)
    {
        angle -= 5;
        spaceShip.layer.transform = CATransform3DMakeRotation(angle * M_PI/180, 0, 0, 1);
    }
    
    float newCenterX = spaceShip.center.x;
    float newCenterY = spaceShip.center.y;
    
    if(spaceShip.center.x > 320)
    {
        newCenterX = 1;
    }
    else if(spaceShip.center.x < 0)
    {
        newCenterX = 319;
    }
    if(spaceShip.center.y > 480)
    {
        newCenterY = 1;
    }
    else if(spaceShip.center.y < 0)
    {
        newCenterY = 479;
    }
    spaceShip.center = CGPointMake(newCenterX, newCenterY);
    [self moveAsteroids];
    [self updateMissiles];
    [self checkForGameOver];
    
}

-(void) moveAsteroids
{
    for(int i = 0; i < asteroidList.count; i++)
    {
        Asteroid *ast = [asteroidList objectAtIndex:i];
        CGPoint oldCenter = ast.image.center;
        ast.image.center = CGPointMake(oldCenter.x + ast.velocityX, oldCenter.y + ast.velocityY);
    }
    for(int i = 0; i < asteroidList.count; i++)
    {
        Asteroid *ast = [asteroidList objectAtIndex:i];
        CGPoint oldCenter = ast.image.center;
        ast.image.center = CGPointMake(oldCenter.x + ast.velocityX, oldCenter.y + ast.velocityY);
        CGRect astRect = ast.image.frame;
        if(astRect.origin.x > 320)
        {
            astRect.origin.x = 1-astRect.size.width;
        }
        else if((astRect.origin.x + astRect.size.width) < 0)
        {
            astRect.origin.x = 319;
        }
        if(astRect.origin.y > 480)
        {
            astRect.origin.y = 1-astRect.size.height;
        }
        else if((astRect.origin.y + astRect.size.height) < 0)
        {
            astRect.origin.y = 479;
        }
        ast.image.frame = astRect;
    }
}

-(void) spawnAsteroids
{
    for(int i = 0; i < 5; i++)
    {
        Asteroid *ast = [[Asteroid alloc] init];
        [ast randomizeVelocity];
        [asteroidList addObject:ast];
        [ast makeLarge];
        [self.view addSubview:ast.image];
    }
}
- (void) checkForMissileCollisions
{
    int i =0;
    while(i < missileList.count)
    {
        Missile *missile = [missileList objectAtIndex:i];
        int j = 0;
        CGRect missileRect = missile.image.frame;
        
        BOOL collided = NO;
        while(j < asteroidList.count)
        {
            Asteroid *ast = [asteroidList objectAtIndex:j];
            CGRect astRect = ast.image.frame;
            if(CGRectIntersectsRect(missileRect, astRect))
            {
                score += ast.scoreValue;
                [asteroidList removeObject:ast];
                [missileList removeObject:missile];
                [ast.image removeFromSuperview];
                [missile.image removeFromSuperview];
                collided = YES;
                [self breakAsteroid:ast];
                break;
            }
            else
            {
                j++;
            }
        }
        if(collided == NO)
        {
            i++;
        }
    }
}

-(void) updateMissiles
{
    [self checkForMissileCollisions];
    int i =0;
    while(i < missileList.count)
    {
        Missile *missile = [missileList objectAtIndex:i];
        
        CGPoint oldCenter = missile.image.center;
        if(oldCenter.x > 320 || oldCenter.x < 0 || oldCenter.y > 480 || oldCenter.y < 0)
        {
            [missile.image removeFromSuperview];
            [missileList removeObject:missile];
        }
        else
        {
            missile.image.center = CGPointMake(oldCenter.x + missile.velocityX, oldCenter.y + missile.velocityY);
            i++;
        }
    }
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(gameTimer == nil)
    {
        [self resetGame];
    }
    else
    {
        Missile *newMissile = [[Missile alloc] init];
        newMissile.image.center = spaceShip.center;
        newMissile.velocityX = 8 * cos(angle * M_PI/180);
        newMissile.velocityY = 8 * sin(angle * M_PI/180);
        newMissile.image.layer.transform = CATransform3DMakeRotation((angle * M_PI/180) + M_PI/2, 0, 0, 1);
        [missileList addObject:newMissile];
        [self.view addSubview:newMissile.image];
    }
}

-(void)breakAsteroid:(Asteroid*)asteroid
{
    if(asteroid.size == 3)
    {
        Asteroid *medAst1 = [[Asteroid alloc] init];
        [medAst1 makeMedium];
        [medAst1 randomizeVelocity];
        medAst1.image.center = asteroid.image.center;
        Asteroid *medAst2 = [[Asteroid alloc] init];
        [medAst2 makeMedium];
        [medAst2 randomizeVelocity];
        medAst2.image.center = asteroid.image.center;
        [asteroidList addObject:medAst1];
        [asteroidList addObject:medAst2];
        [self.view addSubview:medAst1.image];
        [self.view addSubview:medAst2.image];
    }
    else if(asteroid.size == 2)
    {
        Asteroid *smallAst1 = [[Asteroid alloc] init];
        [smallAst1 makeSmall];
        [smallAst1 randomizeVelocity];
        smallAst1.image.center = asteroid.image.center;
        Asteroid *smallAst2 = [[Asteroid alloc] init];
        [smallAst2 makeSmall];
        [smallAst2 randomizeVelocity];
        smallAst2.image.center = asteroid.image.center;
        [asteroidList addObject:smallAst1];
        [asteroidList addObject:smallAst2];
        [self.view addSubview:smallAst1.image];
        [self.view addSubview:smallAst2.image];
    }
    else if(asteroid.size == 1)
    {
        //do nothing
    }
}

-(void)checkForGameOver
{
        for(int i = 0; i < asteroidList.count; i++)
    {
        Asteroid *ast = [asteroidList objectAtIndex:i];
        if([self checkIntersection:ast])
        {
            [gameTimer invalidate];
            [asteroidTimer invalidate];
            NSLog(@"COLLISION GAME OVER!!");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over Tap Anywhere to Play Again" message:[NSString stringWithFormat:@"Score: %d",score] delegate:self cancelButtonTitle:@"close" otherButtonTitles:nil];
            [alert show];
            break;
        }
    }
}

- (BOOL)checkIntersection:(Asteroid *)anAsteroid {
    CGPoint astCenter = anAsteroid.image.center;
    CGPoint shipCenter = spaceShip.center;
    CGFloat distance = sqrt(pow(astCenter.x - shipCenter.x, 2) + pow(astCenter.y - shipCenter.y, 2));
    if (distance > 45) {
        return NO;
    }
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView.title isEqualToString: @"Game Over Tap Anywhere to Play Again"]){
        if (buttonIndex == 0)
        {
            [self resetGame];
        }
        else if (buttonIndex == 1)
        {
            // No
        }
    }
}

- (void)resetGame
{
    //this removes all missiles, asteroids, and the old ship position
    for(UIView* sub in [self.view subviews]){
        if([sub isKindOfClass:[UIImageView class]]){
            UIImageView* removeMe = ((UIImageView*)sub);
            if(removeMe.tag == 100){
                [removeMe removeFromSuperview];
            }
        }
    }
    
    [asteroidList removeAllObjects];
    [missileList removeAllObjects];
    
    score = 0;
    angle = -90;
    spaceShip = [[UIImageView alloc] initWithFrame:CGRectMake(spaceShip.frame.size.width - 15, spaceShip.frame.size.width + 15, 32, 32)];
    spaceShip.tag = 100;
    [spaceShip setImage:[UIImage imageNamed:@"spaceship.png"]];
    // this is the initial center that the ship will have
    spaceShip.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    spaceShip.transform = CGAffineTransformMakeRotation(-M_PI/2);
    spaceShip.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:spaceShip];
    
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(gameUpdate) userInfo:nil repeats:YES];
    asteroidTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(spawnAsteroids) userInfo:nil repeats:YES];
    
    upPressed = NO;
    downPressed = NO;
    leftPressed = NO;
    rightPressed = NO;
    
    imageIndex++;
    if (imageIndex >= [imageFiles count]) {
        imageIndex = 0;
    }
    NSString * fileName = [imageFiles objectAtIndex:imageIndex];
    UIImage * image = [UIImage imageNamed:fileName];
    bgImage.image = image;
    
}

- (void)gameWin
{
    if(asteroidList == 0)
    {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Win! Tap to Play Again" message:[NSString stringWithFormat:@"Score: %d",score] delegate:self cancelButtonTitle:@"Restart" otherButtonTitles:nil];
        [alert show];
    }
}

//Pause Button code

-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

-(IBAction)pauseButton{
	[self pauseLayer:self.view.layer];
}

-(IBAction)resumeButton{
	[self resumeLayer:self.view.layer];
}







- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
