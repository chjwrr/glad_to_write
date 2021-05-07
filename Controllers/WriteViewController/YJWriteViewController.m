//
//  YJWriteViewController.m
//  yueJi
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "YJWriteViewController.h"
#import "YJChangeBgImageColorView.h"
#import "YJActionSheet.h"

#define kdownViewHeight        40

@interface YJWriteViewController ()<UITextViewDelegate,YJActionSheetDelegate>{
    UIButton *btn_keyboard;
    BOOL isShowKeyboard;
    
    NSArray *colors;
    NSArray *images;

}
@property (nonatomic,strong)YJThemeLabel *lab_time;
@property (nonatomic,strong)YJThemeLabel *lab_address;
@property (nonatomic,strong)YJThemeImageView *line;
@property (nonatomic,strong)UITextView *textView;
@property (nonatomic,strong)UIImageView *bgimageView;

@property (nonatomic,assign)CGFloat keyBoardHeight;
@property (nonatomic,strong)UIView *downView;


@property (nonatomic,strong)YJActionSheet *sheetRight;
@property (nonatomic,strong)YJActionSheet *sheetLeft;

@property (nonatomic,assign)BOOL isChange;
@end

@implementation YJWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initDataSource {
    images=@[@"small_YJBgimage7.jpg",
             @"small_YJBgimage8",
             @"small_YJBgimage9.jpg",
             @"small_YJBgimage10.jpg",
             @"small_YJBgimage11.jpg",
             @"small_YJBgimage12",
             @"small_YJBgimage13",
             @"small_YJBgimage14",
             @"small_YJBgimage15",
             @"small_YJBgimage16",
             @"small_YJBgimage17.jpg",
             @"small_YJBgimage18.jpg"];
    
    colors=@[@"small_YJBgimage1",
             @"small_YJBgimage2",
             @"small_YJBgimage3",
             @"small_YJBgimage4",
             @"small_YJBgimage5",
             @"small_YJBgimage6"];
    
    _isChange=NO;
    
}
- (void)initSubViews {
    [self.view addSubview:self.bgimageView];

    [self.view addSubview:self.lab_time];

    [self.view addSubview:self.lab_address];

    [self.view addSubview:self.line];

    [self.view addSubview:self.textView];

    [self.view addSubview:self.downView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    isShowKeyboard=YES;
    
    [self changeNowTime];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeNowTime) userInfo:nil repeats:YES];
    
    
    if (_isCreat) {
        [self.textView becomeFirstResponder];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.textView.text];
        
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:kuserFontSpace];//行间距
        [attributedString addAttribute:NSKernAttributeName value:@kuserFontWidthSpace range:NSMakeRange(0, self.textView.text.length)];//字间距
        [attributedString addAttribute:NSFontAttributeName value:kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), kuserFontSize) range:NSMakeRange(0, self.textView.text.length)];//字体大小
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self.textView.text length])];
        
        self.textView.attributedText=attributedString;

    }else{
        NSDictionary *diction=[[FileManager shareIntance] getNoteWithFilePath:_noteFilePath];
        self.textView.text=[diction objectForKey:@"content"];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.textView.text];
        
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:kuserFontSpace];//行间距
        [attributedString addAttribute:NSKernAttributeName value:@kuserFontWidthSpace range:NSMakeRange(0, self.textView.text.length)];//字间距
        [attributedString addAttribute:NSFontAttributeName value:kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), kuserFontSize) range:NSMakeRange(0, self.textView.text.length)];//字体大小
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self.textView.text length])];
        
        self.textView.attributedText=attributedString;
        
        self.lab_address.text=[diction objectForKey:@"address"];
    }
    
}


- (YJThemeLabel *)lab_time {
    if (!_lab_time) {
        _lab_time=[[YJThemeLabel alloc]initWithFrame:CGRectMake(20, kSTATUSBAR_HEIGHT, kSCREEN_WIDTH-40, 20)];
        _lab_time.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 20);
        _lab_time.text=@"";
    }
    return _lab_time;
}

- (YJThemeLabel *)lab_address {
    if (!_lab_address) {
        _lab_address=[[YJThemeLabel alloc]initWithFrame:CGRectMake(20, self.lab_time.y+self.lab_time.height, kSCREEN_WIDTH-40, 20)];
        _lab_address.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 14);
        _lab_address.textAlignment=NSTextAlignmentRight;
        _lab_address.text=@"";
    }
    return _lab_address;
}

- (YJThemeImageView *)line {
    if (!_line) {
        _line=[[YJThemeImageView alloc]initWithFrame:CGRectMake(10, self.lab_address.y+self.lab_address.height+5, kSCREEN_WIDTH -20, 1)];
        _line.backgroundColor=kColorHexString(kuserThemeFontColor);
    }
    return _line;
}

