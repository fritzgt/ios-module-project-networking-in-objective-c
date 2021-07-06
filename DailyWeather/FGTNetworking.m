//
//  FGTNetworking.m
//  DailyWeather
//
//  Created by FGT MAC on 7/5/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import "FGTNetworking.h"

@implementation FGTNetworking


-(void)fetchWeather:(NSString *)aLat long:(NSString *)aLong completion:(OpenWeatherCompletion)completion
{
    //api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    NSURL *baseURL = [NSURL URLWithString:@"api.openweathermap.org/data/2.5/weather"];
    NSString *appKey = @"98e928ba74109243f3daa2e979e3d421";
    NSURLComponents *componets = [[NSURLComponents alloc] initWithURL:baseURL resolvingAgainstBaseURL:YES];
    

//    Queries
    NSURLQueryItem *key = [NSURLQueryItem queryItemWithName:@"appKey" value: appKey];
    NSURLQueryItem *lat = [NSURLQueryItem queryItemWithName:@"lat" value: aLat];
    NSURLQueryItem *lon = [NSURLQueryItem queryItemWithName:@"lat" value: aLong];
    componets.queryItems = @[lat, lon, key];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:componets.URL];
    
    //NSURLSession
    [[NSURLSession.sharedSession dataTaskWithRequest: request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        
        if(error){
            completion(nil,error);
            return;
        }
        
        if(!data){
            completion(nil,error);
            return;
        }
        
        //TODO: JSON Parsing
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if(jsonError){
            completion(nil,jsonError);
            return;
        }
        
        NSLog(@"JSON: %@", json);
        
        FGTOpenWeatherModel *weather =[[FGTOpenWeatherModel alloc] initWithDictionary:json];
        
        if(weather){
            completion(weather, nil);
            return;
        }else if(json) {
            completion(nil,error);
            return;
        }
        
        
        
    }]resume];
}
@end
