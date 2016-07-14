/***********************************************************************************************************
Description: Stored Procedure to insert first & last name into Staff Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	
************************************************************************************************************/
ALTER PROCEDURE [dbo].[ins_StaffMember]
	@staffTypeID int,
	@addressesID int,
	@additionalContactInfoID int,
	@firstName varchar(500),
	@lastName varchar(500),
	@staffAltID int,
	@deleted bit,
	@handicapped bit,
	@staffSSN int,
	@success bit OUTPUT
	
AS
	BEGIN
		BEGIN TRY
		
		IF EXISTS (SELECT * FROM StaffMember WHERE (ssn <> @staffSSN) OR (firstName <> @firstName AND lastName <> @lastName AND dob <> @dob))
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
						ssn)

		VALUES (@staffTypeID, 
				@addressesID, 
				@additionalContactInfoID, 
				@firstName, 
				@lastName, 
				@staffAltID,
				@deleted,
				@handicapped,
				@staffSSN)

		END TRY
		BEGIN CATCH

			DECLARE @timeStamp DATETIME,
				@errorMessage VARCHAR(250),
				@errorProcedure VARCHAR(200)	

			SELECT @timeStamp = GETDATE(),
					@errorMessage = ERROR_MESSAGE(),
					@errorProcedure = ERROR_PROCEDURE()
			
			EXECUTE dbo.log_ErrorTimeStamp @timeStamp, @errorMessage, @errorProcedure

		END CATCH
	END
