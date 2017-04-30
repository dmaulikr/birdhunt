//
//  HelloWorldLayer.h
//  BowHunting
//
//  Created by tang on 12-9-24.
//  Copyright tang 2012年. All rights reserved.
//


#import <GameKit/GameKit.h>
#import "Clouds.h"
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "BowArrow.h"
#import "SwitchButton.h"
 
// HelloWorldLayer
@interface GameMain : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    CCSprite *skyBG,*sun,*ground2,*ground1,*gameUICMC,*scoreMC,*timeMC,*birdCMC,*currentArrow;
    
    Clouds *clouds;
    
    BowArrow *br;
    
    int num_arrows,num_objects,birdsShootedNum,score,theTime,limitTime,currentLevel;
    
    float currentSpeed,speedPlus;
    
    NSMutableArray *birdsArr,*arrowsArr;
    
    CCLabelBMFont *timeText,*scoreText,*infoText;
    
    SwitchButton *musicBtn;
    
    BOOL shootAble,birdsAreCreated,musicIsOn;
    
    
    id gameOverLayer;
    
  
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene:(BOOL)gbmIsOn;
-(void) loop;
-(void)hideBirds;
-(id) initWithBOOL:(BOOL)bgmIsOn;
-(void) resetBirds;
-(void) shoot:(float)sx SY:(float)sy;
-(void) startGame:(int)level;
-(void) startGameShowLevel:(int) level;
-(void) completed:(id)sender data:(int)data;
-(void) showCompleteInfoCompleted:(id)sender data:(int)data;
-(void) showLevelInfoThenGoNextLevel:(NSString*) info theLevel:(int)level;
-(void) showGameOver;

@property(nonatomic,retain) CCSprite *skyBG,*sun,*ground2,*ground1,*gameUICMC,*scoreMC,*timeMC,*birdCMC,*currentArrow;
@property(nonatomic,retain) Clouds *clouds;

@property(nonatomic,retain) NSMutableArray *birdsArr,*arrowsArr;
@property(nonatomic,retain) BowArrow *br;
@property(nonatomic,assign) id gameOverLayer;
@property(nonatomic,assign) int num_arrows,num_objects,birdsShootedNum,score,theTime,limitTime,currentLevel;
@property(nonatomic,assign) float currentSpeed,speedPlus;
@property(nonatomic,assign) BOOL shootAble,birdsAreCreated,musicIsOn;
@property(nonatomic,assign) CCLabelBMFont *timeText,*scoreText,*infoText;

@property(nonatomic,assign) SwitchButton *musicBtn;
@end
