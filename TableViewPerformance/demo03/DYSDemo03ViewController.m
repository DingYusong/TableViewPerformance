//
//  DYSDemo03ViewController.m
//  TableViewPerformance
//
//  Created by 丁玉松 on 2018/11/9.
//  Copyright © 2018 丁玉松. All rights reserved.
//

#import "DYSDemo03ViewController.h"
#import "DYSDataSource.h"
#import "DYSDemo01TableViewCell.h"

@interface DYSDemo03ViewController ()
@property (nonatomic, copy) NSArray *dataSourceArray;

@end

@implementation DYSDemo03ViewController

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
    
    //cpu:90%-99%  内存：稳定在19M左右  fps：最高能掉56帧，不稳定  ,卡，但是单次滑动比上面稍微流畅，能感觉出来，从fps上也能看出。   5000个初始化，初始化完成就释放掉了。每次都初始化。
    DYSDemo01TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
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