- (UIImageView *)bgimageView {
    if (!_bgimageView) {
        _bgimageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT)];
        _bgimageView.contentMode=UIViewContentModeScaleAspectFill;
        _bgimageView.layer.masksToBounds=YES;
        
        if (![kFormatterSring(kgetDefaultValueForKey(kuserNoteBgImage)) isEmpty]) {
            _bgimageView.image=kImageName(kFormatterSring(kgetDefaultValueForKey(kuserNoteBgImage)));
        }
        
    }
    return _bgimageView;
}


- (UITextView *)textView {
    if (!_textView) {
        CGRect frame = CGRectMake(10, self.line.y+self.line.height+5, kSCREEN_WIDTH-20, kSCREEN_HEIGHT-(self.line.y+self.line.height+5)-10-kdownViewHeight - kTABBAR_BOTTOM_HEIGHT);
        _textView=[[UITextView alloc]initWithFrame:frame];
        _textView.backgroundColor=[UIColor clearColor];
        _textView.delegate=self;
        _textView.text=@"";
        _textView.font=kSYS_FONT(17);
        _textView.textColor = [UIColor blackColor];
    }
    return _textView;
}

- (UIView *)downView {
    if (!_downView) {
        _downView=[[UIView alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT-kdownViewHeight-kTABBAR_BOTTOM_HEIGHT, kSCREEN_WIDTH, kdownViewHeight)];
        
        UIImageView *imagev=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kdownViewHeight)];
        [_downView addSubview:imagev];
        imagev.alpha=0.3;
        imagev.backgroundColor=kColorHexString(kuserThemeBgColor);
        
        UIButton *btn_location=[[UIButton alloc]initWithFrame:CGRectMake(5, 0, kdownViewHeight, kdownViewHeight)];
        [_downView addSubview:btn_location];
        [btn_location setImage:kImageName(@"YJWriteLocation") forState:UIControlStateNormal];
        [btn_location addTarget:self action:@selector(loactionAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btn_bgcolor=[[UIButton alloc]initWithFrame:CGRectMake(btn_location.x+btn_location.width+5, 0, kdownViewHeight, kdownViewHeight)];
        [_downView addSubview:btn_bgcolor];
        [btn_bgcolor setImage:kImageName(@"YJWritebgcolor") forState:UIControlStateNormal];
        [btn_bgcolor addTarget:self action:@selector(bgcolorAction) forControlEvents:UIControlEventTouchUpInside];

        UIButton *btn_bgimage=[[UIButton alloc]initWithFrame:CGRectMake(btn_bgcolor.x+btn_bgcolor.width+5, 0, kdownViewHeight, kdownViewHeight)];
        [_downView addSubview:btn_bgimage];
        [btn_bgimage setImage:kImageName(@"YJWritebgimage") forState:UIControlStateNormal];
        [btn_bgimage addTarget:self action:@selector(bgimageAction) forControlEvents:UIControlEventTouchUpInside];

        btn_keyboard=[[UIButton alloc]initWithFrame:CGRectMake((kSCREEN_WIDTH-kdownViewHeight)/2, 0, kdownViewHeight, kdownViewHeight)];
        [_downView addSubview:btn_keyboard];
        [btn_keyboard setImage:kImageName(@"YJWritekeyboarddown") forState:UIControlStateNormal];
        [btn_keyboard addTarget:self action:@selector(keyboardAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btn_select=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-kdownViewHeight-5, 0, kdownViewHeight, kdownViewHeight)];
        [_downView addSubview:btn_select];
        [btn_select setImage:kImageName(@"YJWriteSelect") forState:UIControlStateNormal];
        [btn_select addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];

        UIButton *btn_close=[[UIButton alloc]initWithFrame:CGRectMake(kSCREEN_WIDTH-kdownViewHeight-5-5-kdownViewHeight, 0, kdownViewHeight, kdownViewHeight)];
        [_downView addSubview:btn_close];
        [btn_close setImage:kImageName(@"YJWriteColse") forState:UIControlStateNormal];
        [btn_close addTarget:self action:@selector(colseAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _downView;
}


#pragma mark -- UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    
//    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle1 setLineSpacing:kuserFontSpace];//行间距
//    
//    
//    NSDictionary *attributes=@{NSKernAttributeName:@kuserFontWidthSpace,
//                               NSFontAttributeName:kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), kuserFontSize),
//                               NSParagraphStyleAttributeName:paragraphStyle1};
//    
//    //[attributedString addAttribute:NSKernAttributeName value:@kuserFontWidthSpace range:NSMakeRange(0, self.textView.text.length)];//字间距
//    //[attributedString addAttribute:NSFontAttributeName value:kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), kuserFontSize) range:NSMakeRange(0, self.textView.text.length)];//字体大小
//    //[attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self.textView.text length])];
//    
//    
//    self.textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
//    
    _isChange=YES;
}

/**
 *  监听键盘刚出来
 *
 *  @param tification
 */
- (void)keyBoardWillShow:(NSNotification *)tification {
    
   self.keyBoardHeight = [[[tification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    [self reloadTextViewFrame];
}

/**
 *  每分钟改变时间
 */
- (void)changeNowTime {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm EEEE"];
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    dateFormatter.locale = usLocale;
    
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    
    self.lab_time.text=[self formaatterWeekDay:currentDateString];
}

/**
 *  英语的星期改为中文的星期
 *
 *  @param string 英语的星期
 *
 *  @return 中文的星期
 */
- (NSString *)formaatterWeekDay:(NSString *)string {
    string=[string stringByReplacingOccurrencesOfString:@"Monday" withString:@"周一"];
    string=[string stringByReplacingOccurrencesOfString:@"Tuesday" withString:@"周二"];
    string=[string stringByReplacingOccurrencesOfString:@"Wednesday" withString:@"周三"];
    string=[string stringByReplacingOccurrencesOfString:@"Thursday" withString:@"周四"];
    string=[string stringByReplacingOccurrencesOfString:@"Friday" withString:@"周五"];
    string=[string stringByReplacingOccurrencesOfString:@"Saturday" withString:@"周六"];
    string=[string stringByReplacingOccurrencesOfString:@"Sunday" withString:@"周日"];

    return string;
}

/**
 *  监听键盘刚消失
 *
 *  @param tification 通知
 */
- (void)keyBoardWillHide:(NSNotification *)tification {
    [UIView animateWithDuration:0.15 animations:^{
        
        self.textView.frame = CGRectMake(10, self.line.y+self.line.height+5, kSCREEN_WIDTH-20, kSCREEN_HEIGHT-(self.line.y+self.line.height+5)-10-kdownViewHeight - kTABBAR_BOTTOM_HEIGHT);
        
        self.downView.frame=CGRectMake(0, kSCREEN_HEIGHT-kdownViewHeight - kTABBAR_BOTTOM_HEIGHT, kSCREEN_WIDTH, kdownViewHeight);
        [btn_keyboard setImage:kImageName(@"YJWritekeyboardup") forState:UIControlStateNormal];
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            isShowKeyboard=NO;
        }
        
    }];

}


/**
 *  通过键盘的高度调整TextView的位置和高度
 */
- (void)reloadTextViewFrame {
    [UIView animateWithDuration:0.15 animations:^{
        
        self.textView.frame=CGRectMake(10, self.line.y+self.line.height+5, kSCREEN_WIDTH-20, kSCREEN_HEIGHT-(self.line.y+self.line.height+5)-10-self.keyBoardHeight-kdownViewHeight);
        
        self.downView.frame=CGRectMake(0, kSCREEN_HEIGHT-self.keyBoardHeight-kdownViewHeight, kSCREEN_WIDTH, kdownViewHeight);
        [btn_keyboard setImage:kImageName(@"YJWritekeyboarddown") forState:UIControlStateNormal];

    } completion:^(BOOL finished) {
        
        if (finished) {
            isShowKeyboard=YES;
        }
        
    }];
}

/**
 *  定位
 */
- (void)loactionAction {
    //定位设置
    [[LocationManager shareInStance] startUserLocation:^(NSString *address) {
        NSLog(@"address    %@",address);
        
        self.lab_address.text=address;
        _isChange=YES;

    } fail:^(NSString *error) {
        NSLog(@"error    %@",error);
        
        self.lab_address.text=error;

    }];
}

/**
 *  切换背景色
 */
- (void)bgcolorAction {
    [self.textView resignFirstResponder];
    [[YJChangeBgImageColorView shareInstance] show:colors success:^(NSString *name) {
        self.bgimageView.image=kImageName(name);
    }];
    
}

/**
 *  切换背景图片
 */
- (void)bgimageAction {
    [self.textView resignFirstResponder];

    [[YJChangeBgImageColorView shareInstance] show:images success:^(NSString *name) {
        self.bgimageView.image=kImageName(name);
    }];

}

/**
 *  取消、显示键盘
 */
- (void)keyboardAction {
    if (isShowKeyboard) {
        [btn_keyboard setImage:kImageName(@"YJWritekeyboardup") forState:UIControlStateNormal];
        [self.textView resignFirstResponder];
    }else{
        [btn_keyboard setImage:kImageName(@"YJWritekeyboarddown") forState:UIControlStateNormal];
        [self.textView becomeFirstResponder];
    }

    isShowKeyboard=!isShowKeyboard;
}

/**
 *  完成
 */
- (void)selectAction {
    [self.textView resignFirstResponder];
    
    [[YJChangeBgImageColorView shareInstance] hiddent];

    [_sheetRight removeFromSuperview];
    _sheetRight = nil;
    
    _sheetRight=[[YJActionSheet alloc]initWithTitle:@"你有新的内容要提交" cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定提交" otherButtonTitles:@[@"放弃提交"]];
    _sheetRight.delegate=self;
    _sheetRight.tag=100;
    [_sheetRight showInView:self.view];
   
}

/**
 *  取消
 */
- (void)colseAction {
    
    [self.textView resignFirstResponder];
    
    [[YJChangeBgImageColorView shareInstance] hiddent];

    if ([self.textView.text isEmpty]) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
    }else{
        if (_isDismiss && !_isChange) {
            //从主页进来，可以直接返回
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else{
            [_sheetLeft removeFromSuperview];
            _sheetLeft = nil;
            
            _sheetLeft=[[YJActionSheet alloc]initWithTitle:@"你有新的内容未提交" cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存修改" otherButtonTitles:@[@"放弃修改"]];
            _sheetLeft.delegate=self;
            _sheetLeft.tag=101;
            [_sheetLeft showInView:self.view];

        }
    }
}

#pragma mark --YJActionSheet Delegate

- (void)YJActionSheet:(id)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    YJActionSheet *selectSheet=(YJActionSheet *)actionSheet;
    if (selectSheet.tag == 100) {
        //完成
        switch (buttonIndex) {
            case 0:{
                //确定提交
                NSLog(@"确定提交");
                [self saveNote];
                
            }
                break;
            case 1:{
                //放弃提交
                NSLog(@"放弃提交");
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
                break;
            case 2:{
                //取消
                NSLog(@"取消");
            }
                break;
            default:
                break;
        }
        
    }else{
        //取消
        switch (buttonIndex) {
            case 0:{
                //保存修改
                NSLog(@"保存修改");
                [self saveNote];

            }
                break;
            case 1:{
                //放弃修改
                NSLog(@"放弃修改");
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
                break;
            case 2:{
                //取消
                NSLog(@"取消");
            }
                break;
            default:
                break;
        }
        

    }
    
}


//保存日记
- (void)saveNote {
    //日记名以 时间戳 命名
    
    /*
     保存内容包含有
     
     时间       2016.09
     天         09
     星期       周一
     内容       日记内容
     地点       当前位置
     
     */

    if ([self.textView.text isEmpty]) {
        [[CHJProgressHUB shareInstance] showMessage:@"暂无日记可以保存，赶紧写日记吧"];
        return;
    }
    if (_isCreat) {
        NSDictionary *diction;
        
        //新建的日记，全部保存
        
        //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss EEEE"];
        
        if (![self.lab_time.text isEmpty]) {
            NSArray *items=[self.lab_time.text componentsSeparatedByString:@" "];
            NSString *str_date=[items objectAtIndex:0];
            
            NSArray *itemDate=[str_date componentsSeparatedByString:@"-"];
            
            //年
            NSString *year=[itemDate objectAtIndex:0];
            //月
            NSString *mouth=[itemDate objectAtIndex:1];
            //日
            NSString *day=[itemDate objectAtIndex:2];
            //星期
            NSString *weak=[self formaatterWeekDay:[items lastObject]];
            
            
            int timeInterval=[[NSDate date]timeIntervalSince1970];
            
            
            //日记内容
            diction=@{@"date":[NSString stringWithFormat:@"%@.%@",year,mouth],
                      @"day":day,
                      @"week":weak,
                      @"content":self.textView.text,
                      @"address":[self.lab_address.text isEmpty]?@"":self.lab_address.text};
            
            //日记名字
            NSString *noteName=[NSString stringWithFormat:@"%d",timeInterval];
            
            [[FileManager shareIntance] creatNotePlist:noteName noteData:diction];
            
        }else{
            
            diction=@{@"date":@"暂无",
                      @"day":@"暂无",
                      @"week":@"暂无",
                      @"content":self.textView.text,
                      @"address":[self.lab_address.text isEmpty]?@"":self.lab_address.text};
        }
        
        
    }else{
        //以前的日记进来，只保存内容
        
        //日记内容
        NSDictionary *diction=[[FileManager shareIntance] getNoteWithFilePath:_noteFilePath];
        [diction setValue:self.textView.text forKey:@"content"];
        
        [diction setValue:[self.lab_address.text isEmpty]?@"":self.lab_address.text forKey:@"address"];

        NSArray *items=[_noteFilePath componentsSeparatedByString:@"/"];
        NSString *noteName=[items lastObject];
        //日记名字
        noteName=[noteName stringByReplacingOccurrencesOfString:@".plist" withString:@""];
        
        [[FileManager shareIntance] creatNotePlist:noteName noteData:diction];
        
    }
    
    
    [[CHJProgressHUB shareInstance] showMessage:@"日记已保存"];

    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
