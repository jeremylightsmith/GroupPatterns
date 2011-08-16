#import "AsyncImageView.h"

@implementation AsyncImageView

- (void)dealloc {
	[connection cancel]; 
	[connection release];
	[data release]; 
  [super dealloc];
}

- (void)loadImageFromURL:(NSURL*)url {
	if (connection != nil) { [connection release]; connection = nil; }
	if (data != nil) { [data release]; data = nil; }
	
	NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	if (data == nil) { data = [[NSMutableData alloc] initWithCapacity:2048]; } 
	[data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	[connection release];
	connection=nil;
  
  self.image = [UIImage imageWithData:data];
  
	[data release]; //don't need this any more, its in the UIImageView now
	data=nil;
}

@end