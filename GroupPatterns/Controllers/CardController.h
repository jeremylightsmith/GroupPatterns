@class Card;
@class AsyncImageView;

@interface CardController : UIViewController {
  IBOutlet UILabel *titleLabel;
  IBOutlet UILabel *heartLabel;
  IBOutlet AsyncImageView *imageView;
  
  Card *card;
}

@property (nonatomic, retain) Card *card;

@end
