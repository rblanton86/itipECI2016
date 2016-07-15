﻿/***********************************************************************************************************
Description: Stored Procedure that gets last & first name from the Staff table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	
************************************************************************************************************/
alter PROCEDURE [dbo].[get_StaffByID]
	@staffID int
	
AS
	BEGIN
		BEGIN TRY

		SELECT 
				ISNULL(staff.staffID, 1) AS staffID,
				ISNULL(staff.staffTypeID, 1) AS staffTypeID,
				ISNULL(staff.addressesID, 1) AS addressesID,
				ISNULL(staff.additionalContactInfoID, 1) AS additionalContactInfoID,
				ISNULL(staff.firstName, ' ') AS firstName,
				ISNULL(staff.lastName, ' ') AS lastName,
				ISNULL(staff.handicapped, 0) AS handicapped,
				ISNULL(staff.staffAltID, ' ') AS staffAltID,
				ISNULL(staff.sexID, 1) AS sexID,
				staff.deleted,
				ISNULL(staff.ssn, 0) AS ssn,
				ISNULL(staff.dob, ' ') AS dob,
				ISNULL(stafft.staffType, ' ') AS staffType, 
				ISNULL(addr.addressesID, 1) AS addressesID,
				ISNULL(addr.addressesTypeID, 1) AS addressesTypeID,
				ISNULL(addr.address1, ' ') AS address1,
				ISNULL(addr.address2, ' ') AS address2,
				ISNULL(addr.city, ' ') AS city,
				ISNULL(addr.st, ' ') AS st,
				ISNULL(addr.zip, 0) AS zip,
				ISNULL(addr.mapsco, ' ') AS mapsco,
 
				ISNULL(aci.additionalContactInfo, ' ') AS additionalContactInfo

			FROM Staff staff 
				LEFT JOIN StaffType stafft ON
					staff.staffTypeID = stafft.staffTypeID
				LEFT JOIN Addresses addr ON
					staff.addressesID = addr.addressesID
				LEFT JOIN AdditionalContactInfo aci ON
					staff.additionalContactInfoID = aci.additionalContactInfoID

			WHERE (staffID = @staffID) AND (Staff.deleted <> 1)

		END TRY
		BEGIN CATCH

			DECLARE @timeStamp DATETIME,
				@errorMessage VARCHAR(255),
				@errorProcedure VARCHAR(100)	

			SELECT @timeStamp = GETDATE(),
					@errorMessage = ERROR_MESSAGE(),
					@errorProcedure = ERROR_PROCEDURE()
			
			EXECUTE dbo.log_ErrorTimeStamp @timeStamp, @errorMessage, @errorProcedure

		END CATCH
	END
