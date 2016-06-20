/***********************************************************************************************************
Description: 
	 Creates Tables relating to additional information about a client (i.e. comments)
Author: 
	Tyrell Powers-Crane
Date: 
	6.20.2016
Change History:
	6.20.16 - tpc - Removed comments foreign key referencing client
************************************************************************************************************/
CREATE TABLE Comments (
	commentsID INT IDENTITY (1,1) PRIMARY KEY (commentsID) NOT NULL,
	comments varchar(250) NOT NULL,
	)
	 