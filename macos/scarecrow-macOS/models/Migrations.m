//
//  Migrations.m
//  scarecrow-macOS
//
//  Created by azim on 11.10.2023.
//

#import <Foundation/Foundation.h>
#import <os/log.h>
#import "Migrations.h"

@implementation Migrations

- (instancetype)init
{
  self = [super init];
  
  NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  NSString *dbPath = [documentsPath stringByAppendingPathComponent:@"scarecrow.sqlite3"];

  [FCModel openDatabaseAtPath:dbPath withDatabaseInitializer:^(FMDatabase * _Nonnull db) {
    
  } schemaBuilder:^(FMDatabase * _Nonnull db, int * _Nonnull schemaVersion) {
    [db beginTransaction];
    
    os_log(OS_LOG_DEFAULT, "[scarecrow] starting migration for schema version %d", *schemaVersion);

    void (^failedAt)(int statement) = ^(int statement){
      os_log(OS_LOG_DEFAULT, "[scarecrow] migration statement %d failed, code %d: %@", statement, db.lastErrorCode, db.lastErrorMessage);
      [db rollback];
    };

    if (*schemaVersion <= 1) {
      if (![db executeUpdate:
        @"CREATE TABLE FlowModel ("
        @"id INTEGER PRIMARY KEY,"
        @"processId INTEGER,"
        @"identifier TEXT NOT NULL DEFAULT '',"
        @"direction TEXT NOT NULL DEFAULT '',"
        @"remoteUrl TEXT NOT NULL DEFAULT '',"
        @"remoteEndpoint TEXT NOT NULL DEFAULT '',"
        @"createdAt REAL NOT NULL"
        @");"
      ]) failedAt(1);

      if (![db executeUpdate:
        @"CREATE TABLE ProcessModel ("
        @"id INTEGER PRIMARY KEY,"
        @"path TEXT NOT NULL DEFAULT '',"
        @"name TEXT NOT NULL DEFAULT '',"
        @"bundle TEXT NOT NULL DEFAULT '',"
        @"icon TEXT NOT NULL DEFAULT '',"
        @"FOREIGN KEY (id) REFERENCES FlowModel(id)"
        @");"
        @"ALTER TABLE FlowModel ADD FOREIGN KEY (processId) REFERENCES ProcessModel(id);"
      ]) failedAt(2);

      if (![db executeUpdate:
        @"CREATE TABLE RuleModel ("
        @"id INTEGER PRIMARY KEY,"
        @"flowId INTEGER,"
        @"allowed INTEGER,"
        @"createdAt REAL NOT NULL,"
        @"FOREIGN KEY (id) REFERENCES ProcessModel(id)"
        @");"
      ]) failedAt(3);

      *schemaVersion = 1;
      os_log(OS_LOG_DEFAULT, "[scarecrow] migration for schema version %d has completed", *schemaVersion);
    }

    [db commit];
    os_log(OS_LOG_DEFAULT, "[scarecrow] migration for commited");
  }];

  return self;
}

@end
