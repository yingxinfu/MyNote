//
//  TCDiary.m
//  SecurityNote
//
//  Created by fuyingxin.
//   Copyright  fuyingxin. All rights reserved.
//

#import "TCDiary.h"
#import "TCDiaryTool.h"

@implementation TCDiary


-(NSMutableArray *)queryWithNote
{
   return [TCDiaryTool queryWithNote];

}



-(void)deleteNote:(int)ids
{
    [TCDiaryTool deleteNote:ids];

}



-(void)insertNote:(TCDiary *)diaryNote
{

    [TCDiaryTool insertNote:diaryNote];
}




-(TCDiary *)queryOneNote:(int)ids
{

    return [TCDiaryTool queryOneNote:ids];
}




-(void)updataNote:(TCDiary *)updataNote
{
    [TCDiaryTool updataNote:updataNote];


}


@end
