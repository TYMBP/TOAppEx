//
//  WebViewController.m
//  TOAppEx
//
//  Created by TomohikoYamada on 13/05/24.
//  Copyright (c) 2013年 jp.main.yamato. All rights reserved.
//

#import "WebViewController.h"
#import "WebSearchController.h"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize wv = _wv;
@synthesize encode_word;

- (void)dealloc {
  [_wv                release]; _wv.delegate = nil;
  [_activityIndicator release];
  [_reloadButton      release];
  [_backButton        release];
  [_fowardButton      release];
  
  [super dealloc];
}

- (void)viewDidLoad {

  [super viewDidLoad];
  
  // WebView
  _wv = [[UIWebView alloc] init];
  _wv.delegate = self;
  _wv.frame = self.view.bounds;
  _wv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  _wv.scalesPageToFit = YES;
  [self.view addSubview:_wv];

  // ツールバー
  UIToolbar *tb = [[UIToolbar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 44, 320, 44)];
  [self.view addSubview:tb];
  _reloadButton = [[UIBarButtonItem alloc] initWithTitle:@"reload" style:UIBarButtonItemStyleBordered target:self action:@selector(reloadDidPush)];
  _backButton   = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleBordered target:self action:@selector(backDidPush)];
  _fowardButton = [[UIBarButtonItem alloc] initWithTitle:@"foward" style:UIBarButtonItemStyleBordered target:self action:@selector(fowardDidPush)];
  _homeButton   = [[UIBarButtonItem alloc] initWithTitle:@"home" style:UIBarButtonItemStyleBordered target:self action:@selector(tohome:)];
  
  NSArray *buttons = [NSArray arrayWithObjects:_backButton, _fowardButton, _reloadButton, _homeButton, nil];
  tb.items = buttons;
  
  NSString *urlStr = [[[NSString alloc] initWithFormat:@"http://www.google.co.jp/search?q=%@", encode_word] autorelease];
  NSURL *url = [NSURL URLWithString:urlStr];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  [_wv loadRequest:request];

}

- (void)viewDidUnload {
  
  [self setWv:nil];
  
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  
  return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)tohome:(id)sender {
  WebSearchController *dialog = [[WebSearchController alloc] init];
  dialog.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
  [self presentViewController:dialog animated:YES completion:NULL];
}

- (void)reloadDidPush {
  [_wv reload];
}

- (void)backDidPush {
  [_wv goBack];
}

- (void)fowardDidPush {
  [_wv goForward];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
