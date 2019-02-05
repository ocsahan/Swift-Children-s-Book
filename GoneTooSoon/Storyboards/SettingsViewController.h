//
//  SettingsViewController.h
//  GoneTooSoon
//
//  Created by Cagri Sahan on 4/16/18.
//  Copyright © 2018 Cagri Sahan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *settingsSwitch;

- (IBAction)settingsSwitchChanged:(id)sender;

@end
