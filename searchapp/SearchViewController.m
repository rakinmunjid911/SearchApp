//
//  SearchViewController.m
//  SearchApp
//
//  Created by Rakin Munjid on 6/16/16.
//  Copyright © 2016 Rakin Munjid. All rights reserved.
//

#import "SearchViewController.h"
#import "ResultsTableViewController.h"

@interface SearchViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *whatField;
@property (weak, nonatomic) IBOutlet UITextField *whereField;


@property (nonatomic, strong) CLLocationManager *manager;

@property (nonatomic, strong) CLGeocoder *coder;


@end

@implementation SearchViewController


- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status  {
    
    if(status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways){
        
        [self.manager startUpdatingLocation];
        
        
    }
    
}

-(void) viewDidLoad {
    [super viewDidLoad];
    self.coder = [[CLGeocoder alloc] init];

}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    NSLog(@"%@",[locations objectAtIndex:0]);
    [self.manager stopUpdatingLocation];
    
    
    
    
    CLLocation *location = [locations objectAtIndex:0];
    
    [self.coder reverseGeocodeLocation:location
                     completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                         
                         CLPlacemark *placemark = [placemarks objectAtIndex:0];
                         self.whereField.text = placemark.postalCode;
                         
                         NSLog(@"%@",placemark.addressDictionary);
                         
                     }];

}


- (IBAction)currentLocation:(id)sender {
    
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    
    
    if([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]){

        [self.manager requestWhenInUseAuthorization];
        
        
    } else {
        //ios7 Permission granted
    }
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    ResultsTableViewController *result = segue.destinationViewController;
    result.whatVal = self.whatField.text;
    result.whereVal = self.whereField.text;
    
}


@end
