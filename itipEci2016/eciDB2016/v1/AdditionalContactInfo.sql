--Main table: phone, email, twitter, etc...
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