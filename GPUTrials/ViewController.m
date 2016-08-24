//
//  ViewController.m
//  GPUTrials
//
//  Created by Ideas2IT-Pavithramouli on 24/08/16.
//  Copyright © 2016 Personal. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIImage *originalImage;
}
@end

@implementation ViewController
@synthesize selectedImageView, filterButton, saveButton;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)photoFromAlbum:(id)sender {
    
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:photoPicker animated:YES completion:NULL];
}


- (IBAction)photoFromCamera:(id)sender {
    
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:photoPicker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)photoPicker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.saveButton.enabled = YES;
    self.filterButton.enabled = YES;
    
    originalImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self.selectedImageView setImage:originalImage];
    
    [photoPicker dismissViewControllerAnimated:YES completion:nil];}

- (IBAction)applyImageFilter:(id)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"Select Filter" message:@"Choose a filter to apply to image" preferredStyle:UIAlertControllerStyleActionSheet];
    
    NSDictionary *filterPairing = [[NSDictionary alloc]
                                   initWithObjects:@[[GPUImageGrayscaleFilter class],
                                                     [GPUImageSepiaFilter class],
                                                     [GPUImageSketchFilter alloc],
                                                     [GPUImagePixellateFilter alloc],
                                                     [GPUImageColorInvertFilter alloc],
                                                     [GPUImageToonFilter alloc],
                                                     [GPUImagePinchDistortionFilter alloc],
                                                     [GPUImageFilter alloc]]
                                   forKeys:@[@"Grayscale", @"Sepia", @"Sketch", @"Pixellate", @"Color Invert", @"Toon", @"Pinch Distort", @"None"]];
    
    for (NSString*key in filterPairing.allKeys) {
        
        [actionSheet addAction:[UIAlertAction
                                actionWithTitle:key
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action) {
                                    GPUImageFilter *selectedFilter = [[[[filterPairing objectForKey:key] class]alloc] init];
                                    UIImage *filteredImage = [selectedFilter imageByFilteringImage:originalImage];
                                    [self.selectedImageView setImage:filteredImage];
                                    [self dismissViewControllerAnimated:YES completion:^{
                                    }];
        }]];
    }
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

- (IBAction)saveImageToAlbum:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.selectedImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *alertTitle;
    NSString *alertMessage;
    
    if(!error)
    {
        alertTitle   = @"Image Saved";
        alertMessage = @"Image saved to photo album successfully.";
    }
    else
    {
        alertTitle   = @"Error";
        alertMessage = @"Unable to save to photo album.";
    }
    
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleActionSheet];
    
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    [self presentViewController:actionSheet animated:YES completion:nil];

}
@end
