//
//  EMUserProfileTableViewController.m
//  TFFiPhone
//
//  Created by Eugene Mekhedov on 16.05.17.
//  Copyright © 2017 Eugene Mekhedov. All rights reserved.
//

#import "EMUserProfileTableViewController.h"
#import "UIImageView+AFNetworking.h"

@interface EMUserProfileTableViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *userImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameSurnameLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateOfBirthLabel;
@property (strong, nonatomic) IBOutlet UILabel *countryLabel;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *placeOfWorkOrStudyLabel;
@property (strong, nonatomic) IBOutlet UILabel *specialityLabel;

@property(strong, nonatomic) NSMutableDictionary* dictLinks;
@property(strong, nonatomic) NSMutableArray* linksArray;
@property(strong, nonatomic) NSMutableArray* imageNamesArray;

@end

@implementation EMUserProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControllerWithUser:self.currentUser];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews{
    self.userImageView.layer.cornerRadius = CGRectGetHeight(self.userImageView.frame)/2;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return (section == 3 ? [self.linksArray count] : [super tableView:self.tableView numberOfRowsInSection:section]);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

    UITableViewCell* cell = [super tableView:self.tableView cellForRowAtIndexPath:indexPath];
    
    if(indexPath.section == 3){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellLinks"];
        cell.textLabel.text = [self.linksArray objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[self.imageNamesArray objectAtIndex:indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 3){
        if([self.linksArray count] > 0)
            return @"LINKS";
        else
            return @"";
    }

    return [super tableView:self.tableView titleForHeaderInSection:section];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 3){
        NSURL* url = [NSURL URLWithString:[self.dictLinks objectForKey:[self.linksArray objectAtIndex:indexPath.row]]];
        [[UIApplication sharedApplication] openURL:url options:NULL completionHandler:^(BOOL success) {
            
        }];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Help methods

-(void) initControllerWithUser:(EMUser*) currentUser{
    
    if(currentUser.imageURL){
        NSURL* imageURL = [NSURL URLWithString:currentUser.imageURL];
        [self.userImageView setImageWithURL:imageURL];
    }else{
        self.userImageView.image = [UIImage imageNamed:@"user-2"];
    }
    
    self.nameSurnameLabel.text = [NSString stringWithFormat:@"%@ %@", currentUser.name, currentUser.surname];
    self.genderLabel.text = currentUser.gender;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    self.dateOfBirthLabel.text = [dateFormatter stringFromDate:currentUser.dateOfBirth];
    
    self.countryLabel.text = currentUser.country;
    self.cityLabel.text = currentUser.city;
    self.emailLabel.text = currentUser.email;
    self.placeOfWorkOrStudyLabel.text = currentUser.placeOfWorkOrStudy;
    self.specialityLabel.text = currentUser.speciality;
    
    [self prepareLinks];
}

-(void) prepareLinks{
    self.dictLinks = [[NSMutableDictionary alloc] init];
    self.linksArray = [[NSMutableArray alloc] init];
    self.imageNamesArray = [[NSMutableArray alloc] init];
    
    if(![self.currentUser.faceBookLink isEqualToString:@""]){
        [self.dictLinks setObject:self.currentUser.faceBookLink forKey:@"facebook"];
        [self.linksArray addObject:@"facebook"];
        [self.imageNamesArray addObject:@"facebook"];
    }
    if(![self.currentUser.skypeLink isEqualToString:@""]){
        [self.dictLinks setObject:self.currentUser.skypeLink forKey:@"Skype"];
        [self.linksArray addObject:@"Skype"];
        [self.imageNamesArray addObject:@"skype"];
    }
    if(![self.currentUser.telegrammLink isEqualToString:@""]){
        [self.dictLinks setObject:self.currentUser.telegrammLink forKey:@"Telegram"];
        [self.linksArray addObject:@"Telegram"];
        [self.imageNamesArray addObject:@"telegram"];
    }
    if(![self.currentUser.googlePlusLink isEqualToString:@""]){
        [self.dictLinks setObject:self.currentUser.googlePlusLink forKey:@"Google Plus"];
        [self.linksArray addObject:@"GooglePlus"];
        [self.imageNamesArray addObject:@"google-plus"];
    }
    if(![self.currentUser.instagrammLink isEqualToString:@""]){
        [self.dictLinks setObject:self.currentUser.instagrammLink forKey:@"Instagram"];
        [self.linksArray addObject:@"Instagram"];
        [self.imageNamesArray addObject:@"instagram"];
    }
    if(![self.currentUser.twitterLink isEqualToString:@""]){
        [self.dictLinks setObject:self.currentUser.twitterLink forKey:@"Twitter"];
        [self.linksArray addObject:@"Twitter"];
        [self.imageNamesArray addObject:@"twitter"];
    }
    if(![self.currentUser.behanceLink isEqualToString:@""]){
        [self.dictLinks setObject:self.currentUser.behanceLink forKey:@"Behance"];
        [self.linksArray addObject:@"Behance"];
        [self.imageNamesArray addObject:@"behance"];
    }
    if(![self.currentUser.linkedInLink isEqualToString:@""]){
        [self.dictLinks setObject:self.currentUser.linkedInLink forKey:@"LinkedIn"];
        [self.linksArray addObject:@"LinkedIn"];
        [self.imageNamesArray addObject:@"linkedin"];
    }

}

@end
