//
//  UTONBaseHttpRequest.m
//  UTON智能云
//
//  Created by mac on 2021/3/10.
//

#import "UTONBaseHttpRequest.h"

@interface UTONBaseHttpRequest ()<NSURLSessionDelegate>

@end

@implementation UTONBaseHttpRequest

+ (UTONBaseHttpRequest *)sharedInstance {
    static UTONBaseHttpRequest *_httpRequest;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _httpRequest = [[UTONBaseHttpRequest alloc]init];
        
    });
    
    return _httpRequest;
}

- (void)UTONForRequestWithUrl:(NSString *)urlStr HttpRequestBody:(NSString *)bodyStr HttpHeader:(NSDictionary *_Nullable)headerDic completionHandler:(void (^)(NSDictionary * _Nullable, BOOL, NSString * _Nonnull))callBack{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[bodyStr dataUsingEncoding:NSUTF8StringEncoding]];
    NSString *uidStr = [NSString stringWithFormat:@"%@",headerDic[@"User-Uid"]];
    if (headerDic) {
        [request setValue:uidStr forHTTPHeaderField:@"User-Uid"];
        [request setValue:headerDic[@"User-Token"] forHTTPHeaderField:@"User-Token"];
    }
    [request setTimeoutInterval:45.0f];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error==nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSString *codeStr = [NSString stringWithFormat:@"%@",[dict valueForKey:@"code"]];
            if ([codeStr isEqualToString:@"10000"]) {
                
            }
            if (callBack) {
                callBack(dict,YES,@"请求成功");
            }
        }else{
            if (callBack) {
                callBack(nil,NO,@"请求失败");
            }
        }
    }];
    [dataTask resume];
}

- (void)UTONForRequestWithBiaodanUrl:(NSString *)urlStr HttpRequestBody:(NSString *)bodyStr filePath:(NSString *)filePath HttpHeader:(NSDictionary *_Nullable)headerDic completionHandler:(void (^)(NSDictionary * _Nullable, BOOL, NSString * _Nonnull))callBack{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"multipart/form-data; boundary=whoislcj" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:[self getHTTPBodyWithServerBiaodanFileName:bodyStr filePath:filePath]];
    NSString *uidStr = [NSString stringWithFormat:@"%@",headerDic[@"User-Uid"]];
    if (headerDic) {
        [request setValue:uidStr forHTTPHeaderField:@"User-Uid"];
        [request setValue:headerDic[@"User-Token"] forHTTPHeaderField:@"User-Token"];
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session uploadTaskWithRequest:request fromData:[self getHTTPBodyWithServerBiaodanFileName:bodyStr filePath:filePath] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error==nil) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSString *codeStr = [NSString stringWithFormat:@"%@",[dict valueForKey:@"code"]];
            if ([codeStr isEqualToString:@"10000"]) {
                
            }
            if (callBack) {
                callBack(dict,YES,@"请求成功");
            }
        }
    }];
    [dataTask resume];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend{
    float process = totalBytesSent * 1.0 / totalBytesExpectedToSend;
    NSLog(@"上传进度%f", process);
    if ([self.delegate respondsToSelector:@selector(uploadFileProcess:)]) {
        [self.delegate uploadFileProcess:process];
    }
    NSString *processStr = [NSString stringWithFormat:@"%f",process];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"uploadFileSpeed" object:processStr];
}

