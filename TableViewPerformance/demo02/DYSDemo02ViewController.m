//
//  DYSDemo02ViewController.m
//  TableViewPerformance
//
//  Created by 丁玉松 on 2018/11/9.
//  Copyright © 2018 丁玉松. All rights reserved.
//

#import "DYSDemo02ViewController.h"
#import "DYSDataSource.h"
#import "DYSDemo02TableViewCell.h"

@interface DYSDemo02ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) NSArray *dataSourceArray;

@end

@implementation DYSDemo02ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSourceArray = [DYSDataSource new].dataSource;
    
    //根据实验固定高度使用这样的设置，确实比代理节省cpu，在亲测在高速滑动的时候，cpu少消耗5%左右。
    self.tableView.rowHeight = 80;
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5000;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //cpu:根据速度来，速度越高占用率越大最高95%   内存：稳定在15m   fps：最高能掉40帧    卡顿，多次高速滑动后会卡顿    11个初始化，其他的都是复用
        DYSDemo02TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    /**
     优化点1：
     [cell assignWithData:data];
     在添加imageView之前移除之前的imageView，不会造成内存一直增加。imageView对象少了之后，gpu绘制也更快了，所以相对流畅。
     
     
     从 cpu，内存和fps 3个方面来看已经优于demo01（不清理旧对象） 和 demo03 (不复用)
     
     */
    
    
    
    if (nil == cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DYSDemo02TableViewCell" owner:nil options:nil] lastObject];
        NSLog(@"初始化行号：%ld",indexPath.row);
    }
    
    NSDictionary *data = [self.dataSourceArray objectAtIndex:0];
    [cell assignWithData:data];
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 80;
//}

@end
