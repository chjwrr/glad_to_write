//
//  YJSettingViewController.m
//  yueJi
//
//  Created by apple on 16/11/16.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "YJSettingViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "YJPasswordView.h"

@interface YJSettingViewController ()<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>


@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UISwitch *touchIDSwitch;
@property (nonatomic,strong)UISwitch *psdSwitch;

@end

@implementation YJSettingViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNavViewTitle:@"设置" leftTitle:@"取消" action:@selector(dismissViewController)];
}

- (void)dismissViewController {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
    }];
    
}

- (void)initDataSource {
  
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

- (UISwitch *)touchIDSwitch {
    if (!_touchIDSwitch) {
        _touchIDSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-60, 7, 40, 30)];
        _touchIDSwitch.onTintColor=kColorHexString(kuserThemeFontColor);
        [_touchIDSwitch addTarget:self action:@selector(touchIDSwitchValueChange:) forControlEvents:UIControlEventValueChanged];
    }
    if ([kFormatterSring(kgetDefaultValueForKey(kuserTouchID)) isEqualToString:@"1"]) {
        _touchIDSwitch.on=YES;
    }else{
        _touchIDSwitch.on=NO;

    }

    
    return _touchIDSwitch;
}


- (UISwitch *)psdSwitch {
    if (!_psdSwitch) {
        _psdSwitch=[[UISwitch alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-60, 7, 40, 30)];
        _psdSwitch.onTintColor=kColorHexString(kuserThemeFontColor);
        [_psdSwitch addTarget:self action:@selector(passwordSwitchValueChange:) forControlEvents:UIControlEventValueChanged];
    }
    if ([kFormatterSring(kgetDefaultValueForKey(kuserOpenPassword)) isEqualToString:@"1"]) {
        _psdSwitch.on=YES;
    }else{
        _psdSwitch.on=NO;
        
    }
    
    
    return _psdSwitch;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0 || indexPath.row == 3) {
        return 20;
    }
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *Identifier=@"UITableViewCell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:Identifier];
    }
    
    cell.backgroundColor=[UIColor whiteColor];
    cell.contentView.backgroundColor=[UIColor whiteColor];
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    cell.textLabel.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 15);
    cell.textLabel.textColor=kColorHexString(kuserThemeFontColor);
    
    if (indexPath.row == 0) {
        
        cell.textLabel.text=@"密码保护";
        cell.textLabel.font=kSYS_FONT(12);
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }else if (indexPath.row == 1) {
        cell.textLabel.text=@"Touch ID";
        
        [cell addSubview:self.touchIDSwitch];
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;

    }else if (indexPath.row == 2) {
        cell.textLabel.text=@"数字密码";
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [cell addSubview:self.psdSwitch];

    }else if (indexPath.row == 3) {
        
        cell.backgroundColor=[UIColor clearColor];
        cell.contentView.backgroundColor=[UIColor clearColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.textLabel.text=@"";
        
    }else if (indexPath.row == 4) {
        cell.textLabel.text=@"意见反馈";
    }else
        cell.textLabel.text=@"悦记好评";
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 1:{
            //Touch ID
        }
            break;
        case 2:{
            //数字密码
        }
            break;
        case 4:{
            //意见反馈
            [self sendEmail];
        }
            break;
        case 5:{
            //悦记好评
            NSString *str = [NSString stringWithFormat: @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8", @"1174735714"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
            break;

        default:
            break;
    }
}

/**
 *  Touch ID
 *
 *  @param psdswitch
 */
- (void)touchIDSwitchValueChange:(UISwitch *)psdswitch {
    if (kAPP_System_Version >= 8.0) {
        
        if (psdswitch.on) {
            ksetDefaultValueForKey(@"1", kuserTouchID);
        }else
            ksetDefaultValueForKey(@"0", kuserTouchID);

    }else{
        [[CHJProgressHUB shareInstance] showMessage:@"iOS 7及其以下的系统暂不支持Touch ID，请升级为更高系统以便使用"];
        psdswitch.on=NO;
    }
}

/**
 *  数字密码
 *
 *  @param psdswitch
 */
- (void)passwordSwitchValueChange:(UISwitch *)psdswitch {
    
    if (psdswitch.on) {
        
        [[YJPasswordView shareInstance] showIsWritePsd:YES];

    }else{
        //关闭数字密码
        ksetDefaultValueForKey(@"0", kuserOpenPassword);
        ksetDefaultValueForKey(@"", kuserPassword);
    }
}

/**
 *  发送邮件
 */
- (void)sendEmail {
    Class mainlClass=NSClassFromString(@"MFMailComposeViewController");
    if (!mainlClass) {
        [[CHJProgressHUB shareInstance] showMessage:@"当前系统版本不支持应用内发送邮件功能"];
        return;
    }
    
    if (![mainlClass canSendMail]) {
        [[CHJProgressHUB shareInstance] showMessage:@"你还没有设置邮件账户"];

        return;
    }
    
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate=self;
    
    //设置主题
    [mailPicker setSubject:@"悦记 意见反馈"];
    
    //添加收件人
    NSArray *toRecipients=[NSArray arrayWithObject:@"chjwrr@163.com"];
    [mailPicker setToRecipients:toRecipients];

    
    NSString *emailBody=@"<font color='red'> 悦记<br />阳光存在<br />只因你一直都在</font>";
    
    
    [mailPicker setMessageBody:[NSString stringWithFormat:@"%@\n",emailBody] isHTML:YES];
    
    [self presentViewController:mailPicker animated:YES completion:^{
        
    }];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    switch (result) {
            
        case MFMailComposeResultSent:{
            [[CHJProgressHUB shareInstance] showMessage:@"邮件已发送"];
        }
            break;
        case MFMailComposeResultCancelled:{
            [[CHJProgressHUB shareInstance] showMessage:@"邮件已取消"];
        }
            break;
        case MFMailComposeResultFailed:{
            [[CHJProgressHUB shareInstance] showMessage:@"邮件发送失败，请重试"];
        }
            break;
        case MFMailComposeResultSaved:{
            [[CHJProgressHUB shareInstance] showMessage:@"邮件保存成功"];

        }
            break;
            
        default:
            break;
    }
    
}

@end
