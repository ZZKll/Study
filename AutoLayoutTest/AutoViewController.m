//
//  AutoViewController.m
//  AutoLayoutTest
//
//  Created by damon on 16/8/5.
//  Copyright © 2016年 yaocaimaimai. All rights reserved.
//

#import "AutoViewController.h"
#import "FDFeedEntity.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "AutonTableViewCell.h"
#import "ReactiveCocoa.h"


@interface AutoViewController () <UITableViewDelegate ,UITableViewDataSource> {

    UITableView *_tableView ;
}
@property (nonatomic, copy) NSArray *prototypeEntitiesFromJSON;
@property (nonatomic, strong) NSMutableArray *feedEntitySections; // 2d array
@end

@implementation AutoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"AutoLayoult" ;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTableView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"test" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 64, 200, 70);
    btn.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:btn];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
           NSLog(@"---------");
         
     }];

    
    
    [self buildTestDataThen:^{
        self.feedEntitySections = @[].mutableCopy;
        [self.feedEntitySections addObject:self.prototypeEntitiesFromJSON.mutableCopy];
        [_tableView reloadData];
    }];
}

- (void)buildTestDataThen:(void (^)(void))then {
    // Simulate an async request
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Data from `data.json`
        NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feedDicts = rootDict[@"feed"];
        
        // Convert to `FDFeedEntity`
        NSMutableArray *entities = @[].mutableCopy;
        [feedDicts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [entities addObject:[[FDFeedEntity alloc] initWithDictionary:obj]];
        }];
        self.prototypeEntitiesFromJSON = entities;
        
        // Callback
        dispatch_async(dispatch_get_main_queue(), ^{
            !then ?: then();
        });
    });
}
- (void)createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self ;
    _tableView.dataSource = self ;
    
    [self.view addSubview:_tableView];
    
    _tableView.tableFooterView = [UIView new];
    
    [_tableView registerClass:[AutonTableViewCell class] forCellReuseIdentifier:@"AutonTableViewCell"];
    
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [_tableView fd_heightForCellWithIdentifier:@"AutonTableViewCell" configuration:^(id cell) {
        
        
        [self setupModelCell:cell andIndexPath:indexPath];
    }];
}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.feedEntitySections[section] count] ;
}


- (NSInteger )numberOfSectionsInTableView:(UITableView *)tableView {
    return self.feedEntitySections.count ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AutonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AutonTableViewCell"];
    
    [self setupModelCell:cell andIndexPath:indexPath];
    
    return cell ;
}

- (void)setupModelCell:(AutonTableViewCell *)cell andIndexPath:(NSIndexPath *)indexPath {

    cell.entity = self.feedEntitySections[indexPath.section][indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
