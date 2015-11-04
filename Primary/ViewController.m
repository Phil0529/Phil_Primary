//
//  ViewController.m
//  Primary
//
//  Created by Phil Xhc on 15/10/22.
//  Copyright © 2015年 Xhc. All rights reserved.
//

#import "ViewController.h"
#import "UploadPicsVC.h"
#import "BadiduMobAdVC.h"

static NSString *TableViewCellReuseIdentifierVC = @"TableViewCellReuseIdentifierVC";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tbView;
}
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self philInitDataVC];
    [self philInitUIVC];

}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"Upload Pics",@"Baidu Advertisement"];
    }
    return _dataArray;
}

- (void)philInitDataVC{
}
- (void)philInitUIVC{
    
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, 0.f, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _tbView.delegate = self;
    _tbView.dataSource = self;
    [self.view addSubview:_tbView];
}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableViewCellReuseIdentifierVC];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellReuseIdentifierVC];
    }
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            UploadPicsVC *vc = [[UploadPicsVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            BadiduMobAdVC *vc = [[BadiduMobAdVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
