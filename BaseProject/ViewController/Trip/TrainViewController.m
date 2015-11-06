//
//  TrainViewController.m
//  WeatherNews
//
//  Created by jake on 15/11/2.
//  Copyright © 2015年 Tarena. All rights reserved.
//
//此界面也充当出行这一块的主界面，可以推到其他的界面，所以在本界面上会初始化其他vc对象
#import "TrainViewController.h"
#import "ReMenu.h"
#import "DriveViewController.h"
#import "SubwayViewController.h"
#import "BusViewController.h"
#import "GoLocationViewController.h"
#import "LocationViewController.h"
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"
#import "Color.h"
@interface TrainViewController () <GoLocationViewControllerDelegate,LocationViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) DriveViewController *dvc;
@property (nonatomic , strong) SubwayViewController *svc;
@property (nonatomic , strong) BusViewController *bvc;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic , strong) NSString *start;
@property (nonatomic , strong) NSString *end;

@property (nonatomic , strong) NSString *satrtDate;
@property (nonatomic , strong) CalendarHomeViewController *chvc;
@end

@implementation TrainViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        //注册广播
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:@"location" object:nil];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"出行方式" style:UIBarButtonItemStyleBordered target:self action:@selector(showReMenu)];
    self.tableView.tableFooterView = [UIView new];
   
}
#pragma mark - 起点和终点选择的代理方法
- (void)goLocationView:(GoLocationViewController *)senderVC withDistination:(NSString *)destination{
    self.end = destination;
    [self.tableView reloadData];
}

- (void)locationViewEnd:(LocationViewController *)senderVC withLocalName:(NSString *)localName{
    self.start = localName;
    [self.tableView reloadData];
}

#pragma mark - 广播接收消息

-(void)receiveMessage:(NSNotification *)notification{
    
    NSDictionary *location = notification.userInfo;
    //按照key值，取到value
    self.start = location[@"start"];
    self.end = location[@"end"];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - ReMenu
- (void)showReMenu{
    if (_menu.isOpen)
        return [_menu close];
    
    REMenuItem *homeItem = [[REMenuItem alloc] initWithTitle:@"火车，动车，高铁"
                                                    subtitle:@"支持实时余票查询，车次查询"
                                                       image:[UIImage imageNamed:@"01.png"]
                                            highlightedImage:nil
                                                      action:^(REMenuItem *item) {
                                                          NSLog(@"Item: %@", item);
                                                          [self.dvc.view removeFromSuperview];
                                                          [self.svc.view removeFromSuperview];
                                                          [self.bvc.view removeFromSuperview];
                                                      }];
    
    REMenuItem *exploreItem = [[REMenuItem alloc] initWithTitle:@"自驾"
                                                       subtitle:@"基于百度地图导航"
                                                          image:[UIImage imageNamed:@"00.png"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                             
                                                             [self.svc.view removeFromSuperview];
                                                             [self.bvc.view removeFromSuperview];
                                                             [self.view addSubview:self.dvc.view];
                                                         }];
    
    REMenuItem *activityItem = [[REMenuItem alloc] initWithTitle:@"地铁"
                                                        subtitle:@"地铁线路规划"
                                                           image:[UIImage imageNamed:@"02.png"]
                                                highlightedImage:nil
                                                          action:^(REMenuItem *item) {
                                                              NSLog(@"Item: %@", item);
                                                              [self.dvc.view removeFromSuperview];
                                                              [self.bvc.view removeFromSuperview];
                                                              [self.view addSubview:self.svc.view];
                                                          }];
    
    REMenuItem *profileItem = [[REMenuItem alloc] initWithTitle:@"公交"
                                                       subtitle:@"公交线路规划，站点查询"
                                                          image:[UIImage imageNamed:@"03.png"]
                                               highlightedImage:nil
                                                         action:^(REMenuItem *item) {
                                                             NSLog(@"Item: %@", item);
                                                             [self.svc.view removeFromSuperview];
                                                             [self.dvc.view removeFromSuperview];
                                                             [self.view addSubview:self.bvc.view];
                                                         }];
    
    self.menu = [[REMenu alloc] initWithItems:@[homeItem, exploreItem, activityItem, profileItem]];
    _menu.cornerRadius = 5;
    _menu.textColor = [UIColor whiteColor];
//    _menu.backgroundColor = kRGBAColor(21, 94, 228,0.6);
    _menu.subtitleTextColor = [UIColor whiteColor];
    _menu.backgroundAlpha = 0.5;
    _menu.separatorColor = [UIColor whiteColor];
    _menu.subtitleTextShadowColor = [UIColor clearColor];
    _menu.imageOffset = CGSizeMake(30, -1);
    [self.menu showFromNavigationController:self.navigationController];
}
#pragma mark - TableViewDateSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if(section == 0){
        return 3;
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            cell = [tableView dequeueReusableCellWithIdentifier:@"TrainStartCell" forIndexPath:indexPath];
            cell.detailTextLabel.text = self.start;
            cell.imageView.image = [UIImage imageNamed:@"00.png"];
        }else if(indexPath.row == 1){
            cell = [tableView dequeueReusableCellWithIdentifier:@"TrainEndCell" forIndexPath:indexPath];
            cell.detailTextLabel.text = self.end;
            cell.imageView.image = [UIImage imageNamed:@"07.png"];
        }else{
            cell = [tableView dequeueReusableCellWithIdentifier:@"TrainStartDateCell" forIndexPath:indexPath];
            cell.detailTextLabel.text = self.satrtDate;
            cell.imageView.image = [UIImage imageNamed:@"09.png"];
        }
    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:@"TrainSearchCell" forIndexPath:indexPath];
    }
    return cell;
}


