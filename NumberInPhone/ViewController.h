//
//  ViewController.h
//  NumberInPhone
//
//  Created by Leo Mdivani on 27/09/2014.
//  Copyright (c) 2014 Dizzolve. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ViewController : UIViewController

@property (nonatomic, assign) ABAddressBookRef addressBook;
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *Number;
@property (weak, nonatomic) IBOutlet NSArray *cheesyArray;
@property (weak, nonatomic) IBOutlet UITextField *cheesyTextView;


@end
