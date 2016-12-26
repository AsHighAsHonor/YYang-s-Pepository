//
//  TreeTableView.m
//  GXMoblieOA
//
//  Created by YYang on 16/3/30.
//  Copyright © 2016年 YYang. All rights reserved.
//

#import "TreeTableView.h"
#import "Node.h"
#import "ChoiceHandlerCell.h"
#import "OrginalModel.h"



@interface TreeTableView ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)Node *selectedNode;

@property (nonatomic, strong) NSMutableArray *nodeArray;//节点个数

@property(nonatomic,strong)NSIndexPath *preIndex;

@property (nonatomic, assign) CGPoint lastContentOffset; // 记录滑动的位置

@end

@implementation TreeTableView
static NSString *const reuseableId = @"ChoiceHandlerCell";
#pragma mark - Life Cycle

-(instancetype)initWithDataSource:(NSMutableArray *)dataSource
{
    self = [super init];
    if(self)
    {
        self.dataSource = self;
        self.delegate = self;
        self.originDatas = dataSource;
        [self configureSelf];
    }
    return self;
}

#pragma mark - InitSubviews
-(void)configureSelf
{
    [self registerNib:[UINib nibWithNibName:reuseableId bundle:[NSBundle mainBundle]] forCellReuseIdentifier:reuseableId];
    self.rowHeight = 60;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self generateDataWithData:self.originDatas];
}


#pragma mark - Delegate Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.nodeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ChoiceHandlerCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseableId forIndexPath:indexPath];
    
    
    Node *node = [self.nodeArray objectAtIndex:indexPath.row];
    cell.expandable = node.isExpand;
    cell.indentationLevel = node.depth.intValue -1;//展开层级
    cell.indentationWidth = 20.f;
    cell.handlerNameLabel.text =node.name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.checkBoxLeftConstraint.constant = (node.depth.intValue - 1)*cell.indentationWidth +10;
    //10 it's improtant to indentation
    cell.checkBoxBtn.tag = indexPath.row;
    cell.checkBoxBtn.selected = node.isChecked;
    
    if([node.isEnd isEqualToString:@"0"]){
        cell.foldBtn.hidden = YES;
        cell.checkBoxBtn.hidden = NO;
    }else if([node.isEnd isEqualToString:@"1"]){
        cell.checkBoxBtn.hidden = NO;
        cell.foldBtn.hidden = NO;
    }
    
    
    /**
     添加右侧 checkBox 选中取消事件
     */
    [cell.checkBoxBtn addTarget:self action:@selector(checkBoxClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    /**
     *
     *  添加折叠按钮事件
     *
     */
    [cell.foldBtn addTarget:self action:@selector(foldBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
}



#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获取到 点击的这个 node
    self.selectedNode = [self.nodeArray objectAtIndex:indexPath.row];
    [self modifyOriginalData];

    self.lastContentOffset = self.contentOffset;
    
//    //这里选上checkBox前先判断非隐藏的才能选
//    ChoiceHandlerCell *choiceCell=[tableView cellForRowAtIndexPath:indexPath];
//    if (!choiceCell.checkBoxBtn.hidden) {
//        [self checkBoxClicked:choiceCell.checkBoxBtn];
//    }
//    
    //代理方法
    //    if ([self.myDelegate respondsToSelector:@selector(threeTableView:didSelectRowAtIndexPath:WithParentNode:)]){
    //        [self.myDelegate threeTableView:self didSelectRowAtIndexPath:indexPath WithParentNode:self.selectedNode];
    //    }
}


#pragma mark - ResopnseEvents
- (void)checkBoxClicked:(UIButton *)checkBox{
    self.selectedNode = [self.nodeArray objectAtIndex:checkBox.tag];
    [self checkBoxModifyOriginalData];
    //代理方法
//    if([self.myDelegate respondsToSelector:@selector(threeTableView:checkBoxClickedWithParentNode:atIndexPath:)]){
//        [self.myDelegate threeTableView:self checkBoxClickedWithParentNode:self.selectedNode atIndexPath:[NSIndexPath indexPathForRow:checkBox.tag inSection:0]];
//    }
}

- (void)foldBtnClicked:(UIButton *)sender{
    
    UITableViewCell *cell = [self tableViewCellContainsView:sender];
    if (!cell) {
        return;
    }
    
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    self.selectedNode = [self.nodeArray objectAtIndex:indexPath.row];
    if ([self.myDelegate respondsToSelector:@selector(threeTableView:foldBtnClickedAtIndexPath:parentNode:)]){
        [self.myDelegate threeTableView:self foldBtnClickedAtIndexPath:indexPath parentNode:self.selectedNode];
    }
    
    self.lastContentOffset = self.contentOffset;
}

#pragma mark - Private Methods

-(void)generateDataWithData:(NSMutableArray<OrginalModel *> *)data
{
    CGPoint oldOffset = self.contentOffset;
    self.originDatas =data;
    [self.nodeArray removeAllObjects];
    
    //根据原始模型数据 构造TreeTable使用的Node模型数据
    [data enumerateObjectsUsingBlock:^(OrginalModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj.org_level isEqualToString:@"1"]){
            obj.display = YES;
        }
        if (obj.display) {
            Node *node = [[Node alloc]initWithParentId:obj.parent_org_id nodeId:obj.org_id name:obj.org_name depth:obj.org_level expand:obj.isExpand andCheckStatus:obj.isChecked andIsEnd:obj.is_end];
            [self.nodeArray addObject:node];
        }
        
        if (idx == self.originDatas.count-1) {
            //滚动到当前位置
            self.contentOffset = oldOffset;
            [self reloadData];
        }

    }];
    
    
}

