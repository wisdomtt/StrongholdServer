#include "Push.h"
@interface MPCHandler() <MCSessionDelegate>
//advertise showing
//browse looking

@end
@implementation MPCHandler
int sCount = 0;
NSString *CID = @"ghjkl2";
NSString *value;
MCSession* derpy;
bool something = false;
- (void)setupPeerWithDisplayName:(NSString *)displayName{
    NSLog(@"Step 1/4");
    self.peerID = [[MCPeerID alloc] initWithDisplayName:displayName];//name
}
- (void)setupSession{
    NSLog(@"Step 2/4");
    self.session = [[MCSession alloc] initWithPeer:_peerID];
    self.session.delegate=self;
}
- (void)setupBrowser{
    
    self.browser = [[MCBrowserViewController alloc] initWithServiceType:CID session:_session];;
}
- (void)advertiseSelf:(BOOL)advertise {
    if (advertise) {
        self.advertiser = [[MCAdvertiserAssistant alloc] initWithServiceType:CID discoveryInfo:nil session:self.session];
        [self.advertiser start];
        
    } else {
        [self.advertiser stop];
        self.advertiser = nil;
        //  derpy = _session;
    }
    
    NSLog(@"Step 4/4");
    
}

-(void)SEND{
   // NSLog(@"Peer Name: %@", self.session.connectedPeers);
    NSData* data = [[NSData alloc]init];
    data = nil;
    NSError* error = nil;
    //MCSessionSendDataMode
    //[data setValue:@"0" forKey:@"HAI"];
    [self.session sendData:data toPeers:self.session.connectedPeers withMode:(MCSessionSendDataReliable) error:&error];
}

#pragma mark -
#pragma mark Session Delegate Methods
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    NSDictionary *userInfo = @{ @"peerID": peerID,
                                @"state" : @(state) };
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MPCDemo_DidChangeStateNotification"
                                                            object:nil
                                                          userInfo:userInfo];
      //  NSLog(@"%@", userInfo);

    });
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    NSDictionary *userInfo = @{ @"data": data,
                                @"peerID": peerID };
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MPCDemo_DidReceiveDataNotification"
                                                            object:nil
                                                          userInfo:userInfo];
    });
    NSString* myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

        NSError *error;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
        NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"/2016ScoutingInfo"];
    
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error];
    
        double unixTime = [[NSDate date] timeIntervalSince1970];
        NSString *UnixTime = [NSString stringWithFormat:@"%f", unixTime];
    
        documentsDirectory = [NSString stringWithFormat:@"%@/2016ScoutingInfo", documentsDirectory];
    
    
        BOOL succeed = [myString writeToFile:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", UnixTime]] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if(!succeed){
        NSLog(@"Fail");
        NSLog(@"%@", myString);
    }
    else{
        sCount++;
        NSLog(@"%d", sCount);

    }
}

- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress {
    
}

- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error {
    
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID {
    
}
@end


@interface MCSessionDelegate:NSObject

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state;
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID;
- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress;
- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error;
- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID;

@end

@implementation MCSessionDelegate : NSObject
//MCSession Work Pls

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
    NSDictionary *userInfo = @{ @"peerID": peerID,
                                @"state" : @(state) };
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MPCDemo_DidChangeStateNotification"
                                                            object:nil
                                                          userInfo:userInfo];
    });
}
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    NSDictionary *userInfo = @{ @"data": data,
                                @"peerID": peerID };
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MPCDemo_DidReceiveDataNotification"
                                                            object:nil
                                                          userInfo:userInfo];
    });
    // something = true;
    // value = [data valueForKey:@"HAI"];
    
    NSLog(@"Something was recieved?");
}

- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress {
    
}

- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error {
    
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID {
    
}

@end
