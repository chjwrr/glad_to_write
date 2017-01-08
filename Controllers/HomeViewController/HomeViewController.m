//
//  MWDViewController.m
//  ModelProduct
//
//  Created by apple on 16/4/27.
//  Copyright © 2016年 chj. All rights reserved.
//

#import "HomeViewController.h"
#import "YJHomeListCell.h"
#import "YJHomeDownView.h"
#import "YJThemeView.h"

#import "BaseNavigationController.h"
#import "YJFontSettingViewController.h"
#import "YJSettingViewController.h"
#import "YJWriteViewController.h"


#import "YJNoteModel.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,YJHomeDownViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)YJHomeDownView *downView;

@property (nonatomic,copy)NSMutableArray *dataSource;

@property (nonatomic,copy)NSMutableArray *filePaths;

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self.downView reloadDownView];
    
    [self reloadNoteData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initDataSource {
    _dataSource =[[NSMutableArray alloc]init];
    _filePaths =[[NSMutableArray alloc]init];

}

- (void)initSubViews {
    
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.downView];

}

//刷新日记列表
- (void)reloadNoteData {
    
    [_dataSource removeAllObjects];
    [_filePaths removeAllObjects];
    
    NSArray *files=[[FileManager shareIntance] getAllNoteItems];
    
    
    for (int i=[files count]-1; i>=0; i--) {
        NSDictionary *diction=[[FileManager shareIntance] getNoteWithFilePath:[files objectAtIndex:i]];
        
        YJNoteModel *model=[[YJNoteModel alloc]init];
        [model setValuesForKeysWithDictionary:diction];
        
        [_dataSource addObject:model];
        
        [_filePaths addObject:[files objectAtIndex:i]];
    }
    
    
    [self.tableView reloadData];

}

- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,kSCREEN_WIDTH,kSCREEN_HEIGHT-[YJHomeDownView viewHiddentwHeight])];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor=[UIColor clearColor];

    }
    return _tableView;
}

- (YJHomeDownView *)downView {
    if (!_downView) {
        _downView=[[YJHomeDownView alloc]initWithFrame:CGRectMake(0, kSCREEN_HEIGHT-[YJHomeDownView viewHiddentwHeight], kSCREEN_WIDTH, [YJHomeDownView viewShowHeight])];
        _downView.delegate=self;
        
    }
    return _downView;
}


#pragma UITaleView Delegate And DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return [YJHomeListCell cellHeight];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellstr =@"YJHomeListCell";
    YJHomeListCell * cell =[tableView dequeueReusableCellWithIdentifier:cellstr];
    
    if (cell==nil) {
        cell=[[YJHomeListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstr];
    }
    
    [cell cellForData:[self.dataSource objectAtIndex:indexPath.row]];
    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    //点击查看或修改日记
    YJWriteViewController *writeVC=[[YJWriteViewController alloc]init];
    writeVC.isCreat=NO;
    writeVC.isDismiss=YES;
    writeVC.noteFilePath=[_filePaths objectAtIndex:indexPath.row];
    [self presentViewController:writeVC animated:YES completion:^{
        
    }];

}


/**
 *  YJHomeDownViewDelegate
 *
 *  @param isShow 是否显示完全
 */
- (void)YJHomeDownViewShowState:(BOOL)isShow {
    
    if (isShow) {
        _tableView.frame=CGRectMake(0,0,kSCREEN_WIDTH,kSCREEN_HEIGHT-[YJHomeDownView viewShowHeight]);
    }else
        _tableView.frame=CGRectMake(0,0,kSCREEN_WIDTH,kSCREEN_HEIGHT-[YJHomeDownView viewHiddentwHeight]);

}

/**
 *  YJHomeDownViewDelegate
 *
 *  @param index 100.主题 101.显示 102.设置
 */
- (void)YJHomeDownViewDidSelectIndex:(NSInteger)index {
    switch (index) {
        case 100:{
            [[YJThemeView shareInstance] show];
        }
            break;
        case 101:{
            BaseNavigationController *fontSetVC=[[BaseNavigationController alloc]initWithRootViewController:[[YJFontSettingViewController alloc]init]];
            [self presentViewController:fontSetVC animated:YES completion:^{

            }];
        }
            break;
        case 102:{
            BaseNavigationController *fontSetVC=[[BaseNavigationController alloc]initWithRootViewController:[[YJSettingViewController alloc]init]];
            [self presentViewController:fontSetVC animated:YES completion:^{
                
            }];

        }
            break;
        default:
            break;
    }
}

/**
 *  YJHomeDownViewDelegate
 *  点击写日记
 */
- (void)YJHomeDownViewDidSelectSend {

    YJWriteViewController *writeVC=[[YJWriteViewController alloc]init];
    writeVC.isCreat=YES;
    writeVC.noteFilePath=nil;
    [self presentViewController:writeVC animated:YES completion:^{
        
    }];

}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [[YJThemeView shareInstance] hiddent];
    
    [_downView hiddent];
    
    _tableView.frame=CGRectMake(0,0,kSCREEN_WIDTH,kSCREEN_HEIGHT-[YJHomeDownView viewHiddentwHeight]);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
