//
//  TripNetManager.h
//  WeatherNews
//
//  Created by jake on 15/11/4.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "BaseNetManager.h"
#import "S2StationModel.h"
#import "LeftTicketModel.h"
@interface TripNetManager : BaseNetManager
//获取站到站的数据
+ (id)getS2StaionDataFromStart:(NSString *)start toEnd:(NSString *)end CompletionHandle:(void(^)(S2StationModel *model , NSError *error))completionHandle;

+ (id)getLeftTicketDataFromStation:(NSString *)start toStation:(NSString *)end andDate:(NSString *)date CompletionHandle:(void(^)(LeftTicketModel *model , NSError *error))completionHandle;
@end
