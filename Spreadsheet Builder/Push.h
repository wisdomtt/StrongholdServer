#ifndef  SPUSH_H
#define  SPUSH_H


#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>
#include "ViewController.h"
#import <UIKit/UIKit.h>

@interface MPCHandler : NSObject <MCSessionDelegate>
@property (nonatomic, strong) MCBrowserViewController *browser;
@property (nonatomic, strong) MCSession *session;

@property (nonatomic, strong) MCPeerID *peerID;
@property (nonatomic, strong) MCAdvertiserAssistant *advertiser;
@property (strong) NSData* info;

- (void)setupPeerWithDisplayName:(NSString *)displayName;
- (void)setupSession;
- (void)setupBrowser;
- (void)advertiseSelf:(BOOL)advertise;
-(void)SEND;

@end


#endif
