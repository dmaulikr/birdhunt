//
//  GameIntro.h
//  BowHunting
//
//  Created by tang on 12-9-29.
//  Copyright (c) 2012年 tang. All rights reserved.
//

#import "cocos2d.h"
#import "Clouds.h"
#import "BowHuntingTitle.h"
@interface GameIntro : CCLayer{
    CCSprite *skyBG,*bird;
    Clouds *clouds;
    
    CCMenuItem *playMI;
    
    CCMenu *playButton;
    BOOL musicIsOn;
    NSMutableArray *flyArr;
    
    BowHuntingTitle *bht;
    
}
+(CCScene *) scene;
-(void)stop;
-(void)playBGM;
-(void) playButtonClicked;
@property(nonatomic,retain) CCSprite*skyBG,*bird;
@property(nonatomic,retain) Clouds *clouds;

@property(nonatomic,retain) CCMenuItem *playMI;
@property(nonatomic,retain) CCMenu *playButton;
@property(nonatomic,assign) BOOL musicIsOn;
@property(nonatomic,assign) BowHuntingTitle *bht;

@property(nonatomic,assign) NSMutableArray *flyArr;

@end
