/**
 * This client was automatically generated by Segment Typewriter. ** Do Not Edit **
 */

#import <Analytics/SEGSerializableValue.h>
#import "SEGTypewriterUtils.h"

@implementation SEGTypewriterUtils

+ (nonnull SERIALIZABLE_DICT)withTypewriterContextFields:(nullable SERIALIZABLE_DICT)options
{
  options = options ?: @{};
  NSDictionary<NSString *, id> *customContext = options[@"context"] ?: @{};
  NSDictionary<NSString *, id> *typewriterContext = @{
    @"typewriter": @{
      @"language": @"objective-c",
      @"version": @"7.4.0"
    }
  };
  NSMutableDictionary *context = [NSMutableDictionary dictionaryWithCapacity:customContext.count + typewriterContext.count];
  [context addEntriesFromDictionary:customContext];
  [context addEntriesFromDictionary:typewriterContext];
  
  NSMutableDictionary *newOptions = [NSMutableDictionary dictionaryWithCapacity:options.count + 1];
  [newOptions addEntriesFromDictionary:options];
  [newOptions addEntriesFromDictionary:@{
    @"context": context
  }];

  return newOptions;
}

// This method exists primarily because we need to handle the complexity of arrays of arrays.
// Because of unknown nested array depth, we can't easily inline the serialization logic,
// instead we need to recurse over sub-objects for serialization.
+ (nonnull NSArray<id> *)toSerializableArray:(nonnull NSArray<id> *) arr {
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    [arr enumerateObjectsUsingBlock:^(id element, NSUInteger idx, BOOL *stop) {
        if ([element isKindOfClass:[NSArray class]]) {
            // This is an array of arrays.
            newArray[idx] = [SEGTypewriterUtils toSerializableArray:element];
        } else if ([element conformsToProtocol:@protocol(SEGTypewriterSerializable)]) {
            // This is an array of objects.
            newArray[idx] = [element toDictionary];
        } else {
            // This element must be otherwise serializable (string, number, etc).
            newArray[idx] = element;
        }
    }];
    
    return newArray;
}

@end
