//
// Created by yet on 2018/8/20.
// Copyright (c) 2018 thenextmediagroup.com. All rights reserved.
//

#import <HealthKit/HealthKit.h>
#import "Http.h"
#import "Common.h"
#import "NSData+myextend.h"
#import "Async.h"

static int GET = 0;
static int POST = 1;
static int POST_MULTIPART = 2;
static int POST_RAW = 3;


static void progStart(id <HttpProgress> p, int total) {
	if ([p respondsToSelector:@selector(onHttpStart:)]) {
		[p onHttpStart:total];
	}
}

static void progFinish(id <HttpProgress> p, BOOL success) {
	if ([p respondsToSelector:@selector(onHttpFinish:)]) {
		[p onHttpFinish:success];
	}
}

static void progProgress(id <HttpProgress> p, int current, int total, int percent) {
	if ([p respondsToSelector:@selector(onHttpProgress:total:percent:)]) {
		[p onHttpProgress:current total:total percent:percent];
	}
}

@implementation Http {
	NSMutableDictionary *argMap;
	NSMutableDictionary *headerMap;
	NSMutableDictionary *fileMap;
	NSMutableDictionary *fileDataMap;

	NSURLSession *session;
	NSData *rawData;

	NSString *CRLF;
	NSString *BOUNDARY;
	NSString *BOUNDARY_START;
	NSString *BOUNDARY_END;

	BOOL sendStart;
	BOOL recvStart;

}

- (instancetype)init {
	self = [super init];
	sendStart = NO;
	recvStart = NO;

	argMap = [NSMutableDictionary new];
	headerMap = [NSMutableDictionary new];
	fileMap = [NSMutableDictionary new];
	fileDataMap = [NSMutableDictionary new];
	rawData = nil;
	session = [NSURLSession sharedSession];
	self.timeout = 15;
	CRLF = @"\r\n";
	BOUNDARY = [NSUUID UUID].UUIDString;
	BOUNDARY_START = [[@"--" add:BOUNDARY] add:CRLF];
	BOUNDARY_END = [[[@"--" add:BOUNDARY] add:@"--"] add:CRLF];

	[self accept:@"*/*"];
	[self header:@"Accept-Charset" value:@"UTF-8,*"];
	[self header:@"Accept-Language" value:@"zh-CN,en-US,*"];
	[self header:@"Accept-Encoding" value:@"identity"];
	[self header:@"Connection" value:@"close"];
	[self userAgent:@"dentist/1 Mozilla/5.0"];
	return self;
}

- (void)contentTypeJson {
	[self contentType:@"application/json"];
}

- (void)contentType:(NSString *)value {
	[self header:@"Content-Type" value:value];
}

