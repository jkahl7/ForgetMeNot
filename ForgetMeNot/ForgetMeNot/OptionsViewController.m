//
//  OptionsViewController.m
//  ForgetMeNot
//
//  Created by Josh Kahl on 2/3/15.
//  Copyright (c) 2015 Josh Kahl. All rights reserved.
//

#import "OptionsViewController.h"
#import "MapViewController.h"

@interface OptionsViewController ()

@end

@implementation OptionsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.detailsText.delegate = self;
  
  self.saveButton.enabled = false;
  
  self.detailsText.placeholder = self.annotationInOptions.title;

}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  self.saveButton.enabled = true;
}


- (IBAction)saveButtonClicked:(id)sender //this will send out a notification that the text has been updated.
{
  if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) //??
  {
   
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:self.annotationInOptions.coordinate
                                                                 radius:200
                                                             identifier:@"Reminder"];
    [self.optionsLocationManager startMonitoringForRegion:region];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReminderAdded"
                                                        object:self
                                                      userInfo:@{@"key": @[region, self.detailsText.text]}];
  }                                                             //TODO: this is not a very elegant solution.....

  [self.navigationController popToRootViewControllerAnimated:true];
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

/*In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
  [self.navigationController popToRootViewControllerAnimated:true];
  // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

*/

@end
