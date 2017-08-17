//
//  CLizhongCell.m
//  nangang2.0
//
//  Created by 周家新 on 17/8/15.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "CLizhongCell.h"

@implementation CLizhongCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameL.frame = CGRectMake(10, 10, ScreenWidth - 30 - 80, 25);
    self.nameL1.frame = CGRectMake(10, self.nameL.frame.origin.y + self.nameL.frame.size.height + 10, ScreenWidth - 20, 25);
    self.namel2.frame = CGRectMake(self.nameL.frame.origin.x + self.nameL.frame.size.width + 10, 10, 80, 30);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
