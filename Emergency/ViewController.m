//
//  ViewController.m
//  Emergency
//
//  Created by Ádamo Morone on 15/09/13.
//  Copyright (c) 2013 Morone Soluções Tecnológicas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize Location;
@synthesize locationManager;



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
    if (self.locationManager == nil)
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy =
        kCLLocationAccuracyNearestTenMeters;
        self.locationManager.delegate = self;
    }
    [self.locationManager startUpdatingLocation];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Turn off the location manager to save power.
    [self.locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)textFieldReturn:(id)sender{
    
    [sender resignFirstResponder];
}

-(IBAction)EnviarEmergencia:(id)sender
{
    
    CLLocation *curPos = locationManager.location;
    NSString *latitude = [[NSNumber numberWithDouble:curPos.coordinate.latitude] stringValue];
    
    NSString *longitude = [[NSNumber numberWithDouble:curPos.coordinate.longitude] stringValue];
    
   /* NSLog(@"Lat: %@", latitude);
    NSLog(@"Long: %@", longitude);*/
    
    NSString *parametros = [NSString stringWithFormat:@"&latitude=%@&longitude=%@&usuario=%@", latitude, longitude, [[UIDevice currentDevice] name]];
    NSData *postData = [parametros dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSURL *url = [NSURL URLWithString:@"http://morone.org/alerta/gravar.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    
    
    NSString *mensagem;
   
    @try {
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
        [request setHTTPBody:[parametros dataUsingEncoding:NSUTF8StringEncoding]];
        [NSURLConnection connectionWithRequest:request delegate:self];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        mensagem = @"Sua mensagem foi enviada com sucesso!";
        
    }
    @catch (NSException *exception) {
        mensagem = exception.reason;
    }
    @finally {}
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pânico"
                                                    message: mensagem
                                                    delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
    
    [alert show];
    
    NSLog(@"&latitude=%@&longitude=%@&usuario=%@", latitude, longitude, [[UIDevice currentDevice] name]);


    
}






@end
