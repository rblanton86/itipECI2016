/************************************************
Description: 
	Creates a reference table. Can include types of 
	Client, physician, referralsource, family member, staff.
Author: 
	Jennifer M. Graves
Date: 
	06/20/2016
Change history:

**************************************************/

CREATE TABLE MemberType (
	memberTypeID INT IDENTITY (1,1) PRIMARY KEY (memberTypeID),
	memberType VARCHAR(25),	
) 