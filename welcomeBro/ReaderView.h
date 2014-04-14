//
//  ReaderView.h
//  welcomeBro
//
//  Created by Joey Bronner on 10/04/2014.
//  Copyright (c) 2014 Joey Bronner. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ReaderViewDelegate <NSObject>

- (int) numberOfPages;
- (UIView*) pageAtIndex:(int)index;

@end

@interface ReaderView : UIView

@property (nonatomic, weak) id<ReaderViewDelegate> delegate;

-(void) displayPageAtIndex:(int)index animated:(BOOL) animated;

@end