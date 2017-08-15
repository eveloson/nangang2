//
//  ganbujianduCell.m
//  nangang2.0
//
//  Created by 周家新 on 17/8/14.
//  Copyright © 2017年 Zhou. All rights reserved.
//

#import "ganbujianduCell.h"

@implementation ganbujianduCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageV.frame = CGRectMake(10, (self.frame.size.height - 80)/2.000,  80, 80);
    self.label.frame = CGRectMake(self.imageV.frame.origin.x + self.imageV.frame.size.width + 10, 10, ScreenWidth - self.imageV.frame.origin.x - self.imageV.frame.size.width - 10, 30);
    self.label1.frame = CGRectMake(self.imageV.frame.origin.x + self.imageV.frame.size.width + 10, self.label.frame.origin.y + self.label.frame.size.height, 43, 30);
    self.btn.frame = CGRectMake(self.label1.frame.origin.x + self.label1.frame.size.width, self.label.frame.origin.y + self.label.frame.size.height, ScreenWidth - self.label1.frame.origin.x - self.label1.frame.size.width - 10, 30);
    self.label2.frame = CGRectMake(self.label1.frame.origin.x + self.label1.frame.size.width, self.label.frame.origin.y + self.label.frame.size.height, ScreenWidth - self.label1.frame.origin.x - self.label1.frame.size.width - 10, 30);
    self.label3.frame = CGRectMake(self.imageV.frame.origin.x + self.imageV.frame.size.width + 10, self.label2.frame.origin.y + self.label2.frame.size.height, ScreenWidth - self.imageV.frame.origin.x - self.imageV.frame.size.width - 10, 30);
    self.label4.frame = CGRectMake(self.imageV.frame.origin.x + self.imageV.frame.size.width + 10, self.label3.frame.origin.y + self.label3.frame.size.height, ScreenWidth - self.imageV.frame.origin.x - self.imageV.frame.size.width - 10, 30);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
