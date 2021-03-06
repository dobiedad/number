//
//  ViewController.m
//  NumberInPhone
//
//  Created by Leo Mdivani on 27/09/2014.
//  Copyright (c) 2014 Dizzolve. All rights reserved.
//

#import "ViewController.h"
#import "APContact.h"
@import LocalAuthentication;



@implementation ViewController{
    BOOL _clickedInfoButton;
    BOOL _clickedContactButton;

    
}



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
@synthesize currentContact;

@synthesize tableViewContainer;
@synthesize tableViewInsideContainer;
@synthesize youtubeWebView;
@synthesize youtubeWebViewContainer;
@synthesize infoButton;
@synthesize contactUsButton;
@synthesize tapImageView;

@synthesize footerButtonViewInside;
@synthesize clickMeButton;
@synthesize tapAnimationArray;



NSUInteger noButtonTapCount;
NSUInteger cheeseCountInteger;
NSUInteger callCountInteger;


NSTimer *timer;





















- (void)viewDidLoad
{
    [super viewDidLoad];
    [self paralax];
    
    contactView.hidden = true;
    btnCreateNewContact.hidden =true;
    [background setImage:[UIImage imageNamed:@"frankfurt.jpg"]];
    
    cheeseCountInteger=0;
    callCountInteger=0;
    [self hideForClickMe];
    [self animate];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [tapImageView setUserInteractionEnabled:YES];
    [tapImageView addGestureRecognizer:singleTap];
    
    
    
    
    
    addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    [self checkAddressBookAccess];
    [self getContacts];
    [self loadVideo];
    _clickedInfoButton = !_clickedInfoButton;
    _clickedContactButton = !_clickedContactButton;





    self.footerButtonView.dynamic = TRUE;
    self.footerButtonView.blurRadius = 15;
    self.cheesyContainer.dynamic = TRUE;
    self.contactView.dynamic = TRUE;
    self.cheesyContainer.blurRadius = 15;
    self.contactView.blurRadius = 15;
    self.Navbar.dynamic = TRUE;
    self.Navbar.blurRadius = 15;
    self.tableViewInsideContainer.dynamic = TRUE;
    self.tableViewInsideContainer.blurRadius = 15;
    self.tableViewContainer.dynamic = TRUE;
    self.tableViewContainer.blurRadius = 15;
    self.footerButtonViewInside.dynamic = TRUE;
    self.footerButtonViewInside.blurRadius = 15;
    backButton.hidden = true;
    self.tableViewContainer.hidden=true;
    youtubeWebViewContainer.hidden=true;
    contactUsButton.hidden=true;
    
    
    




   

}

- (void)resetAlert {
    timer = [NSTimer scheduledTimerWithTimeInterval:30.0 target:self selector:@selector(noButtonClicked:) userInfo:nil repeats:YES];
    [timer fire];
    
}

-(void)animate {
    // Load images
    NSArray *tapAnimationArray = @[@"tap2startSmall.png", @"tap2startBig.png"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i = 0; i < tapAnimationArray.count; i++) {
        [images addObject:[UIImage imageNamed:[tapAnimationArray objectAtIndex:i]]];
    }
    
    // Normal Animation
    UIImageView *animationImageView =tapImageView;
    animationImageView.animationImages = images;
    animationImageView.animationDuration = 0.5;
    
   
    [self.view addSubview:animationImageView];

    [animationImageView startAnimating];

}

- (IBAction)contactUsButton:(id)sender {
    NSString *mailString = [NSString stringWithFormat:@"mailto:info@limitless.xyz"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mailString]];
}

-(void)tapDetected{
    [self showForClickMe];
}


