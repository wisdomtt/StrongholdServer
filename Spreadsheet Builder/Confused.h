//
//  ViewController.h
//  SendObj
//
//  Created by Curtis Mason on 12/2/15.
//  Copyright © 2015 Curtis Mason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Confused : UIViewController<NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
}
@end