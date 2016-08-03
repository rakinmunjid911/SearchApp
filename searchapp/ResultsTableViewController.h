//
//  ResultsTableViewController.h
//  SearchApp
//
//  Created by Rakin Munjid on 6/16/16.
//  Copyright © 2016 Rakin Munjid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ResultsTableViewController : UITableViewController

@property (nonatomic, strong) NSString *whatVal;
@property (nonatomic, strong) NSString *whereVal;

@property (nonatomic, strong) CLGeocoder *coder;

@end
