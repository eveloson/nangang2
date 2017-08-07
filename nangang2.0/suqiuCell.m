//
//  suqiuCell.m
//  nangang2.0
//
//  Created by 周家新 on 17/8/1.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "suqiuCell.h"

@implementation suqiuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.frame = CGRectMake(10, 5, ScreenWidth - 20 - 150, 30);
    self.labelstate.frame = CGRectMake(self.nameLabel.frame.origin.x + self.nameLabel.frame.size.width + 5, 5, 70, 30);
    self.btn2.frame = CGRectMake(self.labelstate.frame.origin.x + self.labelstate.frame.size.width + 5, 5, 70, 30);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
