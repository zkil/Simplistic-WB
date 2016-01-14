//
//  News.m
//  Simplistic WB
//
//  Created by Ibokan1 on 12/1/15.
//  Copyright (c) 2015 Ibokan1. All rights reserved.
//

#import "News.h"

@implementation News

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
     
    
    return [[[NSBundle mainBundle]loadNibNamed:@"News" owner:nil options:nil]objectAtIndex:0];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
