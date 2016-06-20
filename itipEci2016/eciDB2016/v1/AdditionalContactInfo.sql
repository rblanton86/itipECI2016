/***********************************************************************************************************
Description: 
	 Creates Contact info tables that hold contact information (i.e. phone, email, twitter) and type
Author: 
	Tyrell Powers-Crane
Date: 
	6.20.2016
Change History:
	
************************************************************************************************************/
CREATE TABLE AdditionalContactInfo (
	additionalContactInfoID INT IDENTITY (1,1) PRIMARY KEY (additionalContactInfoID),
	memberTypeID INT FOREIGN KEY REFERENCES MemberTypey(memberTypeID),
	additionalContactInfoTypeID INT FOREIGN KEY REFERENCES AdditionalContactInfoType(additonalContactInfoTypeID),
	additionalContactInfo VARCHAR(255),
) 
--Type Table: Provides description of Additional Contact Info
CREATE TABLE AdditionalContactInfoType (
	additionalContactInfoTypeID INT IDENTITY (1,1) PRIMARY KEY (additionalContactInfoTypeID),
	additionalContactInfoType VARCHAR(25)
	) 