//
//  GameOver.h
//  BowHunting
//
//  Created by tang on 12-10-2.
//  Copyright (c) 2012年 tang. All rights reserved.
//

#import "CCLayer.h"
#import "GameMain.h"
#import "cocos2d.h"
@interface GameOver : CCSprite
{
    GameMain* gm;
    
    CCMenuItem *playMI;
    
    CCMenu *playButton;
    
    CCLabelBMFont *scoreText;
    
}

 
-(void)playAgianButtonClicked;
@property(nonatomic,retain) GameMain* gm;

@property(nonatomic,retain) CCMenuItem *playMI;
@property(nonatomic,retain) CCMenu *playButton;

@property(nonatomic,retain)  CCLabelBMFont *scoreText;

@end
