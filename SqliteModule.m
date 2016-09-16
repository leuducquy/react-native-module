//
//  SqliteModule.m
//  CameraProject
//
//  Created by Quy on 4/25/16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "SqliteModule.h"
#import "RCTConvert.h"
@interface SqliteModule()
@property (nonatomic ,strong) RCTPromiseResolveBlock resolve;
@property (nonatomic ,strong) RCTPromiseRejectBlock reject;
@property (nonatomic ,strong ) NSMutableArray *query;

@property (strong, nonatomic) NSString *databasePath;
@property (strong , nonatomic)NSDictionary *dictOption;
@property (nonatomic) sqlite3 *contactDB;
@end
@implementation SqliteModule
RCT_EXPORT_MODULE();

RCT_REMAP_METHOD(getAllStudent,resolver: (RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  self.reject = reject;
  self.resolve = resolve;
   [self createDataBase];
   NSString *query  = [NSString stringWithFormat:@"SELECT * FROM contacts "];
  [self getData:query];
  
}
RCT_REMAP_METHOD(updateData,options:(NSString*)options resolver: (RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject){
  self.reject = reject;
  self.resolve = resolve;
  [self createDataBase];
  [self updateDataWith:options];
  
  
}
-(NSString*)dictionnaryToJson:(NSDictionary*)dictOutput{
  NSError *error;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictOutput
                                                     options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                       error:&error];
  
  if (! jsonData) {
    NSLog(@"Got an error: %@", error);
  } else {
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
  }
  return nil;
}

-(void)updateDataWith:(NSString*)options{
  NSData *data = [options dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *dict = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
  sqlite3_stmt    *statement;
  const char *dbpath = [_databasePath UTF8String];
  
  if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
  {
    
    NSString *insertSQL = [NSString stringWithFormat:
                           @"INSERT INTO CONTACTS (name,note) VALUES (\"%@\", \"%@\")",
                          [dict objectForKey:@"name"],[dict objectForKey:@"note"]];
    
    
    const char *insert_stmt = [insertSQL UTF8String];
    sqlite3_prepare_v2(_contactDB, insert_stmt,
                       -1, &statement, NULL);
    if (sqlite3_step(statement) == SQLITE_DONE)
     
    {
      NSDictionary *dictSuccess = @{@"OK": @"Success"};
      NSString *stringOutput = [self dictionnaryToJson:dictSuccess];
      
      self.resolve(@[stringOutput]);
    } else {
      NSError *error;
       self.reject(@"Failed to add contact",@"failed",error);
    }
    sqlite3_finalize(statement);
    sqlite3_close(_contactDB);
  }
}
-(void)createDataBase{
  NSString *docsDir;
  NSArray *dirPaths;
  
  // Get the documents directory
  dirPaths = NSSearchPathForDirectoriesInDomains(
                                                 NSDocumentDirectory, NSUserDomainMask, YES);
  
  docsDir = dirPaths[0];
  
  // Build the path to the database file
  _databasePath = [[NSString alloc]
                   initWithString: [docsDir stringByAppendingPathComponent:
                                    @"dbTest.sql"]];
  
  NSFileManager *filemgr = [NSFileManager defaultManager];
  
  if ([filemgr fileExistsAtPath: _databasePath ] == NO)
  {
    const char *dbpath = [_databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    {
      char *errMsg;
      const char *sql_stmt =
      "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT,  NAME TEXT, NOTE TEXT)";
      
      if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
      {
        NSString *stringError =[NSString stringWithFormat:@"%s",errMsg];
        NSError *error = (NSError*)stringError;
        self.reject(@"Failed to open/create database",@"error quy",error);
      }
      sqlite3_close(_contactDB);
    } else {
      NSError *error;
       self.reject(@"Failed to open/create database",@"error quy",error);

     
    }
  }
    
  
  
}
-(NSMutableArray *)getData:(NSString *)query
{
  
  
  //NSLog(@"QUERY : %@",query);
  
  NSString *idToReturn=@"";
  NSMutableArray *returnArray = [NSMutableArray new];
  const char *dbpath = [_databasePath UTF8String];
  
  if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
    
  {
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_contactDB, [query UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
      while(sqlite3_step(statement)==SQLITE_ROW)
      {
        NSMutableDictionary *temp= [NSMutableDictionary new];
        const char *s;
        
        
        
        s=(char *)sqlite3_column_text(statement, 0);
        if(s==NULL)
        {
          idToReturn=@"";
        }
        else
        {
          idToReturn =[NSString stringWithUTF8String:s];
        }
        [temp setObject:idToReturn forKey:@"id"];
        
        s=(char *)sqlite3_column_text(statement, 1);
        if(s==NULL)
        {
          idToReturn=@"";
        }
        else
        {
          idToReturn =[NSString stringWithUTF8String:s];
        }
        [temp setObject:idToReturn forKey:@"name"];
        
        s=(char *)sqlite3_column_text(statement, 2);
        if(s==NULL)
        {
          idToReturn=@"";
        }
        else
        {
          idToReturn =[NSString stringWithUTF8String:s];
        }
        [temp setObject:idToReturn forKey:@"note"];
         NSString *jsonData = [self dictionnaryToJson:temp];
        if (jsonData != nil)
        {
          [returnArray addObject:jsonData];
          
          temp = nil;
        }

        
        
       
       
        
        
       
      }
       self.resolve(returnArray);
      NSLog(@"array database%@",returnArray);
      sqlite3_finalize(statement);
      sqlite3_close(_contactDB);
    }
  }
  return returnArray;
}
@end
