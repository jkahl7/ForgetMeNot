//
//  MapViewController.h
//  ForgetMeNot
//
//  Created by Josh Kahl on 2/2/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <mapKit/MKAnnotation.h> //allows us access to CLLocationManager class + others
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>


@property (nonatomic, retain) IBOutlet MKMapView *mapView;

/*is the central point for configuring the delivery of location- and heading-related events to your app. You use an instance of this class to establish the parameters that determine when location and heading events should be delivered and to start and stop the actual delivery of those events */
@property (strong, nonatomic, retain) CLLocationManager *locationManager;

@property (strong, nonatomic) MKPointAnnotation *selectedAnnotation;

@end
