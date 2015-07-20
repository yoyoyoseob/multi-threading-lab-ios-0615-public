//
//  FISViewController.m
//  multiThreadLab
//
//  Created by Joe Burgess on 4/26/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"
#import "FISZipSearchOperation.h"

@interface FISViewController ()
@property (weak, nonatomic) IBOutlet UITextField *zipCode;
@property (weak, nonatomic) IBOutlet UILabel *countyLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (nonatomic, strong) NSMutableArray *entries;
- (IBAction)searchZipCodeTapped:(id)sender;
@end

@implementation FISViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.accessibilityLabel=@"Main View";
    
    [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(changeBackground) userInfo:nil repeats:YES];
}

-(void)changeBackground
{
    NSArray *colorsArray = @[[UIColor redColor], [UIColor blueColor], [UIColor orangeColor], [UIColor grayColor], [UIColor greenColor]];
    NSInteger randomNumber = arc4random_uniform(5);
    self.view.backgroundColor = colorsArray[randomNumber];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)searchZipCodeTapped:(id)sender
{
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc]init];
    FISZipSearchOperation *searchOperation = [[FISZipSearchOperation alloc]initWithZipCode:self.zipCode.text];
    
    searchOperation.zipCodeBlock = ^(FISZipCode *zipCode, NSError *error)
    {
        if (error.code == 101)
        {
            [self displayAlert:error.userInfo[@"NSLocalizedDescriptionKey"]];
        }
        else if (error.code == 102)
        {
            [self displayAlert:error.userInfo[@"NSLocalizedDescriptionKey"]];
        }
        else
        {
        self.countyLabel.text = zipCode.county;
        self.cityLabel.text = zipCode.city;
        self.stateLabel.text = zipCode.state;
        self.latitudeLabel.text = zipCode.latitude;
        self.longitudeLabel.text = zipCode.longitude;
        }
    };
    
    [operationQueue addOperation:searchOperation];
    
}

-(void)displayAlert:(NSString *)errorMessage
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
        self.zipCode.text = @"";
    }];
    
    [alert addAction:okAction];
    
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    [mainQueue addOperationWithBlock:^{
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
