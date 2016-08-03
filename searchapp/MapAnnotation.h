//
//  MapAnnotation.h
//  SearchApp
//
//  Created by Rakin Munjid on 6/21/16.
//  Copyright © 2016 Rakin Munjid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;



@end