- (IBAction)infoButtonClicked:(id)sender {
    
    _clickedInfoButton = !_clickedInfoButton;

    if (!_clickedInfoButton) {
        youtubeWebViewContainer.hidden=false;
        contactButton.hidden=true;
        contactUsButton.hidden=false;
        
        
        [UIView transitionWithView:superView
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromTop
                        animations:NULL
                        completion:NULL];
        self.cheesyLine.text=@"This app was inspired by VitalyZDTV's 'put your number in my phone prank'";
        self.callLabel.text=@"developed by limitless";
        [UIView transitionWithView:callLabel
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:NULL
                        completion:NULL];
        [UIView transitionWithView:cheesyLine
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:NULL
                        completion:NULL];
        self.noButton.hidden = true;
        self.yesButton.hidden=true;
        [UIView transitionWithView:noButton
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:NULL
                        completion:NULL];
        [UIView transitionWithView:yesButton
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:NULL
                        completion:NULL];
    }
    else if (_clickedInfoButton) {
        youtubeWebViewContainer.hidden=true;
        contactButton.hidden=false;
        yesButton.hidden=false;
        noButton.hidden=false;
        contactUsButton.hidden=true;
        [self reloadCheeseFunction];

    

        
        [UIView transitionWithView:superView
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromTop
                        animations:NULL
                        completion:NULL];
        [UIView transitionWithView:callLabel
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:NULL
                        completion:NULL];
        [UIView transitionWithView:cheesyLine
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:NULL
                        completion:NULL];
        [UIView transitionWithView:noButton
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:NULL
                        completion:NULL];
        [UIView transitionWithView:yesButton
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:NULL
                        completion:NULL];
      
    }
    
   

    
}



- (IBAction)contactButtonClicked:(id)sender {

    
    [self displayContacts];


    
}

- (IBAction)clickMeButtonClicked:(id)sender {
    [self showForClickMe];
    
}
- (void)hideForClickMe{
    cheesyContainer.hidden=true;
    clickMeButton.hidden=false;
    tapImageView.hidden=false;
    yesButton.hidden=true;
    noButton.hidden=true;

    
    [UIView transitionWithView:superView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:NULL
                    completion:NULL];

    

    
}
- (void)showForClickMe{
    footerButtonView.hidden=false;
    cheesyContainer.hidden=false;
    clickMeButton.hidden=true;
    [self reloadCheeseFunction];
    cheesyContainer.hidden=false;
    callLabel.hidden=false;
    cheesyLine.hidden=false;
    yesButton.hidden=false;
    noButton.hidden=false;
    tapImageView.hidden=true;
    
    imageArray = [[NSMutableArray alloc] initWithObjects:@"italy.jpg",  @"nightfall.jpg", @"colour.jpg",@"star.jpg",@"building.jpg",@"empireState.jpg", @"fog.jpg", @"frankfurt.jpg", @"hotbaloon.jpg",@"nycsun.jpg",@"paris.jpg",@"rain.jpg",@"rocky.jpg",@"sidewalk.jpg",@"snowmountain.jpg",@"weed.jpg", nil];
    uint32_t imagernd = arc4random_uniform([imageArray count]);
    NSString *randomImage = [imageArray objectAtIndex:imagernd];
    background.image = [UIImage imageNamed:randomImage];
    NSLog(@"%@",randomImage);


    
    [UIView transitionWithView:superView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromTop
                    animations:NULL
                    completion:NULL];
   
    
    
}
- (void) displayContacts {
    
    
    _clickedContactButton = !_clickedContactButton;
    
    if (!_clickedContactButton) {
        self.tableViewContainer.hidden=false;
        tableViewInsideContainer.hidden=false;
        self.noButton.hidden = true;
        self.yesButton.hidden=true;
        self.infoButton.hidden=true;
        contactUsButton.hidden=false;
        
        
        callLabel.text=@"developed by limitless";
        cheesyLine.text=@"Contacts saved with Number?";
        
        [UIView transitionWithView:tableViewContainer
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCurlDown
                        animations:NULL
                        completion:NULL];
        [UIView transitionWithView:callLabel
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:NULL
                        completion:NULL];
        [UIView transitionWithView:infoButton
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:NULL
                        completion:NULL];
        [UIView transitionWithView:cheesyLine
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:NULL
                        completion:NULL];
        [UIView transitionWithView:noButton
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:NULL
                        completion:NULL];
        [UIView transitionWithView:yesButton
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:NULL
                        completion:NULL];
        
        
    }
    else if (_clickedContactButton){
        self.tableViewContainer.hidden=true;
        tableViewInsideContainer.hidden=true;
        self.infoButton.hidden=false;
        contactUsButton.hidden=true;

        
        
        yesButton.hidden=false;
        noButton.hidden=false;
        [self reloadCheeseFunction];
        
        
        
        [UIView transitionWithView:tableViewContainer
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCurlUp
                        animations:NULL
                        completion:NULL];
        [UIView transitionWithView:callLabel
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:NULL
                        completion:NULL];
        [UIView transitionWithView:cheesyLine
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:NULL
                        completion:NULL];
        [UIView transitionWithView:infoButton
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:NULL
                        completion:NULL];
        
        [UIView transitionWithView:noButton
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:NULL
                        completion:NULL];
        [UIView transitionWithView:yesButton
                          duration:0.5
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:NULL
                        completion:NULL];
        
        
    }
    
}