#pragma mark - TableViewDelegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            LocationViewController *lvc = [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"LocationViewController"];
            lvc.delegate = self;
            [self.navigationController pushViewController:lvc animated:YES];
        }else if(indexPath.row == 1){
            GoLocationViewController *gvc = [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"GoLocationViewController"];
            gvc.delegate = self;
            [self.navigationController pushViewController:gvc animated:YES];
        }else{
            __weak TrainViewController *weakSelf = self;
            self.chvc.calendarblock = ^(CalendarDayModel *model){
                
                NSLog(@"\n---------------------------");
                NSLog(@"1星期 %@",[model getWeek]);
                NSLog(@"2字符串 %@",[model toString]);
                NSLog(@"3节日  %@",model.holiday);
                
            weakSelf.satrtDate = [NSString stringWithFormat:@"%@ %@",[model toString],[model getWeek]];
                [weakSelf.tableView reloadData];
            };
            
            [self.navigationController pushViewController:self.chvc animated:YES];

        }
    }else{
        
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark- 其他界面的初始化
- (DriveViewController *)dvc {
	if(_dvc == nil) {
		_dvc = [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"DriveViewController"];
	}
	return _dvc;
}

- (SubwayViewController *)svc {
	if(_svc == nil) {
        _svc = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"SubwayViewController"] ;
	}
	return _svc;
}

- (BusViewController *)bvc {
	if(_bvc == nil) {
		_bvc = [kStoryboard(@"Main")instantiateViewControllerWithIdentifier:@"BusViewController"];
	}
	return _bvc;
}

- (CalendarHomeViewController *)chvc {
	if(_chvc == nil) {
		_chvc = [[CalendarHomeViewController alloc] init];
        _chvc.calendartitle = @"选择出行日期";
        [_chvc setAirPlaneToDay:365 ToDateforString:nil];
	}
	return _chvc;
}

- (NSString *)satrtDate {
	if(_satrtDate == nil) {
		_satrtDate = [[NSString alloc] init];
        _satrtDate = [self getDateAndWeek];
	}
	return _satrtDate;
}

@end