@interface Card : NSObject {
  NSString *name;
  NSString *heart;
  NSString *pic;
  NSString *category;
  NSArray *related;
}

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *heart;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSArray *related;

- initWithDictionary:(NSDictionary *)json;
- initWithName:(NSString *)aName heart:(NSString *)aHeart pic:(NSString *)aPic category:(NSString *)aCategory related:(NSArray *)theRelated;

- (UIImage *)image;
@end