- (IBAction)backButtonClicked:(id)sender {
    contactView.hidden = true;
    cheesyContainer.hidden = false;
    contactButton.hidden=false;
    infoButton.hidden=false;

    
    [UIView transitionWithView:superView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    animations:NULL
                    completion:NULL];
    yesButton.hidden= false;
    noButton.hidden= false;
    btnCreateNewContact.hidden = true ;
    backButton.hidden = true;

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
    NSString *Note = @"Number?";


    
    if (Name.length > 2 && Number.length > 6 ) {
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
        ABRecordRef new = ABPersonCreate();
        ABRecordSetValue(new, kABPersonFirstNameProperty, (__bridge CFStringRef)Name, nil);
        ABRecordSetValue(new, kABPersonNoteProperty, (__bridge CFStringRef)Note, nil);

        
        
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
        [self hideForClickMe];

        
        [contactAddedAlert show];
        self.Name.text=@"";
        self.Number.text=@"";
        cheesyContainer.hidden=true;
        contactView.hidden=true;
        callLabel.hidden=true;
        cheesyLine.hidden=true;
        
        [UIView transitionWithView:superView
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromTop
                        animations:NULL
                        completion:NULL];
        btnCreateNewContact.hidden=true;
    

        backButton.hidden=true;
        infoButton.hidden=false;
        contactButton.hidden=false;
        [UIView transitionWithView:noButton
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromTop
                        animations:NULL
                        completion:NULL];
        [UIView transitionWithView:yesButton
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromTop
                        animations:NULL
                        completion:NULL];


    }
    else {
        UIAlertView *emptyAlert = [[UIAlertView alloc]initWithTitle:@"Those details are not valid. Please try again" message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
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
    NSMutableArray *cheesyArray = [NSMutableArray arrayWithArray: @[@"Are you religious? Because you're the answer to all my prayers.", @"Do you have a Band-Aid? Because I just scraped my knee falling for you.", @"I'm not a photographer, but I can picture me and you together.",
                             @"I seem to have lost my phone number. Can I have yours?", @"You look cold. Want to use me as a blanket?",@"I thought happiness started with an H. Why does mine start with U?", @"Does your left eye hurt? Because you've been looking right all day.", @"What time do you have to be back in heaven?",
                             @"You're so hot, I want to bake cookies on you.",@"Hi, I’m Mr. Right. Someone said you were looking for me",@"Do you believe in love at first sight or do I need to walk by again?",@"If I said you had a great body, would you hold it against me?", @" Do you have the time. . . to write your number down?",@"Screw me if I am wrong, but haven’t we met before?",@"I didn't know angels could fly so low.", @"The only thing your eyes haven't told me is your name."]];
    
    NSUInteger cheesyCount = [cheesyArray count];
    
    
    for (NSUInteger i = 0; i < cheesyCount; ++i) {
        NSUInteger nElements = cheesyCount - i;
        NSUInteger n = (arc4random() % nElements) + i;
        [cheesyArray exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    NSString *cheesyLineIndexed = [cheesyArray objectAtIndex:cheeseCountInteger];
    
    
    
    cheesyLine.text = cheesyLineIndexed;
    [cheesyLine setUserInteractionEnabled:NO];
    
    NSMutableArray *callMeArray = [NSMutableArray arrayWithArray: @[@"Meet up later?", @"Grab some coffee later?", @"Lets go out sometime?",
                                                                    @"Its a date?", @"Me + You ?", @"See you soon?", @"Lets grab a drink sometime?",@"Lets grab a bite sometime?"]];
    
    NSUInteger callMeCount = [callMeArray count];
    for (NSUInteger i = 0; i < callMeCount; ++i) {
        NSUInteger nElements = callMeCount - i;
        NSUInteger n = (arc4random() % nElements) + i;
        [callMeArray exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    NSString *callMeIndexed = [callMeArray objectAtIndex:callCountInteger];
    
    
    callLabel.text = callMeIndexed;
    cheeseCountInteger++;
    callCountInteger++;

    
    if (cheeseCountInteger == cheesyCount) {
        cheeseCountInteger = 0;
    }
    if (callCountInteger == callMeCount) {
        callCountInteger = 0;
    };
}
- (void)vibrate
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}


- (IBAction)noButtonClicked:(id)sender {
    [self reloadCheeseFunction];
    [self vibrate];
    imageArray = [[NSMutableArray alloc] initWithObjects:@"italy.jpg",  @"nightfall.jpg", @"colour.jpg",@"star.jpg",@"building.jpg",@"empireState.jpg", @"fog.jpg", @"frankfurt.jpg", @"hotbaloon.jpg",@"nycsun.jpg",@"paris.jpg",@"rain.jpg",@"rocky.jpg",@"sidewalk.jpg",@"snowmountain.jpg",@"weed.jpg", nil];
    uint32_t imagernd = arc4random_uniform([imageArray count]);
    NSString *randomImage = [imageArray objectAtIndex:imagernd];
    background.image = [UIImage imageNamed:randomImage];
    NSLog(@"%@",randomImage);

    
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
    noButtonTapCount++;
    if (noButtonTapCount == 3)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Play Nice!"
                                                        message:@"You need to tap the green button"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [UIView transitionWithView:alert
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:NULL
                        completion:NULL];
        [alert show];
        noButtonTapCount = 0; // Not sure if you want to reset to 0 here.
    }



    

}
- (IBAction)yesButton:(id)sender {

    contactView.hidden = false;
    btnCreateNewContact.hidden =true;
    yesButton.hidden=true;
    noButton.hidden=true;
    btnCreateNewContact.hidden =false;
    contactButton.hidden=true;
    infoButton.hidden=true;
    cheesyLine.text=@"What you waiting for?";
    callLabel.text=@"Put your number in my phone....";
    

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
    APAddressBook *ab = [[APAddressBook alloc] init];
    ab.fieldsMask = APContactFieldAll;
    
    // don't forget to show some activity
    ab.filterBlock = ^BOOL(APContact *contact)
    {
        NSLog(@"%@", contact.note);
        return  [contact.note isEqual: @"Number?"];
    };
    

    [ab loadContacts:^(NSArray *contacts, NSError *error)
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
    UIButton *createSMSButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    createSMSButton.frame = CGRectMake(320.0f, 5.0f, 30.0f, 30.0f);
    UIImage *message = [UIImage imageNamed:@"chat.png"];
    [createSMSButton setImage:message forState:UIControlStateNormal];
    [cell addSubview:createSMSButton];
    currentContact=contact;
    
    [createSMSButton addTarget:self
                        action:@selector(sendInAppSMS:)
       forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(IBAction) sendInAppSMS:(id) sender
{
     _messageComposer = [MFMessageComposeViewController new] ;
    
    if([MFMessageComposeViewController canSendText])
    {
        _messageComposer.body = @"";
        _messageComposer.recipients = currentContact.phones;
        _messageComposer.messageComposeDelegate = self;
        [self presentViewController:_messageComposer animated:YES completion:nil];

    }
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"Cancelled");
            break;
            default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


}
- (void)loadVideo{
 
    [self.youtubeWebView setAllowsInlineMediaPlayback:YES];
    [self.youtubeWebView setMediaPlaybackRequiresUserAction:NO];
    
    
    NSString* embedHTML = [NSString stringWithFormat:@"\
                           <html>\
                           <body style='margin:0px;padding:0px;'>\
                           <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
                           <script type='text/javascript'>\
                           function onYouTubeIframeAPIReady()\
                           {\
                           ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
                           }\
                           function onPlayerReady(a)\
                           { \
                           a.target.playVideo(); \
                           }\
                           </script>\
                           <iframe id='playerId' type='text/html' width='375' height='400' src='http://www.youtube.com/embed/ksnCqh9DDB8?list=UU1KPy3cAAj0i0RIFC_SzjMg' frameborder='0'>\
                           </body>\
                           </html>"];
    [self.youtubeWebView loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle]resourceURL]];
}
- (void)playSound :(NSString *)fName :(NSString *) ext{
    SystemSoundID audioEffect;
    NSString *path = [[NSBundle mainBundle] pathForResource : fName ofType :ext];
    if ([[NSFileManager defaultManager] fileExistsAtPath : path]) {
        NSURL *pathURL = [NSURL fileURLWithPath: path];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
        AudioServicesPlaySystemSound(audioEffect);
    }
    else {
        NSLog(@"error, file not found: %@", path);
    }
}

@end
