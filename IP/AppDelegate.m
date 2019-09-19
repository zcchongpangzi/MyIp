//
//  AppDelegate.m
//  IP
//
//  Created by 卓程 on 2018/9/19.
//  Copyright © 2019 chengchengzhuo. All rights reserved.
//

#import "AppDelegate.h"
#import "MyPopViewController.h"
@interface AppDelegate ()
@property (nonatomic, strong) NSStatusItem *item;
@property (nonatomic, strong) NSPopover *popover;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
    NSStatusBar *statusBar = [NSStatusBar systemStatusBar];
        
    NSStatusItem *item = [statusBar statusItemWithLength:NSVariableStatusItemLength];
    
    NSImage *image = [NSImage imageNamed:@"ipIcon"];
    image.size = CGSizeMake(20, 20);
    item.button.image = image;
    item.button.target = self;
    item.button.action = @selector(showPopover:);
    self.item = item;
    
    
    
    
    NSPopover *popover = [[NSPopover alloc] init];
    popover.behavior = NSPopoverBehaviorTransient;
    popover.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantLight];
    popover.contentViewController = [[MyPopViewController alloc]init];
    self.popover = popover;
    
    
    __weak typeof (self) weakSelf = self;
    [NSEvent addGlobalMonitorForEventsMatchingMask:NSEventMaskLeftMouseDown handler:^(NSEvent * event) {
        if (weakSelf.popover.isShown) {
            // 关闭popover；
            [weakSelf.popover close];
        }
    }];
    
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)showPopover:(NSStatusBarButton *)button{
    [_popover showRelativeToRect:button.bounds ofView:button preferredEdge:NSRectEdgeMaxY];
}
@end
