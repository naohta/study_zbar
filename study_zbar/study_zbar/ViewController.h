//  Copyright (c) 2013 Amaoto studio All rights reserved.
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <ZBarReaderViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *resultText;
@property ZBarCameraSimulator *cameraSim;
- (IBAction)scanButtonTapped:(id)sender;
@property (strong, nonatomic) IBOutlet ZBarReaderView *readerView;

@end
