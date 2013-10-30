//  Copyright (c) 2013 Naohiro OHTA. All rights reserved.
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)scanButtonTapped:(id)sender {
    NSLog(@"%s",__func__);
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    [self presentViewController:reader animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)reader didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"%s",__func__);
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil; 
    NSMutableArray *ary = [@[] mutableCopy];
    for (symbol in results) [ary addObject:symbol.data];
    NSLog(@"%@",ary);
    NSMutableString *barcodeText = [@"" mutableCopy];
    for (NSString *s in ary) {
        [barcodeText appendString:s];
        [barcodeText appendString:@"\n"];
    }
    self.resultText.text = barcodeText;
    [reader dismissViewControllerAnimated:YES completion:nil];
}
@end
