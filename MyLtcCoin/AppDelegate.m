//
//  AppDelegate.m
//  MyLtcCoin
/*
Using AFNetworking (3.1.0)
Using CYLTabBarController (1.13.1)
Using JKCategories (1.5)
Using JSONModel (1.7.0)
Using Masonry (1.0.2)
Using RTRootNavigationController (0.5.26)
Using SDWebImage (4.0.0)
 */
//  Created by 川何 on 2017/6/26.
//  Copyright © 2017年 hechuan. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "NewsViewController.h"
#import "CoinViewController.h"
#import "MeViewController.h"
#import "CYLTabBarController.h"
#import "RTRootNavigationController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self makeApp];
    return YES;
}

-(void)makeApp{
    HomeViewController *firstViewController = [[HomeViewController alloc] init];
    UIViewController *firstNavigationController = [[RTRootNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    NewsViewController *secondViewController = [[NewsViewController alloc] init];
    UIViewController *secondNavigationController = [[RTRootNavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    CoinViewController *threeViewController = [[CoinViewController alloc] init];
    UIViewController *threNavigationeViewController = [[RTRootNavigationController alloc]
                                                    initWithRootViewController:threeViewController];
    
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    [self customizeTabBarForController:tabBarController];
    
    [tabBarController setViewControllers:@[
                                           firstNavigationController,
                                           secondNavigationController,
                                           threNavigationeViewController,
                                           ]];
    [self.window setRootViewController:tabBarController];
    [self.window makeKeyAndVisible];

//    self.tabBarController = tabBarController;
}

/*
在`-setViewControllers:`之前设置TabBar的属性，
*
*/
- (void)customizeTabBarForController:(CYLTabBarController *)tabBarController {
    
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"K线",
                            CYLTabBarItemImage : @"waffle",
                            CYLTabBarItemSelectedImage : @"waffle",
                            };
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"买卖",
                            CYLTabBarItemImage : @"measuring",
                            CYLTabBarItemSelectedImage : @"measuring",
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"成交",
                            CYLTabBarItemImage : @"bread",
                            CYLTabBarItemSelectedImage : @"bread",
                            };

    
    NSArray *tabBarItemsAttributes = @[ dict1, dict2 ,dict3];
    tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
