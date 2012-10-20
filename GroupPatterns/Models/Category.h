@interface Category : NSObject
@property(nonatomic) NSString *name;

@property(nonatomic) NSArray *cards;
@property(nonatomic) NSString *desc;

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSString *)imageName;
@end