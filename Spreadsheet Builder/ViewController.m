//
//  ViewController.m
//  SendObj
//
//  Created by Curtis Mason on 12/2/15.
//  Copyright © 2015 Curtis Mason. All rights reserved.
//
#pragma mark NSURLConnection Delegate Methods
//
#import "ViewController.h"
#include "Push.h"
@interface ViewController()
@property(strong, nonatomic) NSMutableData* recievedData;
@property(strong, nonatomic) NSURLConnection *conn;
@end

@implementation ViewController
bool ChevalDeFrise = false;

MPCHandler *Handler;
NSDictionary *myDictionary;
NSData* Stuff;
MCSessionState *delegate;
-(NSString*)Capitalize:(NSString*) name{
    name = [name capitalizedString];
    return name;
}

-(IBAction)Detect:(id)sender{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *dictPath = [[paths objectAtIndex:0]
                          stringByAppendingPathComponent:@"Scout-<MCPeerID/ 0x7aa67650 DisplayName = IT WORKZ>-1457737260.525202"];
    
    NSDictionary *dictFromFile = [NSDictionary dictionaryWithContentsOfFile:dictPath];
    NSLog(@"%@", dictFromFile);
}
static NSString* NSStringFromQueryParameters(NSDictionary* queryParameters)
{
    NSMutableArray* parts = [NSMutableArray array];
    [queryParameters enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString *part = [NSString stringWithFormat: @"%@=%@",
                          [key stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding],
                          [value stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
                          ];
        [parts addObject:part];
    }];
    return [parts componentsJoinedByString: @"&"];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"Server Alive");
    _responseData = [[NSMutableData alloc] init];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    myDictionary = (NSDictionary*) [NSKeyedUnarchiver unarchiveObjectWithData:Handler.info];
   
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
}
- (void)viewDidLoad
{
    NSLog(@"Begins");
    [super viewDidLoad];
    Handler = [[MPCHandler alloc] init];
    [Handler setupPeerWithDisplayName:[UIDevice currentDevice].name];
    [Handler setupSession];
    [Handler advertiseSelf:true];    //if there is a connection going on just cancel it.
    NSMutableData *data = [[NSMutableData alloc] init];
    self.recievedData = data;
  
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

