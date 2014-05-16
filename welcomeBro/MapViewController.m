//
//  MapViewController.m
//  FlickySlide
//
//  Created by Joey Bronner on 16/05/2014.
//  Copyright (c) 2014 Joey Bronner. All rights reserved.
//

#import "MapViewController.h"
#import "City+CRUD.h"
@import MapKit;

@interface MapViewController ()
@property (strong, nonatomic) IBOutlet UIView *mapView;

@end

@implementation MapViewController

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
}


- (IBAction)addLocation:(id)sender {
    City * newCity = [City newCity];
    
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
