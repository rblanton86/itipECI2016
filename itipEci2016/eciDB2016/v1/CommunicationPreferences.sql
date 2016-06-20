/***********************************************************************************************************
Description: 
	 Creates CommunicationPreferences Table that holds information on how to contact
Author: 
	Tyrell Powers-Crane
Date: 
	6.20.2016
Change History:
	
************************************************************************************************************/
CREATE TABLE CommunicationPreferences (
	communicationPreferencesID INT IDENTITY (1,1) PRIMARY KEY (communicationPreferencesID),
	communicationPreferences VARCHAR(25),
	)