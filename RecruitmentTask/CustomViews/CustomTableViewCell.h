//
//  CustomTableViewCell.h
//  RecruitmentTask
//
//  Created by Mateusz Smigowski on 10.09.2016.
//
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface CustomTableViewCell : UITableViewCell

@property UIImageView *thumbnailImageView;
@property UILabel *titleLabel;
@property UITextView *abstractTextView;
@property UIButton *favouritesButton;
@property UILongPressGestureRecognizer *longPressGestureRecognizer;

@property NSIndexPath *indexPath;

@end
