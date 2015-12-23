//
//  ViewController.m
//  JATransitionNavigationBarExample
//
//  Created by Janrin on 15/12/23.
//  Copyright © 2015年 Janrin. All rights reserved.
//

#import "ViewController.h"
#import "JATransitionNavigationBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar convertToTransitionBar:self.tableView useOffset:50.f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
