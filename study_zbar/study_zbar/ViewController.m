//  Copyright (c) 2013 Naohiro OHTA. All rights reserved.
#import "ViewController.h"
#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.readerView.readerDelegate = self;
    if(TARGET_IPHONE_SIMULATOR) {
        self.cameraSim = [[ZBarCameraSimulator alloc]
                     initWithViewController: self];
        self.cameraSim.readerView = self.readerView;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) readerView: (ZBarReaderView*) view
     didReadSymbols: (ZBarSymbolSet*) syms
          fromImage: (UIImage*) img
{
    NSLog(@"%s",__func__);
    // do something useful with results
    for(ZBarSymbol *sym in syms) {
        self.resultText.text = sym.data;
        break;
    }
}

- (IBAction)scanButtonTapped_OLD2:(id)sender {
    NSLog(@"%s",__func__);
    
    ZBarImageScanner *scanner = [[ZBarImageScanner alloc] init];
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];

    ZBarReaderView *reader = [[ZBarReaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
    //ZBarReaderView *reader = [[ZBarReaderView alloc] initWithImageScanner:scanner];
    //[reader ]
    reader.backgroundColor = [UIColor blueColor];
    reader.readerDelegate = self;
    [self.view addSubview:reader];
    [globalVarAppDelegate.window bringSubviewToFront:reader];
}

- (IBAction)scanButtonTapped___dd____:(id)sender {
    NSLog(@"%s",__func__);
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    //ZBarCaptureReader
    [session startRunning];
}

- (IBAction)scanButtonTapped:(id)sender {
    NSLog(@"===%s",__func__);
    [self.readerView start];
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
