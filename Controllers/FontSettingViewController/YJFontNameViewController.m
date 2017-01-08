//
//  YJFontNameViewController.m
//  yueJi
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 chj. All rights reserved.
//


#import "YJFontNameViewController.h"

@interface YJFontNameViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIColor *textColor;

@end

@implementation YJFontNameViewController

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
    [self initNavViewTitle:@"自定义字体" leftTitle:@"返回" action:@selector(dismissViewController)];
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
    
    return 5;
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
    
    cell.textLabel.text=@"悦记-简单记";
    
    switch (indexPath.row) {
            
        case 0:
            cell.textLabel.font=kSYS_FONTNAME(@"Weibei SC", 15);
            break;
        case 1:
            cell.textLabel.font=kSYS_FONTNAME(@"FZQiTi-S14S", 15);
            break;
        case 2:
            cell.textLabel.font=kSYS_FONTNAME(@"FZShouJinShu-S10S", 15);
            break;
        case 3:
            cell.textLabel.font=kSYS_FONTNAME(@"FZShuTi-S05S", 15);
            break;
        case 4:
            cell.textLabel.font=kSYS_FONTNAME(@"Xingkai SC", 15);
            break;
            
        default:
            break;
    }
  
    cell.textLabel.textColor=self.textColor;
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
            
        case 0:{
            ksetDefaultValueForKey(@"Weibei SC", kuserFontName);//魏碑简体
            ksetDefaultValueForKey(@"魏碑简体", kuserFontNameChina);
        }
            break;
        case 1:{
            ksetDefaultValueForKey(@"FZQiTi-S14S", kuserFontName);//方正启体
            ksetDefaultValueForKey(@"方正启体", kuserFontNameChina);
        }
            break;
        case 2:{
            ksetDefaultValueForKey(@"FZShouJinShu-S10S", kuserFontName);//方正瘦金书简体
            ksetDefaultValueForKey(@"方正瘦金书简体", kuserFontNameChina);
        }
            break;
        case 3:{
            ksetDefaultValueForKey(@"FZShuTi-S05S", kuserFontName);//方正舒体
            ksetDefaultValueForKey(@"方正舒体", kuserFontNameChina);
        }
            break;
        case 4:{
            ksetDefaultValueForKey(@"Xingkai SC", kuserFontName);//行楷简体
            ksetDefaultValueForKey(@"行楷简体", kuserFontNameChina);
        }
            break;
            
        default:
            break;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
