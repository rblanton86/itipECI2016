/***********************************************************************************************************
Description: 
	 Creates Tables relating to additional information about a client (i.e. comments)
Author: 
	Tyrell Powers-Crane
Date: 
	6.20.2016
Change History:
	
************************************************************************************************************/
CREATE TABLE Comments (
	commentsID INT IDENTITY (1,1) PRIMARY KEY (commentsID) NOT NULL,
	clientID INT FOREIGN KEY REFERENCES Clients(clientID) NOT NULL,
	comments varchar(250) NOT NULL,
	)
	 