//
//  CustomTableViewCell.m
//  RecruitmentTask
//
//  Created by Mateusz Smigowski on 10.09.2016.
//
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    
    if (self) {
        //Adding gesture recognizers
        self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
        [self addGestureRecognizer: self.longPressGestureRecognizer];
        
        [self setupSubviews];
        [self updateConstraints];
    }
    
    return self;
}

- (void)updateConstraints {
    // Constraints for thumbnail
    [self.thumbnailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thumbnailImageView.superview.mas_left).with.offset(10);
        make.centerY.equalTo(self.thumbnailImageView.superview.mas_centerY);
        make.width.equalTo(self.thumbnailImageView.superview.mas_width).multipliedBy(0.2);
        make.height.equalTo(self.thumbnailImageView.superview.mas_width).multipliedBy(0.2);
    }];
    
    // Consttarints for title
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thumbnailImageView.mas_right).with.offset(10);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
    }];
    
    // Constraint for abstract
    [self.abstractTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.thumbnailImageView.mas_right).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    // Constrains for favourites
    [self.favouritesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [super updateConstraints];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setupSubviews {
    
    self.thumbnailImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.thumbnailImageView];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel sizeToFit];
    [self.contentView addSubview:self.titleLabel];
    
    self.abstractTextView = [[UITextView alloc] init];
//    [self.abstractTextView.textContainer setMaximumNumberOfLines: 2]; //TODO: Here are little hacks ad1
    [self.abstractTextView setUserInteractionEnabled:NO];
    [self.contentView addSubview:self.abstractTextView];
    
    self.favouritesButton = [[UIButton alloc] init];
    [self.favouritesButton setImage: [UIImage imageNamed:@"heart-1"] forState: UIControlStateNormal];
    [self.favouritesButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.favouritesButton.layer setCornerRadius:15];
    [self.favouritesButton.layer setBorderWidth:1];
    [self.favouritesButton.layer setBorderColor: [UIColor blackColor].CGColor];
    [self.favouritesButton.imageView setTintColor: [UIColor blackColor]];
    [self.contentView addSubview:self.favouritesButton];
}

- (void) setupConstraints {
    
}

@end
