//
//  FGTNetworking.h
//  DailyWeather
//
//  Created by FGT MAC on 7/5/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FGTOpenWeatherModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FGTNetworking : NSObject

typedef void (^OpenWeatherCompletion)(FGTOpenWeatherModel * _Nullable weather, NSError * _Nullable error);


-(void)fetchWeather:(NSString *)aLat long:(NSString *)aLong completion:(OpenWeatherCompletion)completion;


@end

NS_ASSUME_NONNULL_END
