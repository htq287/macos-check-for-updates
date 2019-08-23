//
//  SUTestWebServer.h
//  OsxCheckForUpdates
//
//  Created by Hung Truong on 5/6/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SUTestWebServer : NSObject

- (instancetype)initWithPort:(int)port workingDirectory:(NSString*)workingDirectory;

- (void)close;


@end

NS_ASSUME_NONNULL_END
