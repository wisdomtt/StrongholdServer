//
//  Analyze.h
//  Spreadsheet Builder
//
//  Created by Curtis Mason on 5/17/16.
//  Copyright © 2016 Curtis Mason. All rights reserved.
//

#ifndef Analyze_h
#define Analyze_h
#import <UIKit/UIKit.h>

@interface WebPageAnalyzer : NSObject
@property (nonatomic, strong) NSString* URLCode;
-(void)WebPageAnalyzer:(NSString*)String;
-(void)Digest;
-(NSString*)Analyze:(const char*)character which:(int)number;
@end

#endif /* Analyze_h */
