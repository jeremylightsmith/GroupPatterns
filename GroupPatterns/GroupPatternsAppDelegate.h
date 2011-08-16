@class CardListController;

@interface GroupPatternsAppDelegate : NSObject <UIApplicationDelegate> {
  IBOutlet CardListController *cardListController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end
