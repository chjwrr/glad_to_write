//
//  YJFontSettingViewController.m
//  yueJi
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "YJFontSettingViewController.h"
#import "YJFontListViewController.h"
#import "YJFontSpaceHeightViewController.h"
#import "YJFontSpaceWidthViewController.h"
#import "YJFontNameViewController.h"
@interface YJFontSettingViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSString *content;
    CGFloat contentHeight;
    NSMutableAttributedString * attributedString;
}

@property (nonatomic,strong)UIColor *textColor;

@property (nonatomic,strong)UITableView *tableView;

@end

@implementation YJFontSettingViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self reloadTableViewData];
    [self reloadNavView];
}
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavViewTitle:@"显示" leftTitle:@"取消" action:@selector(dismissViewController)];
}

- (void)dismissViewController {
   
    [self dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
    }];

}

- (void)initDataSource {
    content=@"在清闲午后，在落日黄昏，一杯清茶\n翻开手中书卷，看亲情如灯\n在悄无声息中照亮我们生命的每一个角落\n直至我们潸然泪下\n\n品人生似棋\n在无常生活中执一颗平常心\n看云卷云舒，花开花落\n\n在不经意中把这些美丽的方块字\n把平凡事中深含的情感\n如岁月般在我们的脑海中流过";
    
    [self reloadTableViewData];
}

- (void)reloadTableViewData {
    
    attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle1 setLineSpacing:kuserFontSpace];//行间距
    [attributedString addAttribute:NSFontAttributeName value:kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), kuserFontSize) range:NSMakeRange(0, content.length)];//字体大小
    [attributedString addAttribute:NSKernAttributeName value:@kuserFontWidthSpace range:NSMakeRange(0, content.length)];//字间距

    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [content length])];
    
    contentHeight = [attributedString boundingRectWithSize:CGSizeMake(kSCREEN_WIDTH-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size.height+40;

    self.textColor=kColorHexString(kuserThemeFontColor);
    
    [self.tableView reloadData];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return contentHeight;
    }
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *Identifier=@"UITableViewCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    }
    if (indexPath.section == 0) {
        
        cell.textLabel.numberOfLines=0;
        cell.textLabel.textColor=self.textColor;
        
        cell.textLabel.attributedText=attributedString;
    }else{
        //字体大小，行间距，自定义字体
        if (indexPath.row == 0) {
            cell.textLabel.text=@"字体大小";
            cell.detailTextLabel.text=kFormatterSring(kgetDefaultValueForKey(kuserFontSizeName));

        }else if (indexPath.row == 1){
            cell.textLabel.text=@"行间距";
            cell.detailTextLabel.text=kFormatterSring(kgetDefaultValueForKey(kuserFontSpaceHeight));

        }else if (indexPath.row == 2){
            cell.textLabel.text=@"字间距";
            cell.detailTextLabel.text=kFormatterSring(kgetDefaultValueForKey(kuserFontSpaceWidth));
        }else{
            cell.textLabel.text=@"自定义字体";
            cell.detailTextLabel.text=kFormatterSring(kgetDefaultValueForKey(kuserFontNameChina));
        }
        cell.textLabel.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 15);
        cell.textLabel.textColor=self.textColor;
        cell.detailTextLabel.textColor=self.textColor;
        cell.detailTextLabel.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 13);

        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:{
                //字体大小
                YJFontListViewController *listVC=[[YJFontListViewController alloc]init];
                [self.navigationController pushViewController:listVC animated:YES];
            }
                break;
            case 1:{
                //行间距
                YJFontSpaceHeightViewController *spaceVC=[[YJFontSpaceHeightViewController alloc]init];
                [self.navigationController pushViewController:spaceVC animated:YES];
            }
                break;
            case 2:{
                //字间距
                YJFontSpaceWidthViewController *spaceVC=[[YJFontSpaceWidthViewController alloc]init];
                [self.navigationController pushViewController:spaceVC animated:YES];
            }
                break;
            case 3:{
                //字体
                YJFontNameViewController *nameVC=[[YJFontNameViewController alloc]init];
                [self.navigationController pushViewController:nameVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