/* 文件上传**/
- (void)utonAddLoadFileWithFileArg:(NSString *)filePath completionHandler:(void (^)(NSDictionary * _Nullable, BOOL, NSString * _Nonnull))callBack{
    BOOL isDirectory = YES;
    BOOL isExist = (filePath.length != 0 ? [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory] : NO);//?
    if(!isExist){
        NSLog(@"要上传的文件不存在");
        return;
    }
    NSString *ipStr = [CloudMerchantMonitorUtil getRequestHttpApi];
    // 参数1
    NSString *URLString = [NSString stringWithFormat:@"%@%@",ipStr,kFileUpdte];
    // 参数2
    NSString *serverFileName = @"arg";
    // 调用文件上传主方法
    // URL
    NSURL *URL= [NSURL URLWithString:URLString];

    // 可变请求
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:URL];
    // 设置请求头信息
    [requestM setValue:@"multipart/form-data; boundary=itcast" forHTTPHeaderField:@"Content-Type"];
    // 设置请求方法
    requestM.HTTPMethod = @"POST";
    // 设置请求
    requestM.HTTPBody = [self getHTTPBodyWithServerFileName:serverFileName filePath:filePath];

    // 发送请求实现图片上传
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:0];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:requestM completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 处理响应
        if (error == nil && data != nil) {
            // 反序列化
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"上传文件返回的数据%@",result);
            if (callBack) {
                callBack(result,YES,@"请求成功");
            }
        } else {
            NSLog(@"%@",error);
        }

    }];
    [dataTask resume];
}

/**
 *  获取请求体信息
 *
 *  @param serverFileName 服务器接收文件的字段名
 *  @param filePath       文件路径
 *
 *  @return 返回请求体二进制信息
 */
- (NSData *)getHTTPBodyWithServerFileName:(NSString *)serverFileName filePath:(NSString *)filePath
{
    // 定义dataM,拼接请求体的二进制信息
    NSMutableData *dataM = [NSMutableData data];

    // 拼接文件二进制前面的字符串
    NSMutableString *stringM = [NSMutableString string];

    // 拼接文件开始的分隔符
    [stringM appendString:@"--itcast\r\n"];
    // 拼接表单数据
    [stringM appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n",serverFileName,[filePath lastPathComponent]];
    // 拼接文件类型
    NSString *mimetype  = [self mimeTypeForPath:filePath];
    [stringM appendString:[NSString stringWithFormat:@"Content-Type: %@\r\n", mimetype]];
    // 拼接单纯的换行
    [stringM appendString:@"\r\n"];
    // 把这部分的字符串转成二进制,拼接到dataM里面
    [dataM appendData:[stringM dataUsingEncoding:NSUTF8StringEncoding]];

    // 拼接文件的二进制数据
    [dataM appendData:[NSData dataWithContentsOfFile:filePath]];

    // 拼接文件结束的分隔符
    NSString *end = @"\r\n--itcast--";
    [dataM appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];

    return dataM.copy;
}

- (NSData *)getHTTPBodyWithServerBiaodanFileName:(NSString *)serverFileName filePath:(NSString *)filePath
{
    // 定义dataM,拼接请求体的二进制信息
    NSMutableData *dataM = [NSMutableData data];

    // 拼接文件二进制前面的字符串
    NSMutableString *stringM = [NSMutableString string];
//    NSString *BOUNDARY = @"whoislcj";
    // 拼接文件开始的分隔符
    [stringM appendString:@"--whoislcj\r\n"];
    // 拼接表单数据
//    filePath = [NSString stringWithFormat:@"\\%@",filePath];
    [stringM appendFormat:@"Content-Disposition: form-data; name=%@\r\n%@",serverFileName,filePath,nil];
    // 拼接文件类型
//    NSString *mimetype  = [self mimeTypeForPath:filePath];
//    [stringM appendString:[NSString stringWithFormat:@"Content-Type: %@\r\n", mimetype]];
    // 拼接单纯的换行
    [stringM appendString:@"\r\n"];
    // 把这部分的字符串转成二进制,拼接到dataM里面
    [dataM appendData:[stringM dataUsingEncoding:NSUTF8StringEncoding]];

    // 拼接文件的二进制数据
//    [dataM appendData:[NSData dataWithContentsOfFile:filePath]];

    // 拼接文件结束的分隔符
    NSString *end = @"\r\n--whoislcj--";
    [dataM appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];

    return dataM.copy;
}

// 获取MIMEType
- (NSString *)mimeTypeForPath:(NSString *)path {
    // get a mime type for an extension using MobileCoreServices.framework
    CFStringRef extension = (__bridge CFStringRef)[path pathExtension];
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, extension, NULL);
    assert(UTI != NULL);
    NSString *mimetype = CFBridgingRelease(UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType));
    assert(mimetype != NULL);
    CFRelease(UTI);
    return mimetype;
}

@end
