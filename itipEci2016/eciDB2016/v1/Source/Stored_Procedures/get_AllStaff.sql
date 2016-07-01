/***********************************************************************************************************
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

		SELECT staff.*, 
				stafft.staffType, 
				addr.address1, addr.address2, addr.st, addr.city, addr.zip
			

			FROM Staff staff 
				LEFT JOIN StaffType stafft ON
					staff.staffTypeID = stafft.staffTypeID
				LEFT JOIN Addresses addr ON
					staff.addressesID = stafft.staffTypeID
				


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
