//
//  HelloWorldLayer.m
//  BowHunting
//
//  Created by tang on 12-9-24.
//  Copyright tang 2012年. All rights reserved.
//


// Import the interfaces
#import "GameMain.h"
#import "GameOver.h"
#import "Clouds.h"
#import "GameIntro.h"
#import "Clouds.h"
#import "BowArrow.h"
#import "Bird.h"
#import "SwitchButton.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation

CGSize ws;
@implementation GameMain
@synthesize skyBG,sun,ground2,ground1,clouds,br,gameUICMC,scoreMC,timeMC,birdCMC,num_arrows,currentSpeed,speedPlus,birdsArr,musicIsOn;
@synthesize num_objects,timeText,scoreText,musicBtn,currentArrow,arrowsArr,infoText,shootAble,birdsAreCreated,birdsShootedNum,score,theTime,limitTime,currentLevel,gameOverLayer;
// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene:(BOOL)gbmIsOn
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameMain *layer = [[GameMain alloc]initWithBOOL:gbmIsOn];
	
   
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) initWithBOOL:(BOOL)bgmIsOn
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        self.musicIsOn=bgmIsOn;
         self.isTouchEnabled=YES;
        
		ws=[[CCDirector sharedDirector]winSize];
        
        
        /////////////
        self.birdsAreCreated=NO;
        self.currentSpeed=1.0f;
        self.speedPlus=0.1f;
        self.num_arrows=20;
        self.num_objects=6;
        self.limitTime=60;
        
        //////////////
        self.skyBG=[CCSprite spriteWithFile:@"sky.jpg"];
        self.skyBG.position=ccp(ws.width/2,ws.height/2);
        [self addChild:self.skyBG];
        
        self.sun=[CCSprite spriteWithSpriteFrameName:@"sun.png"];
        self.sun.position=ccp(100,ws.height-60);
        [self addChild:self.sun];
        
        self.clouds=[[Clouds alloc]init];
        self.clouds.position=ccp(0,ws.height);
        [self addChild:self.clouds];
        
        self.ground2=[CCSprite spriteWithFile:@"ground2.png"];
        self.ground2.anchorPoint=ccp(0.5,0);
        self.ground2.position=ccp(ws.width/2,46);
        [self addChild: self.ground2];
        
        
        self.birdCMC=[[CCSprite alloc]init];
        [self addChild:self.birdCMC];
        
        self.ground1=[CCSprite spriteWithFile:@"ground1.png"];
        self.ground1.anchorPoint=ccp(0.5,0);
        self.ground1.position=ccp(ws.width/2,0);
        [self addChild: self.ground1];
        
        
        
        self.br=[[BowArrow alloc]init];
        self.br.rotation=-90;
        self.br.position=ccp(ws.width/2,0);
        self.br.scale=1.0;
        [self addChild:self.br];
        
        
        self.gameUICMC=[[CCSprite alloc]init];
        
        [self addChild:self.gameUICMC];
        
        self.musicBtn=[[SwitchButton alloc]init];
        [self.musicBtn initWithImageStr:@"musicOn1.png" O2:@"musicOn2.png" O3:@"musicOff1.png" O4:@"musicOff2.png" Open:self.musicIsOn];
        
        
        
        self.timeMC=[[CCSprite alloc]init];
        
        [self.gameUICMC addChild:self.timeMC];
        CCSprite *timeIMG=[CCSprite spriteWithSpriteFrameName:@"time.png"];
        timeIMG.anchorPoint=ccp(0,1);
        timeIMG.position=ccp(4,ws.height-4);
        [self.timeMC addChild:timeIMG];
        
        self.timeText=[CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%i",self.limitTime] fntFile:@"BerlinSansFBDemi45FFFFFF.fnt"];
        self.timeText.anchorPoint=ccp(0,1);
        self.timeText.position=ccp(64,ws.height-8);
        [self.timeMC addChild:self.timeText];
        
        
        self.scoreMC=[[CCSprite alloc]init];
        [self.gameUICMC addChild:self.scoreMC];
        CCSprite *scoreIMG=[CCSprite spriteWithSpriteFrameName:@"score.png"];
        scoreIMG.anchorPoint=ccp(0,0);
        scoreIMG.position=ccp(4,4);
        [self.scoreMC addChild:scoreIMG];
        
        self.scoreText=[CCLabelBMFont labelWithString:@"0" fntFile:@"BerlinSansFBDemi45FFFFFF.fnt"];
        self.scoreText.anchorPoint=ccp(0,0);
        self.scoreText.position=ccp(64,5);
        [self.scoreMC addChild:self.scoreText];
        
        
        
         self.musicBtn.position=ccp(ws.width-30,30);
        
        [self.gameUICMC addChild:self.musicBtn];
        
       
        
        
        
        self.infoText=[CCLabelBMFont labelWithString:@"Level 1" fntFile:@"a_Assuan.fnt"];
        
        self.infoText.position=ccp(ws.width/2,ws.height/2);
        [self.gameUICMC addChild:self.infoText];
        
        self.infoText.visible=NO;
        
        
        self.shootAble=NO;
        
         [self showLevelInfoThenGoNextLevel:@"Ready" theLevel:1];
        
        
	}
	return self;
}
//show info and go next level
-(void)showLevelInfoThenGoNextLevel:(NSString*) info theLevel:(int)level {
    
    if(level==1){
        self.score=0;
        [self.scoreText setString:@"0"];
    }
    
    
    self.infoText.scale=0;
    self.infoText.visible=YES;
    
    id cccfND=[CCCallFuncND actionWithTarget:self selector:@selector(showCompleteInfoCompleted:data:) data:(void *)level];
    id delay=[CCDelayTime actionWithDuration:1];
    
    id scaleTo1 = [CCScaleTo actionWithDuration:0.6 scale:1.0];
    
	id scale_ease_in = [CCEaseBackOut actionWithAction:[[scaleTo1 copy] autorelease]];
    
    id scaleTo0 = [CCScaleTo actionWithDuration:0.2 scale:0];
    
    
     
    [self.infoText setString:(level==1?@"Ready":@"Game Complete")];
    
        
    
    
    id seq =[CCSequence actions:delay,scale_ease_in,[CCDelayTime actionWithDuration:0.6] ,scaleTo0,cccfND,nil];
    
    [self.infoText runAction:seq];
    
	
}
//showLevelInfoThenGoNextLevel completed
-(void) showCompleteInfoCompleted:(id)sender data:(int)data{
    [self startGameShowLevel:data];
}
//start a new game , shpw level info 
-(void)startGameShowLevel:(int) level{
    id cccfND=[CCCallFuncND actionWithTarget:self selector:@selector(completed:data:) data:(void *)level];
    id delay=[CCDelayTime actionWithDuration:0.3];
    
    id scaleTo1 = [CCScaleTo actionWithDuration:0.6 scale:1.0];
    
    id scaleTo0 = [CCScaleTo actionWithDuration:0.2 scale:0];
    
	id scale_ease_in = [CCEaseBackOut actionWithAction:[[scaleTo1 copy] autorelease]];
    
    self.infoText.scale=0;
   
    [self.infoText setString:[NSString stringWithFormat:@"Level-%i",level]];
    
    id seq =[CCSequence actions:delay,scale_ease_in,[CCDelayTime actionWithDuration:0.6],scaleTo0,cccfND,nil];
    
     [self.infoText runAction:seq];    
}

