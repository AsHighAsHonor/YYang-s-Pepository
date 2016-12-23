//
//  ViewController.m
//  YYTreeTableView
//
//  Created by YYang on 22/12/2016.
//  Copyright © 2016 YYang. All rights reserved.
//

#import "ViewController.h"
#import "TreeTableView.h"
#import "OrginalModel.h"


@interface ViewController ()<ThreeTableViewDelegate>

@property (strong, nonatomic)TreeTableView *myTableView;


@property(nonatomic,assign)NSUInteger selectedRow;//选中的行

@property(nonatomic,strong)NSMutableArray<OrginalModel*> *orginalModels;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myTableView];
    
}


#pragma mark - AddConstaints
-(void)updateViewConstraints
{
    [super updateViewConstraints];
    
    //水平方向上，logoImageView左侧与父视图左侧/右侧对齐
    NSArray* hConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[myTableView]|" options:0 metrics:nil views:@{@"myTableView": self.myTableView}];
    [NSLayoutConstraint activateConstraints:hConstraintArray];
    
    //垂直方向上，logoImageView顶部与父视图顶部/底部对齐
    NSArray* vConstraintArray = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[myTableView]|" options:0 metrics:nil views:@{@"myTableView":self.myTableView}];
    [NSLayoutConstraint activateConstraints:vConstraintArray];

    
}


#pragma mark - Delegate Methods
#pragma mark TreeTableViewDelegate
-(void)threeTableView:(TreeTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath WithParentNode:(Node *)node
{
    
}

//点击 checkBox
-(void)threeTableView:(TreeTableView *)tableView checkBoxClickedWithParentNode:(Node *)node atIndexPath:(NSIndexPath *)indexPath{
    
    
}





#pragma mark -Getters and Setters
-(TreeTableView *)myTableView
{
    if(!_myTableView)
    {
        _myTableView = ({
            TreeTableView* tree  = [[TreeTableView alloc]initWithDataSource:self.orginalModels];
            tree.translatesAutoresizingMaskIntoConstraints = NO;
            tree.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
            tree.myDelegate = self;
            tree;
        });
    }
    return _myTableView;
}


-(NSMutableArray *)orginalModels
{
    if(!_orginalModels)
    {
        _orginalModels  = [NSMutableArray array];
        NSError *error;
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"infos"ofType:@"json"];
        NSData *jdata = [[NSData alloc] initWithContentsOfFile:filePath options:0 error:&error];
        NSDictionary * infoDic = [NSJSONSerialization JSONObjectWithData:jdata options:kNilOptions error:&error];
        [infoDic[@"info"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            OrginalModel *orginal = [[OrginalModel alloc]init];
            orginal.org_id = obj[@"org_id"];
            orginal.org_level = obj[@"org_level"];
            orginal.display_id = obj[@"display_id"];
            orginal.org_name = obj[@"org_name"];
            orginal.short_name = obj[@"short_name"];
            orginal.display_id = obj[@"display_id"];
            orginal.is_end = obj[@"is_end"];
            orginal.parent_org_id = obj[@"parent_org_id"];
            [_orginalModels addObject:orginal];
        }];

    }
    return _orginalModels;
}



@end
