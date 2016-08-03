//
//  MapViewController.m
//  SearchApp
//
//  Created by Rakin Munjid on 6/16/16.
//  Copyright © 2016 Rakin Munjid. All rights reserved.
//

#import "MapViewController.h"
#import "MapAnnotation.h"
#import "MyPinAnnotation.h"

@interface MapViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *theMapView;

@end

@implementation MapViewController

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isMemberOfClass:[MKUserLocation class]])
        return nil;
    
    MyPinAnnotation *annView = (MyPinAnnotation *)[self.theMapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
    
//    MKPinAnnotationView *annView = (MKPinAnnotationView *)[self.theMapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
    if(!annView){
        annView = [[MyPinAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    }

    annView.image = [UIImage imageNamed:@"cookie.png"];
    annView.enabled = YES;
    annView.canShowCallout = YES;
    
    annView.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cookie.png"]];
    
    annView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return annView;
    
    
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    
    NSLog(@"Hello ");
    
    NSString* url = [NSString stringWithFormat:@"http://maps.apple.com/maps?daddr=%f,%f",self.result.latitude, self.result.longitude];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];

    
}



- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)annotationViews
{
    for (MyPinAnnotation *annView in annotationViews)
    {
        CGRect endFrame = annView.frame;
        annView.frame = CGRectOffset(endFrame, 0, -500);
        [UIView animateWithDuration:0.5
                         animations:^{ annView.frame = endFrame; }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.result.title;
    
    
    
    
//    CLLocationCoordinate2D coordinate;
//    coordinate.latitude = self.result.latitude;
//    coordinate.longitude = self.result.longitude;
//
//    MKCoordinateSpan span;
//    span.latitudeDelta = 0.02;
//    span.longitudeDelta = 0.02;
//    
//    MKCoordinateRegion region;
//    region.center = coordinate;
//    region.span = span;

    MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(self.result.latitude, self.result.longitude), MKCoordinateSpanMake(0.02, 0.02));
    
    [self.theMapView setRegion:region animated:YES];
    
    MapAnnotation *ann = [[MapAnnotation alloc] init];
    ann.coordinate = CLLocationCoordinate2DMake(self.result.latitude, self.result.longitude);
    ann.title = self.result.title;
    ann.subtitle = self.result.phone;
    
    [self.theMapView addAnnotation:ann];
    
    
//    self.result.latitude
//    self.result.longitude
    
//    NSString* url = [NSString stringWithFormat:@"http://maps.apple.com/maps?daddr=%f,%f",self.result.latitude, self.result.longitude];
//    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
