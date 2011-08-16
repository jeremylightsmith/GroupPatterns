@interface Card : NSObject {
  NSString *name;
  NSString *heart;
  NSString *pic;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *heart;
@property (nonatomic, retain) NSString *pic;

- initWithDictionary:(NSDictionary *)json;
- initWithName:(NSString *)aName heart:(NSString *)aHeart pic:(NSString *)aPic;

- (NSDictionary *)toDictionary;

@end
