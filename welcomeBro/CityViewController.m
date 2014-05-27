//
//  CityViewController.m
//  FlickySlide
//
//  Created by Joey Bronner on 16/05/2014.
//  Copyright (c) 2014 Joey Bronner. All rights reserved.
//

#import "CityViewController.h"
#import "City+CRUD.h"
#import "PictureViewController.h"
@import CoreLocation;

@interface CityViewController ()

@property (strong, nonatomic) NSArray * cities;

@end

@implementation CityViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // récupération des villes
    self.cities = [City allCities];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(localizeCities) forControlEvents:UIControlEventValueChanged];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.cities = [City allCities];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) localizeCities
{
    [self.cities enumerateObjectsUsingBlock:^(City *city, NSUInteger idx, BOOL *stop)
    {
        CLGeocoder * geocoder = [[CLGeocoder alloc] init];
        CLLocation * location = [[CLLocation alloc] initWithLatitude:city.latitude.doubleValue longitude:city.longitude.doubleValue];
        
        [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
         {
             for (CLPlacemark * placemark in placemarks)
             {
                 if(placemark.locality.length)
                 {
                     city.name = placemark.locality;
                 }
                 else if (placemark.country.length)
                 {
                     city.name = placemark.country;
                 }
                 else
                 {
                     city.name = @"Inconnu";
                 }
             }
             
             
             [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
         }];
    }];
    
    [self.refreshControl endRefreshing];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.cities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell" forIndexPath:indexPath];
    
    City * city = self.cities[indexPath.row];
    cell.textLabel.text = city.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Lat : %f // Lon : %f", city.latitude.doubleValue, city.longitude.doubleValue];
    
    // Configure the cell...
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self.cities[indexPath.row] destroy];
        self.cities = [City allCities];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"toPictureViewController"])
    {
        PictureViewController * viewController = segue.destinationViewController;
        City * city = self.cities[self.tableView.indexPathForSelectedRow.row];
        
        FlickRLocation location;
        location.latitude = city.latitude.doubleValue;
        location.longitude = city.longitude.doubleValue;
        location.radius = 10;
        
        viewController.location = location;
        
        
    }
}


@end
