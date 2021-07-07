//
//  FGTNetworking.m
//  DailyWeather
//
//  Created by FGT MAC on 7/5/21.
//  Copyright © 2021 Lambda, Inc. All rights reserved.
//

#import "FGTNetworking.h"


static NSString *FGTOpenWeatherModelURL = @"https://api.openweathermap.org/data/2.5/weather";

@implementation FGTNetworking

-(void)fetchWeather:(NSString *)aLat long:(NSString *)aLong completion:(OpenWeatherCompletion)completion
{
    //api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
    
    //api.openweathermap.org/data/2.5/weather?lat=37.785834&lon=-122.406417&appid=98e928ba74109243f3daa2e979e3d421
    NSURLComponents *componets = [[NSURLComponents alloc] initWithString:FGTOpenWeatherModelURL];
    NSString *appid = @"98e928ba74109243f3daa2e979e3d421";
    
    //    Queries
    NSURLQueryItem *key = [NSURLQueryItem queryItemWithName:@"appid" value: appid];
    NSURLQueryItem *lat = [NSURLQueryItem queryItemWithName:@"lat" value: aLat];
    NSURLQueryItem *lon = [NSURLQueryItem queryItemWithName:@"lon" value: aLong];
    componets.queryItems = @[lat, lon, key];
    
    
    NSURL *url = componets.URL;
    NSLog(@"Requested data to: %@",url);
    
    //NSURLSession
    NSURLSessionDataTask *dataTask = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error){
            completion(nil,error);
            return;
        }
        
        //TODO: JSON Parsing
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if(!json){
            completion(nil,jsonError);
            return;
        }
        
        NSLog(@"JSON Error: %@", json);
        
        FGTOpenWeatherModel *weather =[[FGTOpenWeatherModel alloc] initWithDictionary:json];
        
        if(!weather) {
            completion(nil,error);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(weather, nil);
        });
        
        
        
    }];
    
    [dataTask resume];
}
@end
