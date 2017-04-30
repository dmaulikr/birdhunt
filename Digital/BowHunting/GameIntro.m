//
//  GameIntro.m
//  BowHunting
//
//  Created by tang on 12-9-29.
//  Copyright (c) 2012年 tang. All rights reserved.
//

#import "GameIntro.h"
#import "cocos2d.h"
#import "GameMain.h"
#import "SimpleAudioEngine.h"
#import "BowHuntingTitle.h"
CGSize ws;
@implementation GameIntro

@synthesize clouds,skyBG,bird,playMI,playButton,musicIsOn,flyArr,bht;


// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameIntro *layer = [GameIntro node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        self.musicIsOn=YES;
        ws=[[CCDirector sharedDirector]winSize];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"sprites.plist"];
        
        skyBG=[CCSprite spriteWithFile:@"sky.jpg"];
        skyBG.position=ccp(ws.width*0.5,ws.height*0.5);
        
        [self addChild:skyBG];
        
        //add clouds clip
        
        clouds=[[Clouds alloc]init];
        
        clouds.position=ccp(0,ws.height);
        
        [self addChild:clouds];
        
        bird=[[CCSprite alloc]init];
        
        bird.position=ccp(ws.width*0.5,ws.height*0.5);
        
        self.flyArr=[NSMutableArray array];
        
        for (int i=1; i<=30; i++) {
            
            NSString *flySpriteStr;
            if(i<10){
                flySpriteStr=[NSString stringWithFormat:@"birdFly000%i.png",i];
                
            }else{
                flySpriteStr=[NSString stringWithFormat:@"birdFly00%i.png",i];
            }
            id flySprite=[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:flySpriteStr];
            
            
            
            [self.flyArr addObject:flySprite];
            
            
            
        }
        
        id animObj=[CCAnimation animationWithSpriteFrames:flyArr delay:0.05];
        
        id flyMovie=[CCAnimate actionWithAnimation:animObj];
        
        id rp=[CCRepeatForever actionWithAction:flyMovie];
        
        [bird runAction:rp];
        
        bird.scaleX=-1.4;
        bird.scaleY=1.4;
        [self addChild:bird];
        
        
        
        self.playMI=[CCMenuItemSprite itemWithNormalSprite:[CCSprite spriteWithSpriteFrameName:@"btn_play.png"] selectedSprite:[CCSprite spriteWithSpriteFrameName:@"btn_play2.png"] target:self selector:@selector(playButtonClicked)];
        self.playButton=[CCMenu menuWithItems:self.playMI, nil];
        
        
        
        
        self.playButton.position=ccp(ws.width*0.5,75);
        
        [self addChild:self.playButton];
        
        
        //preload sounds
        
        if (self.musicIsOn) {
            [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"snd_bg.wav"];
            
        }
        
                       
        
        if(self.musicIsOn){
            [self schedule:@selector(playBGM) interval:0.5];
        }
        //preload sounds
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"geese1.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"geese2.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"geese3.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"geese_die1.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"geese_die2.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"snd_info.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"snd_game_over.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"snd_yeah.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"snd_move.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"snd_btn.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"snd_grass.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"over_control.wav"];
        
        self.bht=[[BowHuntingTitle alloc]init];
        self.bht.position=ccp(60,ws.height-50);
        //[self addChild:self.bht];
        
    }
    
    return self;
    
}
//play background music
-(void)playBGM{
    [self unschedule:@selector(playBGM)];
    
    if(self.musicIsOn){
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"snd_bg.wav" loop:YES];
    }
    
}
//play button clicked handler

-(void) playButtonClicked{
    [self stop];
    
    //show game main
    
    [[CCDirector sharedDirector]replaceScene:[CCTransitionFadeTR transitionWithDuration:1.0 scene:[GameMain scene:self.musicIsOn]]];
    
    
    
     
}

//stop actions

-(void)stop{
    [self.bht stop];
    [self.bird stopAllActions];
    [self.clouds stop];
    
    
    
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[self.clouds release];
    [self.bird release];
	[super dealloc];
}

@end
