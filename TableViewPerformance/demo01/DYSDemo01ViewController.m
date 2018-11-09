//
//  DYSDemo01ViewController.m
//  TableViewPerformance
//
//  Created by 丁玉松 on 2018/11/9.
//  Copyright © 2018 丁玉松. All rights reserved.
//

#import "DYSDemo01ViewController.h"
#import "DYSDataSource.h"
#import "DYSDemo01TableViewCell.h"

@interface DYSDemo01ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) NSArray *dataSourceArray;

@end

@implementation DYSDemo01ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSourceArray = [DYSDataSource new].dataSource;
}
#pragma mark -  tableViewDelegate


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5000;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    //cpu:70%-80%   内存：越来越大，最高能到900m以上   fps：最高能掉59帧，且50帧以上是常态    非常卡顿，单次滑动就非常卡    11个初始化，其他的都是复用
    DYSDemo01TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    //要在cell里面设置复用id。
    /**
     分析原因:
     1.内存暴增不减。
     最显眼的是内存的只增不减，这个是因为[cell assignWithData:data]; 每次都会向contentView上面新增imageView对象，造成对象一直累加，从而爆了内存。
     
     2.非常卡顿。
     因为要绘制的对象（imageView）非常多，CPU特别是GPU根本忙不过来。所以会造成掉帧的现象，自然就卡顿了。
     */
    
    
    
    
    //cpu:90%-99%  内存：稳定在19M左右  fps：最高能掉56帧，不稳定  ,卡，但是单次滑动比上面稍微流畅，能感觉出来，从fps上也能看出。   5000个初始化，初始化完成就释放掉了。每次都初始化。
//    DYSDemo01TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    /**
     分析原因：
     cpu使用率暴增，因为大量的初始化动作，初始化动作里面有复杂的操作，所以cpu使用率很高。很卡顿也是因为每次都要d绘制大量对象。
     */
    
    
    
    if (nil == cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"DYSDemo01TableViewCell" owner:nil options:nil] lastObject];
        NSLog(@"初始化行号：%ld",indexPath.row);
    }
    
    NSDictionary *data = [self.dataSourceArray objectAtIndex:0];
    [cell assignWithData:data];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


@end
