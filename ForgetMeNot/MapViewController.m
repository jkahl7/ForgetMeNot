//
//  MapViewController.m
//  ForgetMeNot
//
//  Created by Josh Kahl on 2/2/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "MapViewController.h"
#import "OptionsViewController.h"



@interface MapViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *homeButton;
- (IBAction)homeClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *oldHomeButton;
- (IBAction)oldHomeClicked:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *olderHomeButton;
- (IBAction)olderHomeClicked:(id)sender;

@end


@implementation MapViewController


- (void)viewDidLoad
{

  [super viewDidLoad];
  
  
  //singleton    - need to unregister  -dealloc down below  we are signing up to be the observer!
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(reminderAdded:)
                                               name:@"ReminderAdded"
                                             object:nil];  //dont care what object notification comes from

  self.mapView.delegate = self;
  
  //init the locationManager object, set the VC as a delegate
  self.locationManager          = [[CLLocationManager alloc] init];
  self.locationManager.delegate = self;
 
  if ([CLLocationManager locationServicesEnabled]) //1-check if locationServicesEnabled
  {
    if ([CLLocationManager authorizationStatus] == 0) //2-if true, then kCLAuthorizationStatusNotDetermined = 0
    {
      [self.locationManager requestWhenInUseAuthorization];//3-if previous Auth !granted, request Auth -type must be set in plist!
    } else {
      self.mapView.showsUserLocation = true;     //4-previous Auth granted, proceed to get, display, and update users location
      
      [self.locationManager startUpdatingLocation];
      
      [self.mapView setMapType        : MKMapTypeStandard];
      [self.mapView setZoomEnabled    : true];
      [self.mapView setScrollEnabled  : true];
      
    }
  } else {  //5   location services are not enabled, TODO:  inform user
    NSLog(@"Location services are not enabled");
  }
  
  //add longpress recognizer
  UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(mapLongPress:)];
  [self.mapView addGestureRecognizer:longPress];
}


-(IBAction)homeClicked:(id)sender  //sends mapView to users current location
{
  //[self.locationManager stopUpdatingLocation];
  CLLocationCoordinate2D initialLocation;
  initialLocation.latitude  = self.mapView.userLocation.coordinate.latitude;
  initialLocation.longitude = self.mapView.userLocation.coordinate.longitude;
  
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(initialLocation, 750, 750);
  
  [self.mapView setRegion:region
                 animated:true];
  
  //The accuracy of the location data.
  //self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
  // minimum distance (measured in meters) a device must move horizontally before an update event is generated
  //self.locationManager.distanceFilter = kCLDistanceFilterNone;
}


-(IBAction)oldHomeClicked:(id)sender // L&L @42.3998257,-71.1271535
{
  //[self.locationManager stopUpdatingLocation];
  CLLocationCoordinate2D initialLocation;
  initialLocation.latitude  = 42.3998257;
  initialLocation.longitude = -71.1271535;
  
  MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(initialLocation, 750, 750);
  
  [self.mapView setRegion:viewRegion
                 animated:YES];
}


-(IBAction)olderHomeClicked:(id)sender // L&L 39.313729,-76.473313
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
    
    CLLocationCoordinate2D mapCoordinates = [self.mapView convertPoint:location
                                                  toCoordinateFromView:self.mapView];
    
    self.selectedAnnotation = [[MKPointAnnotation alloc] init];
    self.selectedAnnotation.coordinate         = mapCoordinates;
    self.selectedAnnotation.title              = @"New Location:";
    
    [self.mapView addAnnotation:self.selectedAnnotation];
  }
}

// will allow us to customize the pin we dropped on the map - requuired method
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
  //TODO: dequeue this pin!!!
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
  annotation.title              = self.selectedAnnotation.title;
  
  [self performSegueWithIdentifier:@"SHOW_OPTIONS"
                            sender:self];
}

#pragma prepareForSegue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"SHOW_OPTIONS"])
  {
    
    OptionsViewController *vc = (OptionsViewController *)segue.destinationViewController;
    vc.annotationInOptions    = self.selectedAnnotation;
  }
}


#pragma didChangeAuthStatus
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


//will fire when we enter the specified region
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
  NSLog(@"entered region");
  
  //must request permission to show notifications in iOS8!
  UILocalNotification *entryNotification = [[UILocalNotification alloc] init];
  entryNotification.alertBody            = @"Entered a new region";
  // entryNotification.alertAction = @"This is different";
  
  [[UIApplication sharedApplication] presentLocalNotificationNow:entryNotification];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
  NSLog(@"exited region, please come back soon!");
  UILocalNotification *exitNotification = [[UILocalNotification alloc] init];
 // exitNotification.alertBody          = @"Entered a new region";
  exitNotification.alertAction          = @"This is different";
  
  [[UIApplication sharedApplication] presentLocalNotificationNow:exitNotification];
}


//should be called whenever a reminder is added
-(void)reminderAdded:(NSNotification *)notification
{

  NSDictionary *userInfo     = notification.userInfo;
  
  //CLCircularRegion *regionX;//   = userInfo[@"reminder"];
  
  // is not an array of keys
  //NSArray *deconstructedDict = [userInfo allKeysForObject:regionX];
  
  NSString *notificationName = notification.name;
  
  NSString *myKey = userInfo[@"key"][1];
  
  CLCircularRegion *region = userInfo[@"key"][0];

  if ([notificationName isEqualToString:@"ReminderAdded"])
  {
    self.selectedAnnotation.title = myKey;
    NSLog(@"key maybe %@", myKey);
  }
  
  //this is  a custom initilizer
  MKCircle *circleOverlay = [MKCircle circleWithCenterCoordinate:region.center radius:region.radius];
  
  [self.mapView addOverlay:circleOverlay];
  [self.mapView rendererForOverlay:circleOverlay];
}


#pragma OverlayRenderer
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
  //this will use the excact radius of our reminder - so we can visually see where our fence is
  MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
  printf("rendering circle\n");
  circleRenderer.fillColor = [UIColor redColor];
  circleRenderer.strokeColor = [UIColor grayColor];
  circleRenderer.alpha = .5;
  
  return circleRenderer;
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


//before this class exits we need to unregister the NSnotificationCenter
-(void)dealloc
{
  //best practice to remove this
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
