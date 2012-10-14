@interface Card : NSObject {
  NSString *name;
  NSString *heart;
  NSString *pic;
  NSString *category;
  NSArray *related;
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *heart;
@property (nonatomic, retain) NSString *pic;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSArray *related;

- initWithDictionary:(NSDictionary *)json;
- initWithName:(NSString *)aName heart:(NSString *)aHeart pic:(NSString *)aPic category:(NSString *)aCategory related:(NSArray *)theRelated;

- (NSDictionary *)toDictionary;

@end
