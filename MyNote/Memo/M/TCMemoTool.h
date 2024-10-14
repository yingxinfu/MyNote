//
//  TCMemoTool.h
//  SecurityNote
//
//  Created by fuyingxin.
//   Copyright  fuyingxin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TCMemo;

@interface TCMemoTool : NSObject

+(NSMutableArray *)queryWithNote;

+(void)deleteNote:(int)ids;

+(void)insertNote:(TCMemo *)memoNote;

+(TCMemo *)queryOneNote:(int)ids;

+(void)updataNote:(TCMemo *)updataNote;


@end
