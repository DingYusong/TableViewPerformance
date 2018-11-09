//
//  DYSDemo02TableViewCell.m
//  TableViewPerformance
//
//  Created by 丁玉松 on 2018/11/9.
//  Copyright © 2018 丁玉松. All rights reserved.
//

#import "DYSDemo02TableViewCell.h"

@interface DYSDemo02TableViewCell ()

@property (nonatomic ,copy) NSMutableArray *array;

@end

@implementation DYSDemo02TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    NSMutableArray *marray = [NSMutableArray new];
    
    for (int i = 0; i < Demo01StrCount; i++) {
        
        int count = arc4random()%100+1000;
        
        NSMutableString *str = [[NSMutableString alloc] initWithString:@"asdfasdfasdfasdfasdfasdfasdfasdfadsfadsfadsfad"];
        
        for (int i = 0; i<count; i++) {
            [str appendString:@"12"];
        }
        
        [marray addObject:str];
    }
    
    self.array = marray;
}

- (void)assignWithData:(id)data {
    NSDictionary *dict = (NSDictionary *)data;
    NSString *imageName = [data objectForKey:@"image"];
    NSString *content = [data objectForKey:@"content"];
    

    // 清理掉原有的imageView能大大减少内存使用
    
    for(UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i = 0; i<Demo01ImgCount; i++) {
        
        UIImageView *imageView = [UIImageView new];
        [imageView setImage:[UIImage imageNamed:imageName]];
        imageView.layer.cornerRadius = 4;
        imageView.layer.masksToBounds = YES;
        CGFloat width = [UIScreen mainScreen].bounds.size.width/Demo01ImgCount;
        imageView.frame = CGRectMake(i*width, 0, width, 50);
        [self.contentView addSubview:imageView];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
