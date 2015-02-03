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
 
  //asks the user for permission to access their location
  [self.locationManager requestWhenInUseAuthorization];
  
  [self.mapView setMapType:MKMapTypeStandard];
  [self.mapView setZoomEnabled:YES];
  [self.mapView setScrollEnabled:YES];
  //[self.locationManager startUpdatingLocation];
  
  //self.mapView.showsUserLocation = YES;
}

//is called once when the MapVC is instantiated.
-(void)viewDidAppear:(BOOL)animated
{
  [self.locationManager startUpdatingLocation];
  self.mapView.showsUserLocation = YES;
  /*
  //initial location is 39.277988,-76.622704 (M&T bank)
  CLLocationCoordinate2D initialLocation;
  initialLocation.latitude = 39.277988;
  initialLocation.longitude = -76.622704;
  
  MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(initialLocation, 2000, 2000);
  
  [self.mapView setRegion:viewRegion animated:YES];
   */
  
  
}

// 47.6277904,-122.3427506
- (IBAction)homeClicked:(id)sender
{
  [self.locationManager stopUpdatingLocation];
  CLLocationCoordinate2D initialLocation;
  initialLocation.latitude = 47.6277904;
  initialLocation.longitude = -122.3427506;
  
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(initialLocation, 750, 750);
  
  [self.mapView setRegion:region animated:YES];
  
  //Starts the generation of updates that report the user’s current location
  //The accuracy of the location data.
  //self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
  // minimum distance (measured in meters) a device must move horizontally before an update event is generated
  //self.locationManager.distanceFilter = kCLDistanceFilterNone;
  
  printf("homeClicked %d\n", 98109);
}


// L&L @42.3998257,-71.1271535
- (IBAction)oldHomeClicked:(id)sender
{
  [self.locationManager stopUpdatingLocation];
  CLLocationCoordinate2D initialLocation;
  initialLocation.latitude = 42.3998257;
  initialLocation.longitude = -71.1271535;
  
  MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(initialLocation, 750, 750);
  
  [self.mapView setRegion:viewRegion animated:YES];

  printf("oldhomeClicked %i\n", 02144);
  NSLog(@"42.3998257,-71.1271535");
}


// L&L 39.313729,-76.473313
- (IBAction)olderHomeClicked:(id)sender
{
  [self.locationManager stopUpdatingLocation];
  CLLocationCoordinate2D initialLocation;
  initialLocation.latitude = 39.313729;
  initialLocation.longitude = -76.473313;
  
  MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(initialLocation, 750, 750);
  
  [self.mapView setRegion:viewRegion animated:YES];

  printf("olderHomeClicked %d\n", 21221);
  NSLog(@"39.313729,-76.473313");
}


- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
  MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
  [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

-(NSString *)deviceLocation
{
  return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}

-(NSString *)deviceLatatude
{
  return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.latitude];
}

-(NSString *)deviceLongitude
{
  return [NSString stringWithFormat:@"%f", self.locationManager.location.coordinate.longitude];
}

-(NSString *)deviceAltitude
{
  return [NSString stringWithFormat:@"%f",self.locationManager.location.altitude];
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
