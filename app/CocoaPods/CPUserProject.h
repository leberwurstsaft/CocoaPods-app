#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

/// A CPUserProject is a project that is pretty much always
/// represented by a Podfile, while it may have overlap
/// the job of actually representing the Podfile and it's
/// metadata is handled by `CPPodfile` from CocoaPods-ObjC

@interface CPUserProject : NSDocument

/// The raw string content of the Podfile
@property (strong) NSString * contents;

/// Registerable properties
/// Note: These _start out_ as nil, but can only be changed to
/// non-null objects, thus allowing us to check for existence
/// for the registering promise.

/// Plugins that are used within the Podfile
@property (nonatomic, strong) NSArray <NSString *> *podfilePlugins;

/// The Xcodeprojects and CP Targets that are represented by the Podfile
@property (nonatomic, strong) NSDictionary *xcodeIntegrationDictionary;

/// Register for when podfilePlugins and the xcodeIntegrationDictionary are filled
- (void)registerForFullMetadataCallback:(void (^)(void))completion;

@end

NS_ASSUME_NONNULL_END