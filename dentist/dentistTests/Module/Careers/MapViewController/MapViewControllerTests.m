
//
//  MapViewControllerTests.m
//  dentistTests
//
//  Created by Su Ho V. on 1/9/19.
//  Copyright © 2019 thenextmediagroup.com. All rights reserved.
//

#import "Kiwi.h"
#import "MapViewController.h"
#import <MapKit/MapKit.h>

SPEC_BEGIN(MapViewControllerTests)
describe(@"Unit Test For MapViewController", ^{
    __block MapViewController *controller;

    beforeEach(^{
        controller = [MapViewController new];
    });

    context(@"methods", ^{
        it(@"openBy", ^{
            [MapViewController openBy:[UIViewController new] latitude:0 longitude:0 title:@"title" subTitle:@"subTitle"];
            [[theValue(controller.view) shouldNot] beNil];
        });

        it(@"viewForAnnotation", ^{
            MKAnnotationView *view = [controller mapView:[MKMapView new] viewForAnnotation:[MKAnnotationView new]];
            [[theValue(view) shouldNot] beNil];
        });
    });
});
SPEC_END
