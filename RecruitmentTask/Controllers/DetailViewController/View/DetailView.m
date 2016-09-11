//
//  DetailView.m
//  RecruitmentTask
//
//  Created by Mateusz Smigowski on 09.09.2016.
//
//

#import "DetailView.h"

int const kImageSize = 100;
int const kFavouriteSize = 30;
int const kNavBarHeight = 64;

@implementation DetailView

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        
//        [self setBackgroundColor: [UIColor whiteColor]];
//        
//        [self setupSubviews];
//        [self setupConstraints];
//        
//    }
//    return self;
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setBackgroundColor: [UIColor whiteColor]];
        
        [self setupSubviews];
        [self setupConstraints];
        
    }
    return self;
}

- (void) setupSubviews {
    
    self.thumbnailImageView = [[UIImageView alloc] init];
    [self.thumbnailImageView.layer setCornerRadius:kImageSize / 2];
    [self addSubview:self.thumbnailImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel sizeToFit]; // TODO: Dangerous can be very long and go outside screen
    [self addSubview:self.titleLabel];
    
    self.abstractTextView = [[UITextView alloc] init];
    [self.abstractTextView sizeToFit]; // TODO: Also dangerous, what if text will be very long, -- scrollView enable! :)
    [self.abstractTextView setUserInteractionEnabled: NO];
    [self.abstractTextView setTextAlignment: NSTextAlignmentCenter];
    [self addSubview:self.abstractTextView];
    
    self.favourite = [[UIImageView alloc] init];
    [self.favourite setTintColor: [UIColor blackColor]];
    [self.favourite setContentMode: UIViewContentModeScaleAspectFit];
    [self addSubview:self.favourite];
    
    self.webButton = [[UIButton alloc] init];
    [self.webButton setTitle: @"Show website" forState: UIControlStateNormal];
    [self.webButton setTitleColor: [UIColor colorWithRed:0.0 green:118.0/255 blue:1 alpha:1] forState: UIControlStateNormal];
    [self.webButton setTitleColor: [UIColor colorWithRed:198.0/255.0 green:223.0/255.0 blue:251.0/255.0 alpha:1] forState: UIControlStateHighlighted];
    [self.webButton sizeToFit];
    [self addSubview:self.webButton];
    
}

- (void) setupConstraints {
    
    // Thumbnail constraitns
    [self.thumbnailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(kNavBarHeight + 10);
        make.width.mas_equalTo(kImageSize);
        make.height.mas_equalTo(kImageSize);
    }];
    
    // Title constraints
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thumbnailImageView.mas_bottom).offset(20);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    // Abstract constraints
    [self.abstractTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(50);
    }];
    
    // Favourite button  constraints
    [self.favourite mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thumbnailImageView.mas_top);
        make.left.equalTo(self.thumbnailImageView.mas_right);
        make.width.mas_equalTo(kFavouriteSize);
        make.height.mas_equalTo(kFavouriteSize);
    }];
    
    // Webbutton constraints
    [self.webButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.abstractTextView.mas_bottom).offset(50);
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(20);
    }];
    
}

@end
