//
//  SLFTableViewCell.m
//  Selfy
//
//  Created by Austen Johnson on 4/21/14.
//  Copyright (c) 2014 Austen Johnson. All rights reserved.
//

#import "SLFTableViewCell.h"

@implementation SLFTableViewCell
{
    UIImageView * avatar;
    UIImageView * selfImage;
    UILabel * userID;
    UILabel * caption;
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        avatar = [[UIImageView alloc] initWithFrame:CGRectMake(20, 320, 40, 40)];
        avatar.backgroundColor = [UIColor clearColor];
        avatar.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:avatar];
        
        selfImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 280, 280)];
        selfImage.backgroundColor = [UIColor clearColor];
        selfImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:selfImage];
        
//        userID = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 200, 30)];
//        userID.backgroundColor = [UIColor clearColor];
//        userID.textColor = [UIColor blackColor];
//        userID.font = [UIFont systemFontOfSize:30];
//        [self.contentView addSubview:userID];
        
        caption = [[UILabel alloc] initWithFrame:CGRectMake(80, 320, 220, 40)];
        caption.backgroundColor = [UIColor clearColor];
        caption.textColor = [UIColor darkGrayColor];
        caption.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:caption];
    }
    return self;
}

- (void)setSelfyInfo:(NSDictionary *)selfyInfo
{
    // Trying to set the visual avatar image on our screen (little one next to caption)
    NSURL* avatarURL = [NSURL URLWithString:selfyInfo[@"avatar"]];
    NSData* avatarData = [NSData dataWithContentsOfURL:avatarURL];
    avatar.image = [UIImage imageWithData:avatarData];
    //self.selfyInfo[@"avatar"] = [UIImage imageWithData:imageData];
    
    // Trying to set the visual PHOTO image on our screen (big one)
    NSURL* imageURL = [NSURL URLWithString:selfyInfo[@"selfImage"]];
    NSData* imageData = [NSData dataWithContentsOfURL:imageURL];
    selfImage.image = [UIImage imageWithData:imageData];
    
    caption.text = selfyInfo[@"caption"];
    userID.text = selfyInfo[@"userID"];
    
    
    _selfyInfo = selfyInfo;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
