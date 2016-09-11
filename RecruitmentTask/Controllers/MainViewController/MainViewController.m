//
//  MainViewController.m
//  RecruitmentTask
//
//  Created by Mateusz Smigowski on 09.09.2016.
//
//

#import "MainViewController.h"

@interface MainViewController ()

@property NSMutableArray<Character *> *charactersArray;
@property NSArray<Character *> *favouriteCharactersArray;
@property MainView *aView;
@property NSIndexPath *expandedCellIndex;

@end

@implementation MainViewController {
    BOOL favouriteFlag;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        favouriteFlag = NO;
        self.charactersArray = [[NSMutableArray alloc] init];
        self.favouriteCharactersArray = self.charactersArray;
    }
    
    return self;
}

#pragma mark - Lifecycles 
- (void)loadView {
    MainView * mainView = [[MainView alloc] init];
    self.aView = mainView;
    [mainView.tableView setDelegate: self];
    [mainView.tableView setDataSource: self];
    
    UIBarButtonItem *sortItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(sortItemAction:)];
    self.navigationItem.rightBarButtonItem = sortItem;
    
    [self setView: mainView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Prepare prarameters for GET request
    NSMutableDictionary *parametersDict = [[NSMutableDictionary alloc] init];
    [parametersDict setObject:@"Character" forKey:@"category"];
    [parametersDict setObject:@"75" forKey:@"limit"];
    [parametersDict setObject:@"1" forKey:@"expand"];

    // Top articles -> items as NSArray
    [[WebApi sharedApi] performRequestGET: baseURL
                           withParameters: parametersDict
                       andCompletionBlock: ^(NSData * data, NSURLResponse *response, NSError *error)
    {
        if (error) { // TODO: Check response code, and show alert 
            NSLog(@"Error %@", error.description);
        } else {
            NSMutableDictionary *dictionaryData = nil;
            dictionaryData = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingMutableContainers
                                                               error: &error];
            error != nil ? NSLog(@"Deserialization problems") : NSLog(@""); // TODO: alert if deserialization fails
    
            NSArray *itemsArray = [dictionaryData objectForKey:@"items"];
            for (NSDictionary *item in itemsArray) {
                Character *newCharacter = [[Character alloc] initWithDictionary:item];
                [self.charactersArray addObject: newCharacter];
            }
            
            NSString *basePath = [dictionaryData objectForKey:@"basepath"];
            [[NSUserDefaults standardUserDefaults] setObject:basePath forKey:@"basepath"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.aView.tableView reloadData];
            });
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view datasource & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.favouriteCharactersArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell"];
    
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"customCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    // Seting index path to recognize gesture
    cell.indexPath = indexPath;
    
    //Configuring tableViewCell
    cell.titleLabel.text = [self.favouriteCharactersArray objectAtIndex: indexPath.row].title;
    cell.abstractTextView.text = [self.favouriteCharactersArray objectAtIndex: indexPath.row].abstract;
    
    //Setting button action
    cell.favouritesButton.tag = indexPath.row;
    [cell.favouritesButton addTarget:self action:@selector(favouriteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    // Setting favourite button color
    if ([self.favouriteCharactersArray objectAtIndex: indexPath.row].favourite) {
        [cell.favouritesButton.imageView setTintColor: [UIColor redColor]];
        [cell.favouritesButton.layer setBorderColor: [UIColor redColor].CGColor];
    } else {
        [cell.favouritesButton.imageView setTintColor: [UIColor blackColor]];
        [cell.favouritesButton.layer setBorderColor: [UIColor blackColor].CGColor];
    }
    
    // Setting long gesture target
    [cell.longPressGestureRecognizer addTarget: self action: @selector(longPressGestureAction:)];
    
    // Setting image
    NSURL *imageUrl = [NSURL URLWithString: [self.favouriteCharactersArray objectAtIndex: indexPath.row].thumbnail];
    [cell.thumbnailImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"10tg77"]];
    [cell.thumbnailImageView sd_setImageWithURL: imageUrl
                               placeholderImage:[UIImage imageNamed:@"10tg77"]
                                      completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                          [self.favouriteCharactersArray objectAtIndex: indexPath.row].thumbnailImage = image;
                                      }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: ad1 hackses cannot update maximumNumberOfLines
    if ([indexPath compare:self.expandedCellIndex] == NSOrderedSame) {
        return 105.0;
    }
    return 89.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Character *character = [self.charactersArray objectAtIndex:indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc] initWithCharacter: character];
    [self.navigationController pushViewController: detail animated:YES];
}

#pragma mark - Helpful methods
- (void)favouriteButtonAction: (UIButton *)sender {
    
    Character *favCharacter = [self.charactersArray objectAtIndex: sender.tag];
    
    if (favCharacter.favourite) {
        favCharacter.favourite = NO;
        [sender.imageView setTintColor: [UIColor blackColor]];
        [sender.layer setBorderColor: [UIColor blackColor].CGColor];

    } else {
        favCharacter.favourite = YES;
        [sender.imageView setTintColor: [UIColor redColor]];
        [sender.layer setBorderColor: [UIColor redColor].CGColor];
    }
}

- (void)sortItemAction: (UIBarButtonItem *)sender {
    favouriteFlag = !favouriteFlag;
    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(Character *evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        if (evaluatedObject.favourite == YES) {
            return YES;
        } else {
            return NO;
        }
    }];
    
    if (favouriteFlag) {
        self.favouriteCharactersArray = [self.charactersArray filteredArrayUsingPredicate:predicate];
    } else {
        self.favouriteCharactersArray = self.charactersArray;
    }
    [self.aView.tableView reloadData];
}

- (void)longPressGestureAction: (UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self.aView.tableView beginUpdates];
        if ([((CustomTableViewCell*) sender.view).indexPath compare: self.expandedCellIndex] == NSOrderedSame) {
            self.expandedCellIndex = nil;
            
        } else {
            self.expandedCellIndex = ((CustomTableViewCell*) sender.view).indexPath;
        }
        [self.aView.tableView endUpdates];
    }
}
@end
