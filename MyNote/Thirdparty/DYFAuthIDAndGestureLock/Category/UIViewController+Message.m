//
//  UIViewController+Message.m
//
//  Created by fuyingxin.
//  Copyright © fuyingxin. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "UIViewController+Message.h"

@implementation UIViewController (Message)

- (void)yf_showMessage:(NSString *)message {
    if (@available(iOS 8.0, *)) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:NULL];
        [self performSelector:@selector(dismissMessageBox:) withObject:alertController afterDelay:1.f];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [alertView show];
        [self performSelector:@selector(dismissMessageBox:) withObject:alertView afterDelay:1.f];
    }
}

- (void)dismissMessageBox:(id)objc {
    if ([objc isKindOfClass:[UIAlertController class]]) {
        UIAlertController *alertController = (UIAlertController *)objc;
        [alertController dismissViewControllerAnimated:YES completion:NULL];
    } else {
        UIAlertView *alertView = (UIAlertView *)objc;
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
    }
}

@end
