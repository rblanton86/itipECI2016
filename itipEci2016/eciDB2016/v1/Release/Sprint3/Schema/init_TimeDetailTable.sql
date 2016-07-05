/***********************************************************************************************************
Description: Creates the Time Detail Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	7.05.2016
Change History:
	
************************************************************************************************************/

CREATE TABLE TimeDetail (
	timeDetailID int IDENTITY (1,1) PRIMARY KEY,
	timeHeaderID int FOREIGN KEY REFERENCES TimeHeader(timeHeaderID),
	clientID int FOREIGN KEY REFERENCES Clients(clientID),
	actualTime decimal,
	eciCode varchar(5),
	insuranceDesignation char(1),
	cptCode varchar(5),
	insuranceTime decimal,
	placeOfService char(1),
	tcm varchar(10),
	canceled varchar(10),
	updDate datetime,
	deleted bit
	)
