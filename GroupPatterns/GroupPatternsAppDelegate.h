@class CardListController;

@interface GroupPatternsAppDelegate : NSObject <UIApplicationDelegate> {
  IBOutlet CardListController *cardListController;
  UIView *waitPane;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet UINavigationController *navigationController;

@end
