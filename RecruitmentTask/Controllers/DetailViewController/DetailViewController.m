//
//  DetailViewController.m
//  RecruitmentTask
//
//  Created by Mateusz Smigowski on 09.09.2016.
//
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property Character *character;
@property DetailView *aView;

@end

@implementation DetailViewController

#pragma mark - initialization
-(instancetype)initWithCharacter:(Character *)aCharacter {
    self = [super init];
    if(self) {
        self.character = aCharacter;
    }
    return self;
}

#pragma mark - lifecycles
- (void)loadView {
    DetailView *detailView = [[DetailView alloc] init];
    [detailView.abstractTextView setText: self.character.abstract];
    [detailView.thumbnailImageView setImage: self.character.thumbnailImage];
    [detailView.titleLabel setText: self.character.title];
    [detailView.favourite setImage: [UIImage imageNamed:@"heart-1"]];
    self.character.favourite ? [detailView.favourite setHidden:NO] : [detailView.favourite setHidden:YES];
    
    
    self.aView = detailView;
    
    [self setView: detailView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.aView.webButton addTarget: self action: @selector(webButtonAction:) forControlEvents: UIControlEventTouchUpInside];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webButtonAction: (UIButton *)sender {
    NSString *basePath = [[NSUserDefaults standardUserDefaults] objectForKey:@"basepath"];
    NSLog(@"%@%@", basePath, self.character.url);
    NSString *completeString = [basePath stringByAppendingString: self.character.url];
    NSURL *completeURL = [[NSURL alloc] initWithString: completeString];
    if (completeURL == nil) {
        // TODO: Alert url isnt created, show alert
        return;
    }
    
    if (basePath) {
        [[UIApplication sharedApplication] openURL: completeURL];
    } else {
        NSLog(@"Error -- wrong URL"); //TODO: Wrong base path error
    }
    
    
}

@end
