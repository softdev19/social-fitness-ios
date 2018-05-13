//
//  ShoppingGrocerCategoryViewController.m
//  Diet Achiever
//
//  Created by Wang on 2/22/17.
//  Copyright © 2017 summit. All rights reserved.
//

#import "ShoppingGrocerCategoryViewController.h"

@interface ShoppingGrocerCategoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet JWDynamicLabel *categoryTitle;
@property (weak, nonatomic) IBOutlet JWDynamicLabel *categorySubTitle;
@property (weak, nonatomic) IBOutlet UITextField *txt_additem_placefolder;

@end

@implementation ShoppingGrocerCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initialize {
    
    self.categoryTitle.text = _categoryString;
    self.categorySubTitle.text = [NSString stringWithFormat:@"SELECT YOUR %@", _categoryString.uppercaseString];
    [self.txt_additem_placefolder setPlaceholder:[NSString stringWithFormat:@"Add new %@", _categoryString]];
}
//-------------------------------------------------------------------------------
// Mark: - TableView Delegate     // Use Interface with Shopping Share TableView
//-------------------------------------------------------------------------------

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"ShoppingGrocerCateListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
