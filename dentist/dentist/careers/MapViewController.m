//
//  MapViewController.m
//  dentist
//
//  Created by Shirley on 2018/12/12.
//  Copyright © 2018 thenextmediagroup.com. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "Common.h"

@interface MapViewController ()<MKMapViewDelegate>
@property (nonatomic) double longitude;
@property (nonatomic) double latitude;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *subTitle;
@property (nonatomic,strong) MKMapView *mapView;


@end

@implementation MapViewController


+(void)openBy:(UIViewController*)vc latitude:(double)latitude longitude:(double)longitude title:(NSString*)title subTitle:(NSString*)subTitle {
    MapViewController *mapVc = [MapViewController new];
    mapVc.longitude = longitude;
    mapVc.latitude = latitude;
    mapVc.title = title;
    mapVc.subTitle = subTitle;
    [vc pushPage:mapVc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavBar];
    
    [self buildViews];
    
    [self showLocation];
}

-(void)addNavBar{
    UINavigationItem *item = [self navigationItem];
    item.title = @"MAP";
    item.leftBarButtonItem = [self navBarBack:self action:@selector(dismiss)];
}

-(void)buildViews{
    self.mapView =[[MKMapView alloc]init];
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    self.mapView.zoomEnabled = YES;
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    [[[[[self.mapView.layoutMaker topParent:0]leftParent:0]rightParent:0]bottomParent:0]install];
    
    
}


-(void)showLocation{
    
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(self.latitude,self.longitude);
    
    MKPointAnnotation *pointAnnotation = [MKPointAnnotation new];
    pointAnnotation.coordinate = coords;
    pointAnnotation.title = self.title;
    pointAnnotation.subtitle = self.subTitle;
    [self.mapView addAnnotation:pointAnnotation];
    
    float zoomLevel = 0.02;
    MKCoordinateRegion region = MKCoordinateRegionMake(coords, MKCoordinateSpanMake(zoomLevel, zoomLevel));
    [self.mapView setRegion:region animated:YES];
   
    
}

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    static NSString *ID = @"location";
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (annoView == nil) {
        annoView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
        annoView.canShowCallout = YES;
    }
    annoView.annotation = annotation;
    annoView.image = [UIImage imageNamed:@"icon_gcoding"];
    __weak MKAnnotationView *weakAnnoView = annoView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakAnnoView setSelected:YES animated:YES];
    });

    return annoView;
}

@end
