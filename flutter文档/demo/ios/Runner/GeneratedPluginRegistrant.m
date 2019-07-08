//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <aeyrium_sensor/AeyriumSensorPlugin.h>
#import <flute_music_player/MusicFinderPlugin.h>
#import <flutter_inappbrowser/InAppBrowserFlutterPlugin.h>
#import <photo_manager/ImageScannerPlugin.h>
#import <video_player/VideoPlayerPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [AeyriumSensorPlugin registerWithRegistrar:[registry registrarForPlugin:@"AeyriumSensorPlugin"]];
  [MusicFinderPlugin registerWithRegistrar:[registry registrarForPlugin:@"MusicFinderPlugin"]];
  [InAppBrowserFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"InAppBrowserFlutterPlugin"]];
  [ImageScannerPlugin registerWithRegistrar:[registry registrarForPlugin:@"ImageScannerPlugin"]];
  [FLTVideoPlayerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTVideoPlayerPlugin"]];
}

@end
