//
//  ResultsTableViewController.m
//  SearchApp
//
//  Created by Rakin Munjid on 6/16/16.
//  Copyright © 2016 Rakin Munjid. All rights reserved.
//

#import "ResultsTableViewController.h"
#import "MapViewController.h"
#import "Result.h"

@interface ResultsTableViewController () {
    NSMutableArray *resultArray;
}

@end

@implementation ResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.coder = [[CLGeocoder alloc] init];
    
    [self.coder geocodeAddressString:self.whereVal completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *pl = [placemarks objectAtIndex:0];
        
        
        NSString *theURL = [NSString stringWithFormat:@"https://query.yahooapis.com/v1/public/yql?q=select%%20*%%20from%%20local.search%%20where%%20zip%%3D%%27%@%%27%%20and%%20query%%3D%%27%@%%27&format=json&callback=",pl.postalCode, self.whatVal];
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:theURL]];
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"%@",dict);
        
        NSArray *allResults = [[[dict objectForKey:@"query"] objectForKey:@"results"] objectForKey:@"Result"];
        
        /*
         title;
         @property (nonatomic, strong) NSString *address;
         @property (nonatomic, strong) NSString *city;
         @property (nonatomic, strong) NSString *state;
         @property (nonatomic, strong) NSString *phone;
         @property (nonatomic, assign) float latitude;
         @property (nonatomic, assign) float longitude
         */
        
        resultArray = [[NSMutableArray alloc] init];
        
        for(NSDictionary *eachDict in allResults){
            Result *result = [[Result alloc] init];
            result.title = [eachDict objectForKey:@"Title"];
            result.address = [eachDict objectForKey:@"Address"];
            result.city = [eachDict objectForKey:@"City"];
            result.state = [eachDict objectForKey:@"State"];
            result.phone = [eachDict objectForKey:@"Phone"];
            result.latitude = [[eachDict objectForKey:@"Latitude"] floatValue];
            result.longitude = [[eachDict objectForKey:@"Longitude"] floatValue];
            
            [resultArray addObject:result];
        }
        
        [self.tableView reloadData];

    }];
    
    
    
                    
                    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return resultArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Result *res = [resultArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = res.title;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@ %@", res.address, res.city, res.state];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    MapViewController *mapController = [segue destinationViewController];
    
    mapController.result = [resultArray objectAtIndex:indexPath.row];

    
    
}

@end
