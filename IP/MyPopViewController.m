//
//  MyPopViewController.m
//  IP
//
//  Created by 卓程 on 2018/9/19.
//  Copyright © 2019 chengchengzhuo. All rights reserved.
//

#import "MyPopViewController.h"

#import <sys/socket.h>
#import <ifaddrs.h>
#import <netinet/in.h>
#import <arpa/inet.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
@interface MyPopViewController ()
@property (weak) IBOutlet NSTextField *ipLabel;
@end

@implementation MyPopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ipLabel.stringValue = @"获取IP地址...";
    self.ipLabel.stringValue = [self getDeviceIPAddress];
}

- (BOOL)writeToPasteboard{
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    [pasteboard setString:self.ipLabel.stringValue forType:NSPasteboardTypeString];
    return YES;
}
- (IBAction)btnClick:(id)sender {
    NSLog(@"asdasdsadsad");
    [self writeToPasteboard];
}

- (NSString *)getDeviceIPAddress {
    NSString *address = @"获取失败请重试!!";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    struct sockaddr_in *sockaddr = (struct sockaddr_in *)temp_addr->ifa_addr;
                    address = [NSString stringWithUTF8String:inet_ntoa(sockaddr->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    return address;
}
@end
