//
//  UIImage+TSImage.m
//  Game news
//
//  Created by Mac on 13.06.16.
//  Copyright © 2016 Tsvigun Alexandr. All rights reserved.
//

#import "UIImage+TSImage.h"

@implementation UIImage (TSImage)

+ (UIImage *)transformationImage:(NSURL *)url
{
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *cover = [UIImage imageWithData:data];
    return cover;
}

@end
