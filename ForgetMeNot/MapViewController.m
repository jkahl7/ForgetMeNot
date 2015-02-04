//
//  MapViewController.m
//  ForgetMeNot
//
//  Created by Josh Kahl on 2/2/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "MapViewController.h"


@interface MapViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *homeButton;
- (IBAction)homeClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *oldHomeButton;
- (IBAction)oldHomeClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *olderHomeButton;
- (IBAction)olderHomeClicked:(id)sender;

@end

@implementation MapViewController


//this appears to continue to call in mapView - will keep refreshing to the showUserLocation if it is set within the method
- (void)viewDidLoad
{

  [super viewDidLoad];
  
  self.mapView.delegate = self;
  
  //init the locationManager object, set the VC as a delegate
  self.locationManager = [[CLLocationManager alloc] init];
  
  self.locationManager.delegate = self;
 
  /**********    1   check if locationServicesEnabled     *****/
  if ([CLLocationManager locationServicesEnabled])
  {
    /********    2   check if previous Auth granted     *****/
    if ([CLLocationManager authorizationStatus] == 0) //if true, then kCLAuthorizationStatusNotDetermined = 0
    { /******    3   if previous Auth !granted, request Auth - Auth type must be set in plist!   **/
      [self.locationManager requestWhenInUseAuthorization];
    } else {/*   4   previous Auth granted, proceed to get, display, and update users location   **/
      self.mapView.showsUserLocation = true;
      
      [self.locationManager startUpdatingLocation];
      
      [self.mapView setMapType        : MKMapTypeStandard];
      [self.mapView setZoomEnabled    : true];
      [self.mapView setScrollEnabled  : true];
      
    } /*******   5   location services are not enabled, inform user  **/
  } else {
    NSLog(@"Location services are not enabled");
  }
  
  //add longpress recognizer
  UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(mapLongPress:)];
  [self.mapView addGestureRecognizer:longPress];
}


// 47.6277904,-122.3427506
- (IBAction)homeClicked:(id)sender
{
  //[self.locationManager stopUpdatingLocation];
  CLLocationCoordinate2D initialLocation;
  initialLocation.latitude = self.mapView.userLocation.coordinate.latitude;
  initialLocation.longitude = self.mapView.userLocation.coordinate.longitude;
  
  //initialLocation.latitude  = 47.6277904;
  //initialLocation.longitude = -122.3427506;
  
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(initialLocation, 750, 750);
  
  [self.mapView setRegion:region
                 animated:true];
  
  //Starts the generation of updates that report the user’s current location
  //The accuracy of the location data.
  //self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
  // minimum distance (measured in meters) a device must move horizontally before an update event is generated
  //self.locationManager.distanceFilter = kCLDistanceFilterNone;
}


// L&L @42.3998257,-71.1271535
- (IBAction)oldHomeClicked:(id)sender
{
  //[self.locationManager stopUpdatingLocation];
  CLLocationCoordinate2D initialLocation;
  initialLocation.latitude  = 42.3998257;
  initialLocation.longitude = -71.1271535;
  
  MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(initialLocation, 750, 750);
  
  [self.mapView setRegion:viewRegion
                 animated:YES];
}


// L&L 39.313729,-76.473313
- (IBAction)olderHomeClicked:(id)sender
{
  [self.locationManager stopUpdatingLocation];
  CLLocationCoordinate2D initialLocation;
  initialLocation.latitude  = 39.313729;
  initialLocation.longitude = -76.473313;
  
  MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(initialLocation, 750, 750);
  
  [self.mapView setRegion:viewRegion animated:YES];
}


//custom method which creates an annotation at a the location of a long touch gesture
-(void)mapLongPress:(id)sender
{
  UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
  
  if (longPress.state == 3) //enum signaling that the press has ended UIGestureRecognizerStateEnded
  {
    CGPoint location = [longPress locationInView:self.mapView]; //stores location of longpress in CGPoint struct
    [self.mapView convertPoint:location
          toCoordinateFromView:self.mapView]; //converts the CGPoint location data into coordinates for the mapView
    
    CLLocationCoordinate2D mapCoordinates = [self.mapView convertPoint:location toCoordinateFromView:self.mapView];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate         = mapCoordinates;
    annotation.title              = @"New Location:";
    
    [self.mapView addAnnotation:annotation];
  }
}

// will allow us to customize the pin we dropped on the map - requuired method
-(MKAnnotationView *)mapView:(MKMapView *)mapView
           viewForAnnotation:(id<MKAnnotation>)annotation
{
  MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                                        reuseIdentifier:@"annotationView"];
  
  annotationView.pinColor       = MKPinAnnotationColorGreen;
  annotationView.animatesDrop   = true;
  annotationView.canShowCallout = true;
  
  annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
  
  return annotationView;
}


//another delegate method in mapview - gives you the annotation view that was clicked on
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
                     calloutAccessoryControlTapped:(UIControl *)control
{
  MKPointAnnotation *annotation = view.annotation;
  annotation.title = @"here";
  
  //perform segue in this method   ctl drag and present modally - "SHOW_DETAIL" identifier
  
  
  [self performSegueWithIdentifier:@"SHOW_OPTIONS"
                            sender:self];
}


-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
  if (status == 0) //access denied or changed in settings
  {
    NSLog(@"Location Auth status changed");
  } else {
    NSLog(@"Location Auth Accepted");
    self.mapView.showsUserLocation = true;

    [self.locationManager startUpdatingLocation];
    
    [self.mapView setMapType        : MKMapTypeStandard];
    [self.mapView setZoomEnabled    : true];
    [self.mapView setScrollEnabled  : true];
  }
}

/*  triggers whenenver the location is updated
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
  CLLocation *location = locations.firstObject;
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
  [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

*/



@end
