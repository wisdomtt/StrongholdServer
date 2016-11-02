//
//  ViewController.h
//  SendObj
//
//  Created by Curtis Mason on 12/2/15.
//  Copyright © 2015 Curtis Mason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLConnectionDelegate>
{
    NSMutableData *_responseData;
}
@end