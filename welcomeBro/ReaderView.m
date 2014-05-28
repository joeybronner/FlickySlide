//
//  ReaderView.m
//  welcomeBro
//
//  Created by Joey Bronner on 10/04/2014.
//  Copyright (c) 2014 Joey Bronner. All rights reserved.
//

#import "ReaderView.h"

@interface ReaderView()

// assign = type primitif (entier)
@property (nonatomic, assign) int currentIndex;

@end

@implementation ReaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    [self.subviews.lastObject setFrame:self.bounds];
    
    // si aucun geste n'est enregistré
    if (!self.gestureRecognizers.count)
    {
        // on crée les deux gestes (gauche et droite)
        UISwipeGestureRecognizer * previousPageRecongnizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previousPage)];
        previousPageRecongnizer.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:previousPageRecongnizer];
        
        UISwipeGestureRecognizer * nextPageRecongnizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nextPage)];
        nextPageRecongnizer.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:nextPageRecongnizer];
        
        self.userInteractionEnabled = YES;
    }
}

-(void) previousPage
{
    [self displayPageAtIndex:self.currentIndex-1 animated:YES];
}

-(void) nextPage
{
    [self displayPageAtIndex:self.currentIndex+1 animated:YES];
}

-(void)displayPageAtIndex:(int)index animated:(BOOL)animated
{
    if (index >= 0 && index < [self.delegate numberOfPages])
    {
        
        if (!animated)
        {
            [self.subviews.lastObject removeFromSuperview];
            // Récupération de la vue auprès du delegate
            UIView * view = [self.delegate pageAtIndex:index];
            // Ajout de la vue en tant que sous-vue
            [self addSubview:view];
        }
        else
        {
            UIView * oldView = self.subviews.lastObject;
            UIView * newView = [self.delegate pageAtIndex:index];
            [self addSubview:newView];
            CGPoint center  = newView.center;
            CGPoint left    = CGPointMake(center.x - self.bounds.size.width, center.y);
            CGPoint right   = CGPointMake(center.x + self.bounds.size.width, center.y);
            
            if (index < self.currentIndex)
            {
                newView.center = left;
                [UIView animateWithDuration:1
                                   animations:^
                                   {
                                       newView.center = center;
                                       oldView.center = right;
                                   }
                                  completion:^(BOOL finished)
                                   {
                                      [oldView removeFromSuperview];
                                   }
                 ];
            }
            else
            {
                newView.center = right;
                [UIView animateWithDuration:1
                                   animations:^{
                                       newView.center = center;
                                       oldView.center = left;
                                   }
                                  completion:^(BOOL finished) {
                                      [oldView removeFromSuperview];
                                  }
                 ];
            }
        }

        self.currentIndex = index;
    }

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


// récupérer une clé API flickr
// site pour récupérer la clé : flickr.com/services/
// Dans la rubrique Vos applications
// Obtenez une clé API flickr


@end
