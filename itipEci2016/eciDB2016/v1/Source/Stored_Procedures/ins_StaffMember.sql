/***********************************************************************************************************
Description: Stored Procedure to insert first & last name into Staff Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[ins_StaffMember]
	@staffTypeID int,
	@addressesID int,
	@additionalContactInfoID int,
	@firstName varchar(20),
	@lastName varchar(20),
	@handicapped bit
	
AS
	BEGIN
		BEGIN TRY
		
		INSERT Staff (staffTypeID, 
						addressesID, 
						additionalContactInfoID, 
						firstName, 
						lastName, 
						handicapped)

		VALUES (@staffTypeID, 
				@addressesID, 
				@additionalContactInfoID, 
				@firstName, 
				@lastName, 
				@handicapped)

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
