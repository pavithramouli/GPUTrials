//
//  ViewController.h
//  GPUTrials
//
//  Created by Ideas2IT-Pavithramouli on 24/08/16.
//  Copyright © 2016 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"

@interface ViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filterButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
- (IBAction)photoFromAlbum:(id)sender;
- (IBAction)photoFromCamera:(id)sender;
- (IBAction)applyImageFilter:(id)sender;
- (IBAction)saveImageToAlbum:(id)sender;

@end

