﻿/***********************************************************************************************************
Description: Stored Procedure to pull all staff from Staff table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.29.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_AllStaff]
	
AS
	BEGIN
		BEGIN TRY

		SELECT staff.staffID,
				staff.staffTypeID,
				staff.addressesID,
				staff.additionalContactInfoID,
				ISNULL(staff.firstName, ' ') AS firstName,
				ISNULL(staff.lastName, ' ') AS lastName,
				ISNULL(staff.handicapped, 0) AS handicapped,
				ISNULL(staff.staffAltID, ' ') AS staffAltID,
				staff.sexID,
				staff.deleted,
				ISNULL(staff.ssn, 0) AS ssn,
				ISNULL(staff.dob, ' ') AS dob,
				stafft.staffType, 
				addr.addressesID,
				ISNULL(addr.addressesTypeID, 1) AS addressesTypeID,
				ISNULL (addr.address1, ' ') AS address1,
				ISNULL(addr.address2, ' ') AS address2,
				ISNULL(addr.city, ' ') AS city,
				ISNULL(addr.st, ' ') AS st,
				ISNULL(addr.zip, 0) AS zip,
				ISNULL(addr.mapsco, ' ') AS mapsco
			

			FROM Staff staff 
				LEFT JOIN StaffType stafft ON
					staff.staffTypeID = stafft.staffTypeID
				LEFT JOIN Addresses addr ON
					staff.addressesID = stafft.staffTypeID
				
			WHERE Staff.deleted <> 1

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