//cccfND 

-(void) completed:(id)sender data:(int)data
{
    
    [self.infoText setVisible:NO];
    
    self.shootAble=YES;
    
    [self startGame:data];
    
    
     
}
//show game over 
-(void) showGameOver{
    if(!self.gameOverLayer){
        self.gameOverLayer=[[GameOver alloc]init];
        ((GameOver*)self.gameOverLayer).gm=self;
        [self addChild:self.gameOverLayer];
    }
    else{
        ((GameOver*)self.gameOverLayer).visible=YES;
    }
    
    [((GameOver*)self.gameOverLayer).scoreText setString:[NSString stringWithFormat:@"Score: %i",self.score]];
    
    
}

//start game (or start a new game)

-(void)startGame:(int) level{
    if(!self.birdsAreCreated){
        self.arrowsArr=[[NSMutableArray alloc]init];
        self.birdsArr=[[NSMutableArray alloc]init];
        for (int i=0; i<self.num_objects; i++) {
            Bird *bird=[[Bird alloc]initWithSpeed:0.8f+0.1f*level];
            
            bird.gm=self;
            [birdsArr addObject:bird];
        
        
            [self.birdCMC addChild:bird];
        }
        
        
        
        
        self.birdsAreCreated=YES;
         
    }
    self.currentLevel=level;
    
    self.theTime=self.limitTime;
    [self.timeText setString:[NSString stringWithFormat:@"%i",self.theTime]];
    self.shootAble=YES;
    [self unschedule:@selector(updateTimeDisplay)];
    [self schedule:@selector(updateTimeDisplay) interval:1];
    
    self.birdsShootedNum=0;
    [self resetBirds];
    [self unschedule:@selector(loop)];
    [self schedule:@selector(loop)];
    self.theTime=self.limitTime;
    
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"geese3.wav"];
        
     
    
     
}
//update time text
-(void)updateTimeDisplay{
    self.theTime--;
    [self.timeText setString:[NSString stringWithFormat:@"%i",self.theTime]];
    if (self.theTime==0) {
        [self unschedule:@selector(updateTimeDisplay)];
        [self showGameOver];
        self.theTime=-1;
    }
}


