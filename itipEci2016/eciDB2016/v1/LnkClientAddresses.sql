/***********************************************************************************************************
Description: 
	 Creates a linking table between Clients and Addresses.
Author: 
	Jennifer M. Graves
Date: 
	06/20/2016
Change History:
	
************************************************************************************************************/

IF
(SELECT object_id FROM sys.tables WHERE name = 'LnkClientAddresses') > 0
BEGIN
	CREATE TABLE LnkClientAddresses (
		clientID INT FOREIGN KEY REFERENCES Clients(clientID),
		addressesID INT FOREIGN KEY REFERENCES Addresses(addressesID)
			PRIMARY KEY (clientID, addressesID)
	)
END