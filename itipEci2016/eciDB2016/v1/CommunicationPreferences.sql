--Main Table: Holds information on how to reach a client/family/phy
CREATE TABLE CommunicationPreferences (
	communicationPreferencesID INT IDENTITY (1,1) PRIMARY KEY (communicationPreferencesID),
	communicationPreferences VARCHAR(25),
	)