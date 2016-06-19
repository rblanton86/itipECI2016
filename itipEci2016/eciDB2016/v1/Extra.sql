--Main Table: Holds Comments for a patient
CREATE TABLE Comments (
	commentsID INT IDENTITY (1,1) PRIMARY KEY (commentsID),
	clientID INT FOREIGN KEY REFERENCES Clients(clientID),
	comments varchar(250),
	)
	 