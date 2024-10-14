//
//  TCMemo.m
//  SecurityNote
//
//  Created by fuyingxin.
//   Copyright  fuyingxin. All rights reserved.
//

#import "TCMemo.h"
#import "TCMemoTool.h"

@implementation TCMemo
-(NSMutableArray *)queryWithNote
{
    return [TCMemoTool queryWithNote];
    
}

-(void)deleteNote:(int)ids
{
    [TCMemoTool deleteNote:ids];
    
}



-(void)insertNote:(TCMemo *)memoNote
{
    
    [TCMemoTool insertNote:memoNote];
}




-(TCMemo *)queryOneNote:(int)ids
{
    
    return [TCMemoTool queryOneNote:ids];
}




-(void)updataNote:(TCMemo *)updataNote
{
    [TCMemoTool updataNote:updataNote];
    
    
}

@end