- (void)auth:(NSString *)user value:(NSString *)pwd {
	NSString *s = [[user add:@":"] add:pwd];
	NSString *ss = [s.dataUTF8 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
	NSString *sss = @"Basic ";
	[self header:@"Authorization" value:[sss add:ss]];
}

- (void)userAgent:(NSString *)value {
	[self header:@"User-Agent" value:value];
}


- (void)acceptJson {
	[self accept:@"application/json"];
}

- (void)acceptHtml {
	[self accept:@"text/html"];
}

- (void)accept:(NSString *)value {
	[self header:@"Accept" value:value];
}

- (void)arg:(NSString *)name value:(NSString *)value {
	argMap[name] = value;
}

- (void)args:(NSDictionary *)dic {
	for (NSString *k in dic) {
		id v = dic[k];
		NSString *value = [NSString stringWithFormat:@"%@", v];
		[self arg:k value:value];

	}
}

- (void)header:(NSString *)name value:(NSString *)value {
	headerMap[name] = value;
}

- (void)file:(NSString *)name value:(NSString *)value {
	fileMap[name] = value;
}

- (void)fileData:(NSString *)name value:(NSData *)value {
	fileDataMap[name] = value;
}

- (HttpResult *)get {
	[headerMap removeObjectForKey:@"Content-Type"];
	return [self requestSync:GET];
}

- (HttpResult *)post {
	return [self requestSync:POST];
}

- (HttpResult *)multipart {
	return [self requestSync:POST_MULTIPART];
}

- (HttpResult *)postRaw:(NSData *)data {
	rawData = data;
	return [self requestSync:POST_RAW];
}


- (void)getAsync:(HttpCallback)callback {
	[self requestAsync:GET callback:callback];
}

- (void)postAsync:(HttpCallback)callback {
	[self requestAsync:POST callback:callback];
}

- (void)postRawAsync:(HttpCallback)callback {
	[self requestAsync:POST_RAW callback:callback];
}

- (void)multipartAsync:(HttpCallback)callback {
	[self requestAsync:POST_MULTIPART callback:callback];
}


- (NSString *)buildGetUrl {
	NSString *url = self.url;
	NSString *query = [self buildQueryString:YES];
	if (query.length == 0) {
		return url;
	}
	if (![url containsChar:'?']) {
		return [[url add:@"?"] add:query];
	}
	if (url.lastChar == '?') {
		return [url add:query];
	}
	return [[url add:@"&"] add:query];

}

- (NSString *)buildQueryString:(BOOL)encodeUrl {
	NSString *s = @"";
	for (NSString *key in argMap) {
		if (s.length > 0) {
			s = strBuild(s, @"&");
		}
		NSString *value = argMap[key];
		if (encodeUrl) {
			NSString *k = key.urlEncoded;
			NSString *v = value.urlEncoded;
			s = strBuild(s, k, @"=", v);
		} else {
			s = strBuild(s, key, @"=", value);
		}
	}
	return s;
}

- (NSData *)buildMultipartData {
	NSMutableData *data = [NSMutableData dataWithCapacity:4096];
	for (NSString *key in argMap) {
		[data appendUTF8:BOUNDARY_START];
		[data appendUTF8:strBuild(@"Content-Disposition: form-data; name=\"", key, @"\"", CRLF)];
		[data appendUTF8:strBuild(@"Content-Type:text/plain;charset=utf-8", CRLF)];
		[data appendUTF8:CRLF];
		[data appendUTF8:argMap[key]];
		[data appendUTF8:CRLF];

	}
	for (NSString *key in fileMap) {
		NSString *value = fileMap[key];
		NSData *fileData = [NSData dataWithContentsOfFile:value];
		NSString *filename = [value stringByDeletingLastPathComponent];
		[data appendUTF8:BOUNDARY_START];
		[data appendUTF8:strBuild(@"Content-Disposition:form-data;name=\"", key, @"\";filename=\"", filename, @"\"", CRLF)];
		[data appendUTF8:@"Content-Type:application/octet-stream\r\n"];
		[data appendUTF8:@"Content-Transfer-Encoding: binary\r\n"];
		[data appendUTF8:CRLF];
		[data appendData:fileData];
		[data appendUTF8:CRLF];
	}
	for (NSString *key in fileDataMap) {
		NSString *filename = key;
		[data appendUTF8:BOUNDARY_START];
		[data appendUTF8:strBuild(@"Content-Disposition:form-data;name=\"", key, @"\";filename=\"", filename, @"\"", CRLF)];
		[data appendUTF8:@"Content-Type:application/octet-stream\r\n"];
		[data appendUTF8:@"Content-Transfer-Encoding: binary\r\n"];
		[data appendUTF8:CRLF];
		[data appendData:fileDataMap[key]];
		[data appendUTF8:CRLF];
	}
	[data appendUTF8:BOUNDARY_END];
	return data;
}

- (NSMutableURLRequest *)buildRequest:(int)method {
	if (method == GET) {
		[headerMap removeObjectForKey:@"Content-Type"];
	} else if (method == POST_MULTIPART) {
		[self contentType:[@"multipart/form-data; boundary=" add:BOUNDARY]];
	} else {
		if (![[headerMap allKeys] containsObject:@"Content-Type"]) {
			[self contentType:@"application/x-www-form-urlencoded;charset=UTF-8"];
		}
	}


	NSString *url = self.url;
	NSString *query = [self buildQueryString:method == GET];
	NSLog(@"URL: %@", url);
	NSLog(@"Query: %@", query);

	NSString *urlStr = url;
	if (method == GET) {
		urlStr = self.buildGetUrl;
	}
	NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
	req.timeoutInterval = self.timeout;
	[req setHTTPShouldHandleCookies:NO];
	NSString *m = @"POST";
	if (method == GET) {
		m = @"GET";
	}
	[req setHTTPMethod:m];
	if (method == POST) {
		if (query.length > 0) {
			req.HTTPBody = query.dataUTF8;
		}
	} else if (method == POST_RAW) {
		req.HTTPBody = rawData;
		NSLog(@"Post Body: %@", rawData.stringUTF8);
	} else if (method == POST_MULTIPART) {
		req.HTTPBody = self.buildMultipartData;
	}

	for (NSString *key in headerMap) {
		[req setValue:headerMap[key] forHTTPHeaderField:key];
	}
	return req;
}

//- (NSURLSessionTask *)requestAsync:(int)method callback:(void (^)(HttpResult *))callback {
- (NSURLSessionTask *)requestAsync:(int)method callback:(HttpCallback)callback {
	NSMutableURLRequest *req = [self buildRequest:method];

	NSURLSessionTask *task = [session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *resp, NSError *err) {
		HttpResult *r = [HttpResult new];
		r.data = data;
		r.response = (NSHTTPURLResponse *) resp;
		r.error = err;
		[r dump];
		callback(r);
	}];
	[task resume];
	[self watchSend:task];
	[self watchRecv:task];

	return task;
}

