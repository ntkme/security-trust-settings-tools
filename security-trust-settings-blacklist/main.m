//
//  main.m
//  security-trust-settings-blacklist
//
//  Created by 夏目夏樹 on 3/27/15.
//
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc < 2) {
            printf("Usage: %s [fingerprint ...] TrustSettings.plist\n", argv[0]);
            return 0;
        }

        NSDictionary *systemTrustSettings = [NSDictionary dictionaryWithContentsOfFile:@"/System/Library/Keychains/SystemTrustSettings.plist"];
        NSMutableDictionary *mutableSystemTrustSettings = [systemTrustSettings mutableCopy];
        NSMutableDictionary *mutableTrustList = [[NSMutableDictionary alloc] init];

        for (int i = 1; i < argc - 1; ++i) {
            NSString *fingerprint = [[[NSString stringWithUTF8String:argv[i]] stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@":" withString:@""];
            if ([fingerprint length] != 40) {
                fprintf(stderr, "Error: Invalid SHA1 fingerprint: %s\n", argv[i]);
                return 1;
            }
            [mutableTrustList setValue:@{
                                         @"issuerName" : [[NSData alloc] init],
                                         @"modDate" : [NSDate date],
                                         @"serialNumber" : [[NSData alloc] init],
                                         @"trustSettings" : @[@{(__bridge NSString *)kSecTrustSettingsResult : [NSNumber numberWithInt:kSecTrustSettingsResultDeny]}],
                                         } forKey:fingerprint];
        }

        [mutableSystemTrustSettings setValue:mutableTrustList forKey:@"trustList"];
        [mutableSystemTrustSettings writeToFile:[NSString stringWithUTF8String:argv[argc - 1]] atomically:YES];
    }
    return 0;
}
