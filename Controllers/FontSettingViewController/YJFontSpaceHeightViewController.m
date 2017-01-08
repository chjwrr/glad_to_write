//
//  YJFontSpaceHeightViewController.m
//  yueJi
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "YJFontSpaceHeightViewController.h"

@interface YJFontSpaceHeightViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIColor *textColor;

@end

@implementation YJFontSpaceHeightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initDataSource {
    
    self.textColor=kColorHexString(kuserThemeFontColor);
    [self initNavViewTitle:@"行间距" leftTitle:@"返回" action:@selector(dismissViewController)];
}

- (void)dismissViewController {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)initSubViews {
    
    [self.view addSubview:self.tableView];
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH, kSCREEN_HEIGHT-64)];
        [self.view addSubview:_tableView];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[UIView new];
        _tableView.backgroundColor=[UIColor clearColor];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *Identifier=@"UITableViewCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    }
    
    cell.textLabel.text=[NSString stringWithFormat:@"%d",(int)indexPath.row+5];
    
    cell.textLabel.font=kSYS_FONT(15);
    
    cell.textLabel.textColor=self.textColor;
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSString *fontSize=[NSString stringWithFormat:@"%d",(int)indexPath.row+5];
    
    ksetDefaultValueForKey(fontSize, kuserFontSpaceHeight);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
