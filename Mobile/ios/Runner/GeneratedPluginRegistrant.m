//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<pusher_client_fixed/PusherClientPlugin.h>)
#import <pusher_client_fixed/PusherClientPlugin.h>
#else
@import pusher_client_fixed;
#endif

#if __has_include(<rive_common/RivePlugin.h>)
#import <rive_common/RivePlugin.h>
#else
@import rive_common;
#endif

#if __has_include(<shared_preferences_foundation/SharedPreferencesPlugin.h>)
#import <shared_preferences_foundation/SharedPreferencesPlugin.h>
#else
@import shared_preferences_foundation;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [PusherClientPlugin registerWithRegistrar:[registry registrarForPlugin:@"PusherClientPlugin"]];
  [RivePlugin registerWithRegistrar:[registry registrarForPlugin:@"RivePlugin"]];
  [SharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"SharedPreferencesPlugin"]];
}

@end
