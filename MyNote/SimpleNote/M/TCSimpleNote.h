//
//  TCSimpleNote.h
//  SecurityNote
//
//  Created by fuyingxin.
//   Copyright  fuyingxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCSimpleNote : NSObject


@property (nonatomic, assign) int ids;

@property (nonatomic, assign) int count;

@property (nonatomic, strong) NSMutableArray * datas;


-(NSMutableArray *)queryWithData;

-(void)upDateString:(NSString *)string forRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)insertDatas:(TCSimpleNote *)addNote;

-(void)deleteString:(TCSimpleNote *)deleteStr;

-(void)upDateInsert:(TCSimpleNote *)upDateInsert;

@end
