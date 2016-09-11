//
//  MainView.m
//  RecruitmentTask
//
//  Created by Mateusz Smigowski on 09.09.2016.
//
//

#import "MainView.h"

@implementation MainView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setBackgroundColor: [UIColor redColor]];
        [self setTranslatesAutoresizingMaskIntoConstraints:YES];
        
        [self setupSubviews];
        [self setupConstraints];
        
    }
    return self;
}

- (void) setupSubviews {
    
    self.tableView = [[UITableView alloc] init];
    [self.tableView setBackgroundColor: [UIColor whiteColor]];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.tableView];
    
}

- (void) setupConstraints {
    
    // TableView Constraints
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}

@end
