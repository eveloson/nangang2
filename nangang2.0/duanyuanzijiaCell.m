//
//  duanyuanzijiaCell.m
//  nangang2.0
//
//  Created by 周家新 on 17/8/14.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "duanyuanzijiaCell.h"

@implementation duanyuanzijiaCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.label.frame = CGRectMake(10, 10, ScreenWidth - 20, 30);
    self.label1.frame = CGRectMake(10, 40, ScreenWidth - 20, 20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
