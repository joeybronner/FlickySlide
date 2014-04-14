//
//  PictureViewController.m
//  welcomeBro
//
//  Created by Joey Bronner on 10/04/2014.
//  Copyright (c) 2014 Joey Bronner. All rights reserved.
//

#import "PictureViewController.h"
#import "ReaderView.h"

@interface PictureViewController () <ReaderViewDelegate>

@property (weak, nonatomic) IBOutlet ReaderView *readerView;

@end

@implementation PictureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.readerView.delegate = self;
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.readerView displayPageAtIndex:0 animated:NO];
}

-(int)numberOfPages
{
    return 3;
}

-(UIView *)pageAtIndex:(int)index
{
    NSString * imageName    = [NSString stringWithFormat:@"%i.jpg",index];
    UIImage  * image        = [UIImage imageNamed:imageName];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame =  self.readerView.bounds;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    return imageView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
