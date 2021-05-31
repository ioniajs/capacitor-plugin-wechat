#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(Wechat, "Wechat",
           CAP_PLUGIN_METHOD(isInstalled, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(shareText, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(shareLink, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(shareImage, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(shareMiniProgram, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(openMiniProgram, CAPPluginReturnPromise);
)
