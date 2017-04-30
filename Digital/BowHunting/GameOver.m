//
//  GameOver.m
//  BowHunting
//
//  Created by tang on 12-10-2.
//  Copyright (c) 2012年 tang. All rights reserved.
//

#import "GameOver.h"
#import "cocos2d.h"
#import "GameMain.h"
#import "Clouds.h"
CGSize ws;
@implementation GameOver
@synthesize gm,playMI,playButton,scoreText;


-(id) init
{
	 
	if( (self=[super init])) {
        ws=[[CCDirector sharedDirector]winSize];
        
        //create sky etc..
        
        CCSprite *sky=[CCSprite spriteWithFile:@"gameOverSky.png"];
        sky.position=ccp(ws.width/2,ws.height/2);
        [self addChild:sky];
        
        Clouds *c=[[Clouds alloc]init];
        c.position=ccp(0,ws.height);
        [self addChild:c];
        
        
        CCSprite *gameOverSprite=[CCSprite spriteWithSpriteFrameName:@"gameOverTitle.png"];
                
        gameOverSprite.position=ccp(ws.width/2,ws.height/2+70);
         
        
        
        
        [self addChild:gameOverSprite];
         
        
        self.playMI=[CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"btn_play_again.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"btn_play_again2.png"] target:self selector:@selector(playAgianButtonClicked)];
        self.playButton=[CCMenu menuWithItems:self.playMI, nil];
        
        //add score text
        
        self.scoreText=[CCLabelBMFont labelWithString:@"SCORE: 123456" fntFile:@"BerlinSansFBDemiGOSFFFFFF.fnt"];
        self.scoreText.position=ccp(ws.width/2,ws.height/2);
        [self addChild:self.scoreText];
        
        self.playButton.position=ccp(ws.width*0.5,80);
        
        [self addChild:self.playButton];
        
    }
    return self;
}

//play again button clicked , start a new game

-(void)playAgianButtonClicked{
     self.visible=NO;
    [self.gm hideBirds];
    [self.gm.timeText setString:[NSString stringWithFormat:@"%i" ,self.gm.limitTime]];
    [self.gm showLevelInfoThenGoNextLevel:@"Ready" theLevel:1];
     
}

@end
