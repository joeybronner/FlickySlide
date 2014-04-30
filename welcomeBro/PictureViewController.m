//
//  PictureViewController.m
//  FlickRApp
//
//  Created by Joey BRONNER on 10/04/2014.
//  Copyright (c) 2014 Joey BRONNER. All rights reserved.
//

#import "PictureViewController.h"
#import "ReaderView.h"

@interface PictureViewController () <ReaderViewDelegate>
@property (weak, nonatomic) IBOutlet ReaderView *readerView;

@property (strong, nonatomic) NSArray * pictures;

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
    // Do any additional setup after loading the view.
    
    FlickRLocation location;
    location.latitude = 48.8787181;
    location.longitude = 7.47510120000004;
    location.radius = 5;
    
    self.pictures = [FlickRPicture picturesAroundLocation:location];
    
    self.readerView.delegate = self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.readerView displayPageAtIndex:0 animated:NO];
}



- (int)numberOfPages{
    return self.pictures.count;
}

-(UIView *)pageAtIndex:(int)index{
    
    //NSString * imageName = [NSString stringWithFormat:@"%i.jpg",index];
    //UIImage * image = [UIImage imageNamed:imageName];
    FlickRPicture * picture = self.pictures[index];
    NSData * imageData = [NSData dataWithContentsOfURL:picture.url];
    
    UIImage * image = [UIImage imageWithData:imageData];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = self.readerView.bounds;
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
