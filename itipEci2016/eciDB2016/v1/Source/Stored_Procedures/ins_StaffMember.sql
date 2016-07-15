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
	@firstName varchar(500),
	@lastName varchar(500),
	@staffAltID int,
	@deleted bit,
	@handicapped bit,
	@ssn int,
	@dob date,
	@success int OUTPUT
	
AS
	BEGIN
		BEGIN TRY
		
		IF EXISTS (SELECT * FROM Staff WHERE (ssn <> @ssn) OR (firstName <> @firstName AND lastName <> @lastName AND dob <> @dob))
			BEGIN

				SET @success = 1

				INSERT Staff (staffTypeID, 
								addressesID, 
								additionalContactInfoID, 
								firstName, 
								lastName, 
								staffAltID,
								deleted,
								handicapped,
								ssn,
								dob)

				VALUES (@staffTypeID, 
						@addressesID, 
						@additionalContactInfoID, 
						@firstName, 
						@lastName, 
						@staffAltID,
						@deleted,
						@handicapped,
						@ssn,
						@dob)
			END
		ELSE
			BEGIN
				SET @success = 0
			END

			RETURN @success

		END TRY
		BEGIN CATCH

			DECLARE @timeStamp DATETIME,
				@errorMessage NVARCHAR(MAX),
				@errorProcedure NVARCHAR(MAX)	

			SELECT @timeStamp = GETDATE(),
					@errorMessage = ERROR_MESSAGE(),
					@errorProcedure = ERROR_PROCEDURE()
			
			EXECUTE dbo.log_ErrorTimeStamp @timeStamp, @errorMessage, @errorProcedure

		END CATCH
	END
