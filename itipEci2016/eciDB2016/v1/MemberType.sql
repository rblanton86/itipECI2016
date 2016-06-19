--Reference table. Client, physician, referralsource, family member, staff.
CREATE TABLE MemberType (
	memberTypeID INT IDENTITY (1,1) PRIMARY KEY (memberTypeID),
	memberType VARCHAR(25),	
) 