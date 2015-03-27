//
//  main.m
//  security-trust-settings-merge
//
//  Created by 夏目夏樹 on 3/27/15.
//
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc < 2) {
            printf("Usage: %s [plist ...] TrustSettings.plist\n", argv[0]);
            return 0;
        }

        NSDictionary *systemTrustSettings = [NSDictionary dictionaryWithContentsOfFile:@"/System/Library/Keychains/SystemTrustSettings.plist"];
        NSMutableDictionary *mutableSystemTrustSettings = [systemTrustSettings mutableCopy];
        NSMutableDictionary *mutableTrustList = [[NSMutableDictionary alloc] init];

        for (int i = 1; i < argc - 1; ++i) {
            [mutableTrustList addEntriesFromDictionary:[[NSDictionary dictionaryWithContentsOfFile:[NSString stringWithUTF8String:argv[i]]] objectForKey:@"trustList"]];
        }

        [mutableSystemTrustSettings setValue:mutableTrustList forKey:@"trustList"];
        [mutableSystemTrustSettings writeToFile:[NSString stringWithUTF8String:argv[argc - 1]] atomically:YES];
    }
    return 0;
}
