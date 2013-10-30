//
//  ViewController.h
//  study_zbar
//
//  Created by Naohiro OHTA on 8/7/13.
//  Copyright (c) 2013 Amaoto Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <ZBarReaderDelegate>
@property (weak, nonatomic) IBOutlet UITextView *resultText;
- (IBAction)scanButtonTapped:(id)sender;
@end
