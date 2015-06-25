//
//  ResultsViewController.h
//  TechTatva15
//
//  Created by YASH on 22/06/15.
//  Copyright (c) 2015 AppDev. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ResultsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (weak, nonatomic) IBOutlet UISearchBar * resultsSearchBar;

@property (strong, nonatomic) NSMutableArray *resultViewSearchResult;
@property BOOL areResultsFiltered;

@end
