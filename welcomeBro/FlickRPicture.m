//
//  FlickRPicture.m
//  FlickRApp
//
//  Created by Joey BRONNER on 30/04/2014.
//  Copyright (c) 2014 Joey BRONNER. All rights reserved.
//

#import "FlickRPicture.h"

#define kFlickRAPIKey @"e33f200ec64aec1ed240ba8421e94a31"

@implementation FlickRPicture

- (NSURL *)url{
    
    NSString * urlString = [NSString stringWithFormat:@"http://farm%i.staticflickr.com/%@/%@_%@.jpg", self.farm.intValue,self.server, self.pictureID, self.secret];
    return [NSURL URLWithString:urlString];
}

+(NSArray *) picturesAroundLocation:(FlickRLocation)location
{
        NSString * urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&lat=%f&lon=%f&radius=%i&format=json&nojsoncallback=1", kFlickRAPIKey,location.latitude, location.longitude, location.radius];
    
    NSURL * url = [NSURL URLWithString:urlString];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    NSDictionary * jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSDictionary * photos = jsonData[@"photos"];
    NSArray * photo = photos[@"photo"];
    
    NSMutableArray * pictures = [NSMutableArray arrayWithCapacity:[photo count ]];
    
    for (NSDictionary * currentPicture in photo) {
        FlickRPicture * picture = [[FlickRPicture alloc] init];
        picture.pictureID = currentPicture[@"id"];
        picture.server = currentPicture[@"server"];
        picture.secret = currentPicture[@"secret"];
        picture.farm = currentPicture[@"farm"];
        picture.title = currentPicture[@"title"];
        
        [pictures addObject:picture];
        
    }
    
    return [NSArray arrayWithArray:pictures];
    
}


@end
