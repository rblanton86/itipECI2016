CREATE LOGIN eciUser_Dev WITH PASSWORD = 'dev_user2016', 
	CHECK_POLICY     = OFF,
    CHECK_EXPIRATION = OFF
GO

IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'eciUser_Dev')
BEGIN
    CREATE USER [eciUser_Dev] FOR LOGIN [eciUser_Dev]
    EXEC sp_addrolemember N'db_owner', N'eciUser_Dev'
END
GO 