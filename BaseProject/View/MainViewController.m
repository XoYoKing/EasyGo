//
//  MainViewController.m
//  BaseProject
//
//  Created by jake on 15/10/22.
//  Copyright © 2015年 Tarena. All rights reserved.
//

#import "MainViewController.h"
#import "LocationViewController.h"
#import "GoLocationViewController.h"
@interface MainViewController () <LocationViewControllerDelegate,GoLocationViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;
@property (weak, nonatomic) IBOutlet UIView *weatherView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *placeSegment;
@property (weak, nonatomic) IBOutlet UIButton *goWhereButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *setMyLocation;
//本地的地址
@property (nonatomic , strong) NSString *localName;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer *layer = self.goWhereButton.layer;
    layer.shadowColor = [[UIColor blackColor]CGColor];
    layer.cornerRadius = 30;
    //透明度
    layer.shadowOpacity = 0.6;
    
}

//实现代理方法
- (void)locationViewEnd:(LocationViewController *)senderVC withLocalName:(NSString *)localName{
    self.localName = localName;
    DDLogVerbose(@"本地地址是%@",self.localName);
    [self.placeSegment setTitle:self.localName forSegmentAtIndex:0];
}

- (void)goLocationView:(GoLocationViewController *)senderVC withDistination:(NSString *)destination{
    self.destination = destination;
    DDLogVerbose(@"目的地址是%@",self.destination);
    [self.placeSegment setTitle:self.destination forSegmentAtIndex:1];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"MyLocationSegue"]){
        LocationViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }else if([segue.identifier isEqualToString:@"GoLocationSegue"]){
        GoLocationViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}


@end