- (UITableViewCell *)tableViewCellContainsView:(UIView *)view{
    UIView *superView = view.superview;
    if (![superView isKindOfClass:[UITableViewCell class]] && superView) {
        superView = superView.superview;
    }
    return (UITableViewCell *)superView;
}



/**
 折叠隐藏控制
 */
-(void)modifyOriginalData{
    
    __block NSInteger vernier;    //游标 用于标示 子节点/孙子节点的范围....
    [self.originDatas enumerateObjectsUsingBlock:^(OrginalModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
        if ([self.selectedNode.nodeId isEqualToString:obj.org_id]) {
            vernier = idx; //当前选中的节点的 index 作为游标的起点 游标起点
        }
        
        if (self.selectedNode.isExpand && (( (vernier == 0 || idx ==vernier+1) && obj.org_level > self.selectedNode.depth)) ) {
            //1.点击的节点当前是展开状态  || [obj.parent_org_id isEqualToString:self.selectedNode.nodeId]
            //2.在遍历时保证是该节点下的孙子节点.....  当前节点深度<遍历节点深度
            //隐藏
            obj.display = NO; //所有子节点孙子节点 显示状态置为 NO
            obj.expand = NO; //所有子节点孙子节点 展开状态置为 NO
            vernier++;
        } else if(!self.selectedNode.isExpand && [obj.parent_org_id isEqualToString:self.selectedNode.nodeId]){
            //显示
            obj.display = YES;
        }
        
        //设置当前节点的展开状态
        if ([obj.org_id isEqualToString:self.selectedNode.nodeId]) {
            obj.expand = !obj.isExpand;
        }
        
        //遍历完成后刷新数据源
        if (idx == self.originDatas.count-1) {
            [self generateDataWithData:self.originDatas];
        }
        
    }];
}


/**
 CheckBox 控制选中状态
 */
-(void)checkBoxModifyOriginalData{
    [self.originDatas enumerateObjectsUsingBlock:^(OrginalModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([self.selectedNode.nodeId isEqualToString:obj.org_id]) {
            obj.checked = !obj.isChecked;
            *stop = YES;
            [self generateDataWithData:self.originDatas];
        }
        
    }];

}


#pragma mark - Getters and Setters
-(NSMutableArray *)originDatas
{
    if(!_originDatas)
    {
        _originDatas  = [NSMutableArray array];
    }
    [self reloadData];
    return _originDatas;
}



-(NSMutableArray *)nodeArray
{
    if(!_nodeArray)
    {
        _nodeArray  = [NSMutableArray array];
    }
    return _nodeArray;
}




@end
