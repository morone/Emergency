//
//  ViewController.h
//  Emergency
//
//  Created by Ádamo Morone on 30/09/13.
//  Copyright (c) 2013 Morone Soluções Tecnológicas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>{
    CLLocationCoordinate2D Location;
}

@property (nonatomic, assign) CLLocationCoordinate2D Location;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end