//reset birds

-(void)resetBirds{
    for (int i=0; i<self.birdsArr.count; i++) {
        id b=[self.birdsArr objectAtIndex:i];
        [(Bird*)b setVisible:YES];
        [(Bird*)b reset];
       
    }
}
//hide all birds
-(void)hideBirds{
    for (int i=0; i<self.birdsArr.count; i++) {
        id b=[self.birdsArr objectAtIndex:i];
        [(Bird*)b setVisible:NO];
         
    }
}


//the main loop

-(void)loop{
    
    float px=cosf(-self.currentArrow.rotation/180*M_PI)*12;
    float py=sinf(-self.currentArrow.rotation/180*M_PI)*12;
    self.currentArrow.position=ccp(self.currentArrow.position.x+px,+self.currentArrow.position.y+py);
    
    for (int i=0; i<[self.birdsArr count]; i++) {
       
        Bird *b=(Bird*)[self.birdsArr objectAtIndex:i];

        
        if(self.currentArrow&&self.currentArrow.visible&&!b.isDead){
            CGRect aRect=CGRectMake(self.currentArrow.position.x, self.currentArrow.position.y, 1, 1);
            CGRect birdRect=CGRectMake(b.position.x-7 , b.position.y-7, 14 , 14);
            //CGPoint pp=CGPointMake(self.currentArrow.position.x, self.currentArrow.position.y);
            if(CGRectIntersectsRect(aRect, birdRect)){
                self.currentArrow.visible=NO;
                if(b.scaleX>0){
                    [b fallWithArrowRotation:atan2f(self.br.position.x-b.position.x,self.br.position.y-b.position.y)*180/M_PI+90];
                }
                else{
                    [b fallWithArrowRotation:-atan2f(self.br.position.x-b.position.x,self.br.position.y-b.position.y)*180/M_PI+90];
                }
                self.score+=100+((int)(b.position.y/20));
                [self.scoreText setString:[NSString stringWithFormat:@"%i",self.score]];
                
                self.birdsShootedNum++;
                
                if (self.birdsShootedNum==self.num_arrows) {
                    self.currentLevel++;
                    [self showLevelInfoThenGoNextLevel:@"Ready" theLevel:self.currentLevel];
                    [self unschedule:@selector(updateTimeDisplay)];
                    self.shootAble=NO;
                    
                }
                
                 
                return;
            }
            
            
        }
    }
    

}

//touch

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    CGPoint loc=[touch locationInView:[touch view]];
    loc=[[CCDirector sharedDirector]convertToGL:loc];
    CGPoint point=CGPointMake(loc.x, loc.y);
        
    
    
    self.br.rotation=atan2f(self.br.position.x-point.x,self.br.position.y-point.y)*180/M_PI+90;
    
    if(self.currentArrow){
        self.currentArrow.visible=NO;
    }
    
    
    if(self.br.shootAble){
        [self shoot:point.x SY:point.y];
        
    }
    if (self.shootAble) {
        [self.br playShootMovie];
        [[SimpleAudioEngine sharedEngine]playEffect:@"snd_move.wav"];
    }
    
    

    
    
}

//shoot  a arrow
 

-(void)shoot:(float)sx SY:(float)sy{
    if(self.currentArrow){
        
    }
    if (self.shootAble) {
        
    
            self.currentArrow=[CCSprite spriteWithSpriteFrameName:@"arrow.png"];
            self.currentArrow.anchorPoint=ccp(1,0.5);
            self.currentArrow.position=ccp(self.br.position.x,self.br.position.y);
            self.currentArrow.rotation=self.br.rotation;
            [self addChild:self.currentArrow];
        
    }
    
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
