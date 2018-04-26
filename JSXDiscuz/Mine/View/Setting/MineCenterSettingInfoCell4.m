//
//  MineCenterSettingInfoCell4.m
//  JSXDiscuz
//
//  Created by 周思扬 on 2018/4/8.
//  Copyright © 2018年 周思扬. All rights reserved.
//

#import "MineCenterSettingInfoCell4.h"

@interface MineCenterSettingInfoCell4()
@property(nonatomic,strong) NSMutableDictionary * dictType;
@end

@implementation MineCenterSettingInfoCell4

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.insBtn1.tag=1;
    self.insBtn2.tag=2;
    self.insBtn3.tag=3;
    self.insBtn4.tag=4;
    self.insBtn5.tag=5;
    self.insBtn6.tag=6;
    self.insBtn7.tag=7;
    self.insBtn8.tag=8;
    self.insBtn9.tag=9;
    self.insBtn10.tag=10;
    self.insBtn11.tag=11;
    self.insBtn12.tag=12;
    self.insBtn13.tag=13;
    self.insBtn14.tag=14;
    
}

-(void)setInsData:(NSMutableArray *)insData
{
    _insData=insData;
    self.insBtn1.selected=[insData[0] boolValue];
    self.insBtn2.selected=[insData[1] boolValue];
    self.insBtn3.selected=[insData[2] boolValue];
    self.insBtn4.selected=[insData[3] boolValue];
    self.insBtn5.selected=[insData[4] boolValue];
    self.insBtn6.selected=[insData[5] boolValue];
    self.insBtn7.selected=[insData[6] boolValue];
    self.insBtn8.selected=[insData[7] boolValue];
    self.insBtn9.selected=[insData[8] boolValue];
    self.insBtn10.selected=[insData[9] boolValue];
    self.insBtn11.selected=[insData[10] boolValue];
    self.insBtn12.selected=[insData[11] boolValue];
    self.insBtn13.selected=[insData[12] boolValue];
    self.insBtn14.selected=[insData[13] boolValue];
}

-(void)setIntrestStr:(NSString *)intrestStr
{
    _intrestStr=intrestStr;
    NSArray * arr=[intrestStr componentsSeparatedByString:@","];
    NSMutableArray * indexArr=[NSMutableArray array];
    if(arr.count>0)
    {
        for(int i=0;i<arr.count;i++)
        {
            NSString * arrStr=arr[i];
            for (int j=0; j<self.dictType.allKeys.count; j++){
                [indexArr addObject:@"0"];
                NSString *key=self.dictType.allKeys[j];
                NSString *value=self.dictType[key];
                if([arrStr isEqualToString:value])
                {
                    [indexArr replaceObjectAtIndex:i withObject:@"1"];
                    break;
                }
            }
        }
        [self setInsData:indexArr];
    }
    
}


-(NSMutableDictionary *)dictType
{
    if(_dictType==nil)
    {
        _dictType=[NSMutableDictionary dictionary];
        [_dictType setObject:@"音乐" forKey:@"0"];
        [_dictType setObject:@"影视" forKey:@"1"];
        [_dictType setObject:@"读书" forKey:@"2"];
        [_dictType setObject:@"动漫" forKey:@"3"];
        [_dictType setObject:@"游戏" forKey:@"4"];
        [_dictType setObject:@"美食" forKey:@"5"];
        [_dictType setObject:@"旅游" forKey:@"6"];
        [_dictType setObject:@"运动" forKey:@"7"];
        [_dictType setObject:@"手工" forKey:@"8"];
        [_dictType setObject:@"宠物" forKey:@"9"];
        [_dictType setObject:@"收集" forKey:@"10"];
        [_dictType setObject:@"唱歌" forKey:@"11"];
        [_dictType setObject:@"跳舞" forKey:@"12"];
        [_dictType setObject:@"广泛" forKey:@"13"];
    }
    return _dictType;
}

@end
