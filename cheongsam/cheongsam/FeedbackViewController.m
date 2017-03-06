//
//  FeedbackViewController.m
//  FootMassage
//
//  Created by Admin on 16/4/22.
//  Copyright © 2016年 Admin. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UITextViewDelegate>
{
    UITextView *contenText;
    UIButton *submitBtn;
    UIView *contenView;
    UILabel *wordCount;
}
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    contenView = [[UIView alloc]init];
    contenView.backgroundColor = [UIColor getColor:@"E5E5E5"];
    [self.view addSubview:contenView];
    
    contenText = [[UITextView alloc]init];
    contenText.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    contenText.layer.borderWidth = 1;
    contenText.layer.borderColor = [UIColor lightGrayColor].CGColor;
    contenText.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [contenText setScrollEnabled:YES];
    contenText.userInteractionEnabled = YES;
    contenText.showsVerticalScrollIndicator = YES;
    contenText.font = [UIFont systemFontOfSize:15];
    CGSize size = CGSizeMake(kScreenWidth, 100.0f);
    [contenText setContentSize:size];
    [contenView addSubview:contenText];
    
    wordCount = [UILabel sharedWithFont:12 andColor:[UIColor blackColor] andAnligment:center andBackgroundColor:nil];
    [contenView addSubview:wordCount];
    
    
    self.navigationItem.rightBarButtonItem = [self rightButton];
    
    contenView.sd_layout
    .topSpaceToView(self.view,0)
    .widthIs(kScreenWidth)
    .heightIs(kScreenHeight/2);
    
    contenText.sd_layout
    .topSpaceToView(contenView,25)
    .leftSpaceToView(contenView,10)
    .rightSpaceToView(contenView,10)
    .bottomSpaceToView(contenView,10);
    
    wordCount.sd_layout
    .topSpaceToView(contenView,0)
    .centerXEqualToView(contenView)
    .widthIs(kScreenWidth).heightIs(25);
   
}
- (UIBarButtonItem *)rightButton
{
    CGRect buttonFrame = CGRectMake(0, 0,35, 35);
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button addTarget:self action:@selector(submitBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    return item;
}
- (void)submitBtnPress
{
    if(contenText.text.length==0||contenText.text==nil){

    }else{
        SHOWHUD
       
    }
    
    
    
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if(range.location > 60){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"输入的自字符数不能超过60"
                                                       delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        
        return NO;
    }else{
        NSLog(@"%lu",(unsigned long)contenText.text.length);
        return YES;
    }
}


- (void)textViewDidChange:(UITextView *)textView{
    int count;
    count = 60.0 - contenText.text.length;
    [wordCount setText:[NSString stringWithFormat:@"剩余输入%d字", count]];  //_wordCount是一个显示剩余可输入数字的label
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    [UIMenuController sharedMenuController].menuVisible = NO;  //donot display the menu
    [contenText resignFirstResponder];                     //do not allow the user to selected anything
    return NO;
    
}









































- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
