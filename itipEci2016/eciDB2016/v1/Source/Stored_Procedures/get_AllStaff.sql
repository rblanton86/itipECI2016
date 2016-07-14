/***********************************************************************************************************
Description: Stored Procedure to pull all staff from Staff table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.29.16
Change History:
	
************************************************************************************************************/
ALTER PROCEDURE [dbo].[get_AllStaff]
	
AS
	BEGIN
		BEGIN TRY

		SELECT staff.staffID,
				staff.staffTypeID,
				staff.addressesID,
				staff.additionalContactInfoID,
				ISNULL(staff.firstName, ' '),
				ISNULL(staff.lastName, ' '),
				ISNULL(staff.handicapped, 0),
				ISNULL(staff.staffAltID, ' '),
				staff.sexID,
				staff.deleted,
				ISNULL(staff.ssn, 0),
				ISNULL(staff.dob, ' '),
				stafft.staffType, 
				addr.addressesID,
				ISNULL(addr.addressesTypeID, 1),
				ISNULL (addr.address1, ' '),
				ISNULL(addr.address2, ' '),
				ISNULL(addr.city, ' '),
				ISNULL(addr.st, ' '),
				ISNULL(addr.zip, 0),
				ISNULL(addr.mapsco, ' ')
			

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
