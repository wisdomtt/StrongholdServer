//
//  WebPageAnalyzer.m
//  WebpageSource
//
//  Created by Curtis Mason on 4/21/16.
//  Copyright © 2016 Curtis Mason. All rights reserved.
//
#import "Analyze.h"
@interface WebPageAnalyzer ()
@end
@implementation WebPageAnalyzer
@synthesize URLCode;
-(void)WebPageAnalyzer:(NSString*)String{
    URLCode =String;
}
-(NSString*)Analyze:(const char*)character which:(int)number{
    int count = -1;
    int begin = 0;
    int etc = 0;
    int end = 0;
    int special=1;
    bool found = true;
    bool locate = false;
    while(found){
        if((character[count]=='e')&&(character[count+4]=='y')&&(character[count+5]=='.')&&special==number&&count>=0){
            locate = true;
            begin = count+6;
        }else if((character[count]=='e')&&(character[count+4]=='y')&&(character[count+5]=='.')&&special!=number){
            special++;
        }
        while(locate==true){
            count++;
            if(character[count]=='"'){
                locate = false;
                found = false;
                end = count-1;
            }
        }
        count++;
    }
    int interval = (end-begin)+1;
    char code[interval];
    while((end+1)>=(begin)){
        if(character[begin]!=' '){
            code[etc] = character[begin];
                    }else if(character[begin] ==' '){
                        break;
        }else{
            break;
        }
        begin++;
        etc++;
    }
    NSString *s = [NSString stringWithFormat:@"%s", code];
    return s;
}
//NSASCIIStringEncoding
//NSUTF8StringEncoding
- (void)Digest{
    NSError *error = nil;
    NSString *urlString = [NSString stringWithFormat:@"%@",URLCode];
    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    NSString *webSource = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    //NSString *vital = [webSource stringByReplacingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    const char *c = [webSource UTF8String];
    for(int x = 1; x < 21; x++){
        NSLog(@"Code: %d,  %@", x, [self Analyze:c which:x]);
    }
}
@end
