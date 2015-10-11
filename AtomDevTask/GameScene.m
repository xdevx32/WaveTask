//
//  GameScene.m
//  AtomDevTask
//
//  Created by Angel Kukushev on 10/11/15.
//  Copyright (c) 2015 xdevx332. All rights reserved.
//

#import "GameScene.h"
#import "GameViewController.h"

@implementation GameScene{
    float x,y;
    float frequency1;
    UISlider *slider;
}

-(void)didMoveToView:(SKView *)view {
        y = 200.0;
        x = -20.0;
        frequency1 = 1000;
    [self mySlider];
}



-(IBAction)mySlider
{
    CGRect frame = CGRectMake(200.0,230.0,100,80);
    
    slider = [[UISlider alloc] initWithFrame:frame];
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [slider setBackgroundColor:[UIColor clearColor]];
    slider.minimumValue = 1.0;
    slider.maximumValue = 100.0;
    slider.continuous = YES;
    // AMP from 10 to 120 is good
    slider.value = 90.0;
    self.gAmp = slider.value;
   
    [self.view addSubview:slider];
}


- (IBAction)sliderValueChanged:(UISlider *)sender {
     UISlider *slider = (UISlider*)sender;
    NSLog(@"slider value = %f", sender.value);
    
    
}


- (CGMutablePathRef)sineWithAmplitude:(CGFloat)amp
                            frequency:(CGFloat)freq
                                width:(CGFloat)width
                             centered:(BOOL)centered
                         andNumPoints:(NSInteger)numPoints {
    
    CGFloat offsetX = 0.0;
    CGFloat offsetY = self.gAmp;
    
    if (centered) {
        offsetX = 0.0;
        offsetY = 0;
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    // Move to the starting point
    CGPathMoveToPoint(path, nil, offsetX, offsetY);
    //CGFloat xIncr = width / (numPoints-1);
    CGFloat xIncr = 2.0;
    // Construct the sinusoid

    for (int i=1;i<numPoints;i++) {
       
       CGFloat yC = slider.value * sin(M_PI*i/49);
        
        CGPathAddLineToPoint(path, nil, i*xIncr+offsetX, yC+offsetY);
        //CGPathAddLineToPoint(path,nil,i*xIncr+offsetX, -y+offsetY);
        
    }
    return path;
}

-(void)update:(CFTimeInterval)currentTime {
    
    
    // Called before each frame is rendered
    self.scaleMode = SKSceneScaleModeResizeFill;
    // Create an SKShapeNode
    SKShapeNode *node = [SKShapeNode node];
    
    node.position = CGPointMake(x, y);
    
    
    node.path = [self sineWithAmplitude: self.gAmp frequency:frequency1 width:200.0 centered:YES andNumPoints:100];
 
    
    node.strokeColor = [SKColor grayColor];
    [node runAction:[SKAction moveByX:-2000.0 y:0.0 duration:100.0]];
    [self addChild:node];
    
    x = x+195.1;
    
}

@end
