--Type Table: Provides authorization information for clients insurance
/************************************************************************************************************
Description:
	Insurance Auth number for patient insurance
Author:
	Tyrell Powers-Crane
Date:
	6.20.16
Change History:

**********************************************************************************************************/
CREATE TABLE InsuranceAuthorization (
	insuranceAuthID INT IDENTITY (1,1) PRIMARY KEY (insuranceAuthID),
	authorized_From INT,
	authorized_To INT,
	insuranceAuthorizationType VARCHAR (25)
	)