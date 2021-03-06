//
//  OptionsViewController.h
//  ForgetMeNot
//
//  Created by Josh Kahl on 2/3/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import <NotificationCenter/NotificationCenter.h>
@interface OptionsViewController : UITableViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *detailsText;

@property (strong, nonatomic) MKPointAnnotation *annotationInOptions;

@property (strong, nonatomic) CLLocationManager *optionsLocationManager;
//TODO: add location manager ClLocationManager


@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

- (IBAction)saveButtonClicked:(id)sender;

@end
