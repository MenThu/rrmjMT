//
//  FileManager.m
//  FileManager
//
//  Created by MenThu on 16/8/11.
//  Copyright © 2016年 官辉. All rights reserved.
//

#import "FileManager.h"
#import "MyLog.h"


NSString const* VoiceDocumentName = @"/Voice/";

@interface FileManager ()


@property (nonatomic, strong) NSFileManager* myFileManager;
@property (nonatomic, copy) NSString* sanboxPath;
@property (nonatomic, copy) NSString* testPath;

@end

@implementation FileManager

kSingletonM

- (instancetype)init
{
    if (self = [super init]) {
        self.myFileManager = [NSFileManager defaultManager];
        self.sanboxPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:(NSString *)VoiceDocumentName];
        MyLog(@"沙盒 : %@",self.sanboxPath);
        NSError *error = nil;
        if (![self.myFileManager fileExistsAtPath:self.sanboxPath]) {
            [self.myFileManager createDirectoryAtPath:self.sanboxPath withIntermediateDirectories:YES attributes:nil error:&error];
        }
        NSAssert(error==nil, @"%@",error);
    }
    return self;
}

- (BOOL)isFileExist:(NSString *)fileName
{
//    return [self.myFileManager fileExistsAtPath:fileName];
    return [self.myFileManager fileExistsAtPath:[self.sanboxPath stringByAppendingString:fileName]];
}


- (BOOL)createFile:(NSString *)fileName
{
    if ([self isFileExist:fileName]) {
        return YES;
    }

    NSArray *pathArray = [fileName componentsSeparatedByString:@"/"];
    if (pathArray.count > 1) {
        //包含路径 先创建目录
        NSMutableString *pathString = [NSMutableString stringWithFormat:@"%@", self.sanboxPath];
        for (NSInteger index=0; index < pathArray.count-1; index++) {
            [pathString appendFormat:@"%@/",pathArray[index]];
        }
        NSLog(@"待创建的文件路径 : %@", pathString);
        NSError *error;
        if (![self.myFileManager createDirectoryAtPath:pathString withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"创建目录失败 : %@", error);
            return NO;
        }
    }
    return [self.myFileManager createFileAtPath:[self.sanboxPath stringByAppendingString:fileName] contents:nil attributes:nil];
}


- (BOOL)deleteFileWithHead:(NSString *)fileHead
{
    NSError *error = nil;
    NSArray* fileNameArray = [self.myFileManager contentsOfDirectoryAtPath:self.sanboxPath error:&error];
    if (error) {
        NSLog(@"读取目录失败 : %@", error);
        return NO;
    }else{
        for (NSString* fileName in fileNameArray) {
            if ([fileName hasPrefix:fileHead]) {
                error = nil;
                [self.myFileManager removeItemAtPath:[self.sanboxPath stringByAppendingString:fileName] error:&error];
                if (error) {
                    NSLog(@"删除[%@]出错[%@]", self.sanboxPath, error);
                    return NO;
                }
            }
        }
    }
    return YES;
}

- (BOOL)deleteDir:(NSString *)dirPath
{
    NSError *deleteErr = nil;
    [self.myFileManager removeItemAtPath:[self.sanboxPath stringByAppendingString:dirPath] error:&deleteErr];
    if (deleteErr) {
        NSLog(@"删除目录错误:[%@]", deleteErr);
        return NO;
    }
    return YES;
}


- (BOOL)writeToFile:(NSString *)fileName WithContent:(id)content
{
    if ([self createFile:fileName]) {
        NSString *filePath = [self.sanboxPath stringByAppendingString:fileName];

        if ([content isKindOfClass:[NSData class]]) {
            NSData *data = content;
            return [data writeToFile:filePath atomically:YES];
        }else if ([content isKindOfClass:[NSDictionary class]]){
            NSDictionary *dict = content;
            return [dict writeToFile:filePath atomically:YES];
        }else if ([content isKindOfClass:[NSString class]]){
            NSString *str = content;
            NSError *err = nil;
            [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&err];
            if (err) {
                MyLog(@"%@",err);
                return NO;
            }
            return YES;
        }
        MyLog(@"content 类型不正确");
        return NO;
    }else{
        MyLog(@"创建文件失败");
        return NO;
    }
}

- (BOOL)appendDataToFile:(NSString *)fileName WithContent:(id)content
{
    if (![self isFileExist:fileName]) {
        [self createFile:fileName];
    }
    
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:[self.sanboxPath stringByAppendingString:fileName]];
    if (fileHandle == nil) {
        MyLog(@"fileHandle 为空");
        return NO;
    }
    [fileHandle seekToEndOfFile];
    
    NSData *appendData = nil;
    if ([content isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = content;
        appendData =    [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
//        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        appendData = [dict ]
    }else if([content isKindOfClass:[NSString class]]){
        NSString *str = content;
        appendData = [str dataUsingEncoding:NSUTF8StringEncoding];
    }else if ([content isKindOfClass:[NSData class]]){
        appendData = content;
    }
    
    if (appendData == nil) {
        MyLog(@"content的类型异常");
        return NO;
    }
    
    [fileHandle writeData:appendData];
    return YES;
}

- (NSString *)priMyPath
{
    return [NSString stringWithFormat:@"%@",self.sanboxPath];
}

@end
