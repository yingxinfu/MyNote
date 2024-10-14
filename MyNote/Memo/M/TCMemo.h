//
//  TCMemo.h
//  SecurityNote
//
//  Created by fuyingxin.
//   Copyright  fuyingxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCMemo : NSObject

@property (nonatomic, assign) int ids;

@property (nonatomic, copy) NSString * title;

@property (nonatomic, copy) NSString * content;

@property (nonatomic, copy) NSString * memotype;

@property (nonatomic, copy) NSString * year;

@property (nonatomic, copy) NSString * time;


-(NSMutableArray *)queryWithNote;

-(void)deleteNote:(int)ids;

-(void)insertNote:(TCMemo *)memoNote;

-(TCMemo *)queryOneNote:(int)ids;

-(void)updataNote:(TCMemo *)updataNote;

@end
