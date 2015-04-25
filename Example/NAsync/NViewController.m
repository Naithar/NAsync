//
//  NViewController.m
//  NAsync
//
//  Created by Naithar on 04/18/2015.
//  Copyright (c) 2014 Naithar. All rights reserved.
//

#import "NViewController.h"
@import NAsync;

@interface NViewController ()

@end

@implementation NViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NHAsyncManager *queuePromiseManager = [NHAsyncManager promiseQueue:nil block:^(NHAsyncOperation *operation, id value) {
        NSLog(@"promise queue");
    }];

    @autoreleasepool {
    NHAsyncOperation *operation = [[NHAsyncOperation alloc] initWithDelay:0
                                                               priority:NSOperationQueuePriorityNormal previousOperation:nil
                                                               andReturnBlock:^(NHAsyncOperation *operation, id value) {
                                                                   NSLog(@"value = %@", value);
                                                                   for (int i = 0; i < 100; i++) {
                                                                       NSLog(@"%d", i);
                                                                   }

                                                                   return @90;
                                                               }];

    [operation performInQueue:[[NSOperationQueue alloc] init] withValue:@101];

    NSLog(@"result = %@", [operation wait]);
    }


    @autoreleasepool {
    NHAsyncManager *asyncManager = [[NHAsyncManager alloc] initWithQueue:nil withDelay:0 priority:NSOperationQueuePriorityNormal previousOperation:nil andReturnBlock:^id(NHAsyncOperation *operation, id value) {
        NSLog(@"value 2 = %@", value);
        return @10;
    }];


    NSLog(@"result 2 = %@", [[asyncManager performWithValue:@50] wait]);
    }

    @autoreleasepool {
    [NHAsyncManager queue:nil block:^(NHAsyncOperation *operation, id value) {
        NSLog(@"queue");
    }];
    }

    [queuePromiseManager queue:nil block:^(NHAsyncOperation *operation, id value) {
        NSLog(@"chained from promise");
    }];

    NHAsyncManager *manager = [queuePromiseManager promiseQueue:nil block:^(NHAsyncOperation *operation, id value) {
        NSLog(@"chained prmise from promise");
    }];


    [manager perform];

    [[NHAsyncManager main:^(NHAsyncOperation *operation, id value) {
        self.view.backgroundColor = [UIColor redColor];
    }] main:^(NHAsyncOperation *operation, id value) {
        self.view.backgroundColor = [UIColor greenColor];
    } withDelay:10];


    [NHAsyncManager main:^(NHAsyncOperation *operation, id value) {
        self.view.backgroundColor = [UIColor grayColor];
    } withDelay:5];

    [queuePromiseManager main:^(NHAsyncOperation *operation, id value) {
        self.view.backgroundColor = [UIColor blueColor];
    }];

    [queuePromiseManager perform];
    [queuePromiseManager perform];


    [[NHAsyncManager queue:nil returnBlock:^id(NHAsyncOperation *operation, id value) {
        return [UIColor redColor];
    }] main:^(NHAsyncOperation *operation, UIColor *value) {
        self.view.backgroundColor = value;
    } withDelay:15];
	// Do any additional setup after loading the view, typically from a nib.


    [[NHAsyncManager async:^(NHAsyncOperation *operation, id value) {
        NSLog(@"async operation");
    }] async:^(NHAsyncOperation *operation, id value) {
        NSLog(@"async operation 2");
    }];

    [NAsync async:^(NHAsyncOperation *operation, id value) {
        return;
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
