#import <UIKit/UIKit.h>
#import <React/RCTLog.h>
#import <React/RCTBridgeModule.h>
#import "RCTToast+UIView.h"


@interface RCTToast : NSObject <RCTBridgeModule>
@end

@implementation RCTToast

RCT_EXPORT_MODULE(RCTToast)


RCT_EXPORT_METHOD(show:(NSDictionary *)options) {
    NSString *message  = [options objectForKey:@"message"];
    NSString *duration = [options objectForKey:@"duration"];
    NSString *position = [options objectForKey:@"position"];
    NSNumber *addPixelsY = [options objectForKey:@"addPixelsY"];
    
    if (![position isEqual: @"top"] && ![position isEqual: @"center"] && ![position isEqual: @"bottom"]) {
        RCTLogError(@"invalid position. valid options are 'top', 'center' and 'bottom'");
        return;
    }
    
    NSInteger durationInt;
    if ([duration isEqual: @"short"]) {
        durationInt = 2;
    } else if ([duration isEqual: @"long"]) {
        durationInt = 5;
    } else {
        RCTLogError(@"invalid duration. valid options are 'short' and 'long'");
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[[UIApplication sharedApplication]windows]firstObject] makeToast:message duration:durationInt position:position addPixelsY:addPixelsY == nil ? 0 : [addPixelsY intValue]];
    });
}

RCT_EXPORT_METHOD(hide) {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[[[UIApplication sharedApplication]windows]firstObject] hideToast];
    });
}

@end