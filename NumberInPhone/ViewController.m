//
//  ViewController.m
//  NumberInPhone
//
//  Created by Leo Mdivani on 27/09/2014.
//  Copyright (c) 2014 Dizzolve. All rights reserved.
//

#import "ViewController.h"
#import "APContact.h"

@implementation ViewController

@synthesize addressBook;
@synthesize cheesyArray;
@synthesize yesButton;
@synthesize cheesyLine;
@synthesize putInNumber;
@synthesize noButton;
@synthesize contactButton;

@synthesize btnCreateNewContact;
@synthesize callLabel;
@synthesize userImage;
@synthesize phoneImage;
@synthesize background;
@synthesize cheesyContainer;
@synthesize contactView;
@synthesize footerButtonView;
@synthesize superView;
@synthesize cheesyInsideView;

@synthesize imageArray;
@synthesize backButton;
@synthesize contactsTableView;
@synthesize contactArray;















- (void)viewDidLoad
{
    [super viewDidLoad];
    [self paralax];
    
    contactView.hidden = true;
    btnCreateNewContact.hidden =true;
    [background setImage:[UIImage imageNamed:@"bg.jpg"]];
    addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    [self checkAddressBookAccess];
    [self getContacts];

    [self reloadCheeseFunction];
    self.footerButtonView.dynamic = TRUE;
    self.footerButtonView.blurRadius = 15;
    self.cheesyContainer.dynamic = TRUE;
    self.contactView.dynamic = TRUE;
    self.cheesyContainer.blurRadius = 15;
    self.contactView.blurRadius = 15;
    self.Navbar.dynamic = TRUE;
    self.Navbar.blurRadius = 5;
    backButton.hidden = true;
    self.contactsTableView.hidden=true;
    putInNumber.textColor = [UIColor whiteColor];
    




   

}


- (IBAction)contactButtonClicked:(id)sender {
    
    
        self.contactButton.hidden=false;
        self.contactsTableView.hidden=false;
        
        
        [UIView transitionWithView:contactsTableView
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCurlDown
                        animations:NULL
                        completion:NULL];
    
   

}



- (IBAction)backButtonClicked:(id)sender {
    contactView.hidden = true;
    cheesyContainer.hidden = false;
    
    [UIView transitionWithView:superView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:NULL
                    completion:NULL];
    yesButton.hidden= false;
    noButton.hidden= false;
    btnCreateNewContact.hidden = true ;
    backButton.hidden = true;
    self.contactsTableView.hidden=true;

    [self reloadCheeseFunction];


    

    


}


