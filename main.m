//
//  main.m
//  localNotifications
//
//  Created by maliy on 8/4/10.
//  Copyright 2010 interMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"localNotificationsAppDelegate");
    [pool release];
    return retVal;
}
