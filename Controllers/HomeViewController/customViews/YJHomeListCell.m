//
//  YJHomeListCell.m
//  yueJi
//
//  Created by apple on 16/11/10.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "YJHomeListCell.h"
#import "YJNoteModel.h"

#define kcellHiehgt          110

#define klab_height          20

#define klabDay_left_space   10

#define klabDay_top_space    20

#define kline_left_space     70

#define kright_space         10


@interface YJHomeListCell ()

@property (nonatomic,strong)YJThemeLabel *lab_year;
@property (nonatomic,strong)YJThemeLabel *lab_day;
@property (nonatomic,strong)YJThemeLabel *lab_week;
@property (nonatomic,strong)YJThemeImageView *imageV_line;
@property (nonatomic,strong)YJThemeImageView *imageV_circle;
@property (nonatomic,strong)UIImageView *imageV_kuang;

@property (nonatomic,strong)YJThemeLabel *lab_content;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)YJThemeLabel *lab_address;

@end

@implementation YJHomeListCell



- (void)initSubViews {
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
    self.contentView.backgroundColor=[UIColor clearColor];
    
    
    [self addSubview:self.lab_day];
    [self addSubview:self.lab_week];
    [self addSubview:self.lab_year];
    [self addSubview:self.imageV_line];
    [self addSubview:self.imageV_circle];
    [self addSubview:self.imageV_kuang];
    [self addSubview:self.lab_content];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.lab_address];
}

- (YJThemeLabel *)lab_day {
    if (!_lab_day) {
        _lab_day=[[YJThemeLabel alloc]initWithFrame:CGRectMake(klabDay_left_space, klabDay_top_space, 25, klab_height)];
        _lab_day.font=kSYS_FONT(17);
    }
    return _lab_day;
}

- (YJThemeLabel *)lab_week {
    if (!_lab_week) {
        _lab_week=[[YJThemeLabel alloc]initWithFrame:CGRectMake(self.lab_day.x+self.lab_day.width-2, self.lab_day.y+5, 35, self.lab_day.height-5)];
        _lab_week.font=kSYS_FONT(10);

    }
    return _lab_week;
}
- (YJThemeLabel *)lab_year {
    if (!_lab_year) {
        _lab_year=[[YJThemeLabel alloc]initWithFrame:CGRectMake(self.lab_day.x+2, self.lab_day.y+self.lab_day.height-5, 50, self.lab_day.height)];
        _lab_year.font=kSYS_FONT(10);

    }
    return _lab_year;
}

- (YJThemeImageView *)imageV_line {
    if (!_imageV_line) {
        _imageV_line=[[YJThemeImageView alloc]initWithFrame:CGRectMake(kline_left_space, 0, 1, kcellHiehgt)];
    }
    return _imageV_line;
}

- (YJThemeImageView *)imageV_circle {
    if (!_imageV_circle) {
        _imageV_circle=[[YJThemeImageView alloc]initWithFrame:CGRectMake(kline_left_space-5+0.5, klab_height+10, 10, 10)];
        _imageV_circle.layer.cornerRadius=5;
        _imageV_circle.layer.masksToBounds=YES;
        
        
    }
    return _imageV_circle;
}

- (UIImageView *)imageV_kuang {
    if (!_imageV_kuang) {
        _imageV_kuang=[[UIImageView alloc]initWithFrame:CGRectMake(kline_left_space+klabDay_left_space, 10, kSCREEN_WIDTH-kline_left_space-klabDay_left_space-kright_space, kcellHiehgt-20)];
        
        UIImage *image=[UIImage imageNamed:@"YJHome_kuang"];
        
        image=[image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
        _imageV_kuang.image=image;
    
    
    }
    return _imageV_kuang;

}


- (YJThemeLabel *)lab_content {
    if (!_lab_content) {
        _lab_content=[[YJThemeLabel alloc]initWithFrame:CGRectMake(_imageV_kuang.x+20, _imageV_kuang.y+5, _imageV_kuang.width-25, _imageV_kuang.height-30)];
        _lab_content.numberOfLines=0;
        _lab_content.font=kSYS_FONT(15);

    }
    return _lab_content;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView=[[UIView alloc]initWithFrame:CGRectMake(_lab_content.x, _lab_content.y+_lab_content.height+5, _lab_content.width, 15)];
        
    }
    return _bottomView;
}

- (YJThemeLabel *)lab_address {
    if (!_lab_address) {
        _lab_address=[[YJThemeLabel alloc]initWithFrame:CGRectMake(0, 0, self.bottomView.width,15)];
        _lab_address.font=kSYS_FONT(10);
        
    }
    return _lab_address;
}

- (void)cellForData:(id)data {
    
    YJNoteModel *model=(YJNoteModel *)data;
    
    self.lab_day.text=model.day;
    self.lab_day.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 17);
    
    self.lab_week.text=model.week;
    self.lab_week.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 10);

    self.lab_year.text=model.date;
    self.lab_year.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 10);

    self.lab_address.text=model.address;
    self.lab_address.font=kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), 10);

    self.lab_content.text=model.content;
    
    self.lab_content.font=kSYS_FONT(kuserFontSize);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.lab_content.text];
    
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:kuserFontSpace];//行间距
    [attributedString addAttribute:NSKernAttributeName value:@kuserFontWidthSpace range:NSMakeRange(0, self.lab_content.text.length)];//字间距
    [attributedString addAttribute:NSFontAttributeName value:kSYS_FONTNAME(kFormatterSring(kgetDefaultValueForKey(kuserFontName)), kuserFontSize) range:NSMakeRange(0, self.lab_content.text.length)];//字体大小
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [self.lab_content.text length])];
    
    self.lab_content.attributedText=attributedString;
    
    
    //如果没有地址，这_lab_content 高度变高
    if ([self.lab_address.text isEmpty]) {
        self.lab_content.frame=CGRectMake(_imageV_kuang.x+20, _imageV_kuang.y+5, _imageV_kuang.width-25, _imageV_kuang.height-10);
    }
    
    
}

+ (CGFloat)cellHeight {
    return kcellHiehgt;
}


@end