- (HttpResult *)requestSync:(int)method {
	NSMutableURLRequest *req = [self buildRequest:method];

	dispatch_semaphore_t sem = dispatch_semaphore_create(0);
	HttpResult *r = [HttpResult new];
	NSURLSessionTask *task = [session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *resp, NSError *err) {
		r.data = data;
		r.response = (NSHTTPURLResponse *) resp;
		r.error = err;
		dispatch_semaphore_signal(sem);
	}];
	[task resume];
	[self watchSend:task];
	[self watchRecv:task];
	dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
	[r dump];
	return r;
}

- (void)watchRecv:(NSURLSessionTask *)task {
	id <HttpProgress> ppp = self.progressRecv;
	if (ppp == nil || task == nil) {
		return;
	}
	foreDelay(200, ^() {
		id <HttpProgress> p = self.progressRecv;
		NSURLSessionTask *t = task;
		if (p != nil && t != nil) {
			[self callbackRecvProgress:p task:t];
		}

	});
}


- (void)callbackRecvProgress:(id <HttpProgress>)p task:(NSURLSessionTask *)task {
	int received = (int) task.countOfBytesReceived;
	int total = (int) task.countOfBytesExpectedToReceive;

	if (received > 0 || total > 0) {
		if (!recvStart) {
			recvStart = YES;
			progStart(p, total);
			progProgress(p, 0, total, 0);
		}
		int percent = received * 100 / total;
		progProgress(p, received, total, percent);
	}
	if (task.state == NSURLSessionTaskStateRunning || task.state == NSURLSessionTaskStateSuspended) {
		[self watchRecv:task];
	} else {
		BOOL OK = task.state == NSURLSessionTaskStateCompleted;
		if (OK) {
			progProgress(p, total, total, 100);
		}
		progFinish(p, OK);
	}
}

- (void)watchSend:(NSURLSessionTask *)task {
	id <HttpProgress> ppp = self.progressSend;
	if (ppp == nil || task == nil) {
		return;
	}
	foreDelay(200, ^() {
		id <HttpProgress> p = self.progressSend;
		NSURLSessionTask *t = task;
		if (p != nil && t != nil) {
			[self callbackSendProgress:p task:t];
		}

	});
}

- (void)callbackSendProgress:(id <HttpProgress>)p task:(NSURLSessionTask *)task {
	int sent = (int) task.countOfBytesSent;
	int total = (int) task.countOfBytesExpectedToSend;

	if (sent > 0 || total > 0) {
		if (!sendStart) {
			sendStart = YES;
			progStart(p, total);
			progProgress(p, 0, total, 0);
		}
		int percent = sent * 100 / total;
		progProgress(p, sent, total, percent);
	}
	if (task.state == NSURLSessionTaskStateRunning || task.state == NSURLSessionTaskStateSuspended) {
		[self watchSend:task];
	} else {
		BOOL OK = task.state == NSURLSessionTaskStateCompleted;
		if (OK) {
			progProgress(p, total, total, 100);
		}
		progFinish(p, OK);
	}
}


@end