- (void)paralax
{
    // Set vertical effect
    UIInterpolatingMotionEffect *verticalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.y"
     type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    verticalMotionEffect.minimumRelativeValue = @(-50);
    verticalMotionEffect.maximumRelativeValue = @(50);
    
    // Set horizontal effect
    UIInterpolatingMotionEffect *horizontalMotionEffect =
    [[UIInterpolatingMotionEffect alloc]
     initWithKeyPath:@"center.x"
     type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    horizontalMotionEffect.minimumRelativeValue = @(-50);
    horizontalMotionEffect.maximumRelativeValue = @(50);
    
    // Create group to combine both
    UIMotionEffectGroup *group = [UIMotionEffectGroup new];
    group.motionEffects = @[horizontalMotionEffect, verticalMotionEffect];
    
    // Add both effects to your view
    [background addMotionEffect:group];
}
- (IBAction)btnCreateNewContactClicked:(id)sender {
    
    NSString *Name = self.Name.text;
    NSString *Number = self.Number.text;

    
    if (Name.length > 2 && Number.length > 6 ) {
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
        ABRecordRef new = ABPersonCreate();
        ABRecordSetValue(new, kABPersonFirstNameProperty, (__bridge CFStringRef)Name, nil);
        
        
        ABMutableMultiValueRef Numbers = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(Numbers, (__bridge CFStringRef)Number, kABPersonPhoneMainLabel, NULL);
        ABRecordSetValue(new, kABPersonPhoneProperty, Numbers, nil);
        
        ABAddressBookAddRecord(addressBookRef, new, nil);
        
        NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
        for (id record in allContacts){
            ABRecordRef thisContact = (__bridge ABRecordRef)record;
            if (CFStringCompare(ABRecordCopyCompositeName(thisContact),
                                ABRecordCopyCompositeName(new), 0) == kCFCompareEqualTo){
                //The contact already exists!
                UIAlertView *contactExistsAlert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"There can only be one %@", Name] message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [contactExistsAlert show];
                return;
            }
        }
        ABAddressBookSave(addressBookRef, nil);
        UIAlertView *contactAddedAlert = [[UIAlertView alloc]initWithTitle:@"Saved! Ill be in touch soon " message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [contactAddedAlert show];
        self.Name.text=@"";
        self.Number.text=@"";


    }
    else {
        UIAlertView *emptyAlert = [[UIAlertView alloc]initWithTitle:@"Thats a fake contact. Try again with the correct details" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [emptyAlert show];
    }
}


#pragma mark Address Book Access
// Check the authorization status of our application for Address Book
-(void)checkAddressBookAccess
{
    switch (ABAddressBookGetAuthorizationStatus())
    {
            // Update our UI if the user has granted access to their Contacts
        case  kABAuthorizationStatusAuthorized:
            break;
            // Prompt the user for access to Contacts if there is no definitive answer
        case  kABAuthorizationStatusNotDetermined :
            [self requestAddressBookAccess];
            break;
            // Display a message if the user has denied or restricted access to Contacts
        case  kABAuthorizationStatusDenied:
        case  kABAuthorizationStatusRestricted:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Privacy Warning"
                                                            message:@"Permission was not granted for Contacts."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
            break;
        default:
            break;
    }
}

// Prompt the user for access to their Address Book data
-(void)requestAddressBookAccess
{
    ViewController * __weak weakSelf = self;
    
    ABAddressBookRequestAccessWithCompletion(self.addressBook, ^(bool granted, CFErrorRef error)
                                             {
                                                 if (granted)
                                                 {
                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         
                                                     });
                                                 }
                                             });
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)reloadCheeseFunction
{
    NSArray *cheesyArray = @[@"Are you religious? Because you're the answer to all my prayers.", @"Do you have a Band-Aid? Because I just scraped my knee falling for you.", @"I'm not a photographer, but I can picture me and you together.",
                             @"I seem to have lost my phone number. Can I have yours?", @"You look cold. Want to use me as a blanket?"];
    uint32_t rnd = arc4random_uniform([cheesyArray count]);
    NSString *randomCheese = [cheesyArray objectAtIndex:rnd];
    
    
    cheesyLine.text = randomCheese;
    [cheesyLine setUserInteractionEnabled:NO];
    
    NSArray *callMeArray = @[@"Let me call you later?", @"Grab some coffee later?", @"Lets go out sometime?",
                             @"Its a date?", @"Me + You"];
    uint32_t callrnd = arc4random_uniform([callMeArray count]);
    NSString *callMe = [callMeArray objectAtIndex:callrnd];
    
    
    callLabel.text = callMe;
}
- (void)vibrate
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}


- (IBAction)noButtonClicked:(id)sender {
    [self reloadCheeseFunction];
    [self vibrate];
    imageArray = [[NSMutableArray alloc] initWithObjects:@"bg.jpg", @"london.jpeg", @"river.jpeg", @"wave.jpg", @"boat.jpg",@"plane.jpg", nil];
    uint32_t imagernd = arc4random_uniform([imageArray count]);
    NSString *randomImage = [imageArray objectAtIndex:imagernd];
    background.image = [UIImage imageNamed:randomImage];
    
    [UIView transitionWithView:background
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    

    [UIView transitionWithView:superView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:NULL
                    completion:NULL];




    

}
- (IBAction)yesButton:(id)sender {
    
    cheesyContainer.hidden = TRUE;
    contactView.hidden = false;
    btnCreateNewContact.hidden =true;
    yesButton.hidden=true;
    noButton.hidden=true;
    btnCreateNewContact.hidden =false;
    

    [UIView transitionWithView:superView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:NULL
                    completion:NULL];
    [UIView transitionWithView:background
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    backButton.hidden = false;


    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getContacts {
    APAddressBook *addressBook = [[APAddressBook alloc] init];
    // don't forget to show some activity
    [addressBook loadContacts:^(NSArray *contacts, NSError *error)
     {
         // hide activity
         if (!error)
         {
             contactArray = contacts;
        

             // do something with contacts array
             [contactsTableView reloadData];
             
         }
         else
         {
             // show error
         }
     }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [contactArray count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    
    }
    
    APContact *contact = [contactArray objectAtIndex:(indexPath.row)];
    cell.textLabel.text = contact.firstName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

@end
