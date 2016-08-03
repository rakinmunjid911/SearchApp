//
//  MapViewController.h
//  SearchApp
//
//  Created by Rakin Munjid on 6/16/16.
//  Copyright © 2016 Rakin Munjid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Result.h"

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) Result *result;

@end
