//
//  FavouritesViewController.m
//  TechTatva15
//
//  Created by YASH on 28/08/15.
//  Copyright (c) 2015 AppDev. All rights reserved.
//

#import "FavouritesViewController.h"
#import "CoreDataModel.h"
#import "eventViewTableViewCell.h"
#import "Event.h"

@interface FavouritesViewController () <UITableViewDataSource, UITableViewDelegate>
{
    
    NSMutableArray *favouritesArray;
    
}

@property NSIndexPath *previousSelectedIndexPath;
@property NSIndexPath *currentSelectedIndexPath;

@end

@implementation FavouritesViewController

@synthesize favouritesTable;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Favourites";
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    
    self.navigationController.navigationBar.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.navigationController.navigationBar.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.navigationController.navigationBar.layer.shadowRadius = 2.0f;
    self.navigationController.navigationBar.layer.shadowOpacity = 1.0f;
    
    favouritesTable.scrollsToTop = YES;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Favourites"];
    NSError *error = nil;
    
    NSArray *fetchedArray = [[CoreDataModel managedObjectContext] executeFetchRequest:fetchRequest error:&error];
    favouritesArray = [[NSMutableArray alloc] init];
    favouritesArray = [fetchedArray mutableCopy];
    
    [favouritesTable reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

# pragma mark - Table View Data Source Methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [favouritesArray count];
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell";
    
    eventViewTableViewCell *cell = (eventViewTableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"eventViewTableViewCell" owner:self options:nil];
    
    cell = [nib objectAtIndex:0];
    
    cell.timeImageView = nil;
    cell.venueImageView = nil;
    cell.contactImageView = nil;
    cell.dateImageView = nil;
    cell.maxTeamMembersImageView = nil;
    
    Event *event = [favouritesArray objectAtIndex:indexPath.row];
    cell.venueLabel.text = event.location;
    cell.eventLabel.text = event.event;
    cell.timeLabel.text = [NSString stringWithFormat:@"%@-%@",event.start,event.stop];
    cell.contactLabel.text = event.contact;
    cell.dateLabel.text = [NSString stringWithFormat:@"%@ - Day %@",event.date,event.day];
    cell.maxTeamMembersLabel.text = event.maxTeamSize;
    cell.categoryLabel.text = event.category;
    
    cell.indexPathForCell = indexPath;
    
    return cell;
    
}

# pragma mark - Table View Delegate Methods

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.previousSelectedIndexPath = self.currentSelectedIndexPath;
    self.currentSelectedIndexPath = indexPath;
    
    if (self.previousSelectedIndexPath && !([self.previousSelectedIndexPath compare:self.currentSelectedIndexPath] == NSOrderedSame))
    {
        
        [favouritesTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:self.previousSelectedIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
    else if ((self.previousSelectedIndexPath) && [self.previousSelectedIndexPath compare:self.currentSelectedIndexPath] == NSOrderedSame)
    {
        
        [favouritesTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:self.currentSelectedIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
    else
    {
        
        [favouritesTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:self.currentSelectedIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (([self.currentSelectedIndexPath compare:indexPath] == NSOrderedSame) && ([self.currentSelectedIndexPath compare:self.previousSelectedIndexPath] == NSOrderedSame))
    {
        
        return 43;
        
    }
    
    else if ((self.currentSelectedIndexPath != nil) && [self.currentSelectedIndexPath compare:indexPath] == NSOrderedSame)
    {
        
        return 255;
        
    }
    
    else
    {
        
        return 43;
        
    }
    
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