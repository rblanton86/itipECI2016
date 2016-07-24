/***********************************************************************************************************
Description: Stored Procedure to insert first & last name into Staff Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	7.15.2016 -tpc- Added memberTypeID 
************************************************************************************************************/
ALTER PROCEDURE [dbo].[ins_StaffMember]
	@staffTypeID int,
	@addressesID int,
	@memberTypeID int,
	@firstName varchar(25),
	@lastName varchar(25),
	@staffAltID varchar(25),
	@deleted bit,
	@handicapped bit,
	@ssn int,
	@dob date,
	@staffStatus int,
	@staffID int OUTPUT
	
AS
	BEGIN
		BEGIN TRY
		
		IF EXISTS (SELECT * FROM Staff WHERE (ssn = @ssn) OR (firstName = @firstName AND lastName = @lastName AND dob = @dob))
			BEGIN
				RETURN 0		
			END
		ELSE
			BEGIN
			INSERT Staff (staffTypeID, 
								addressesID, 
								memberTypeID, 
								firstName, 
								lastName, 
								staffAltID,
								deleted,
								handicapped,
								ssn,
								staffStatus,
								dob)

				VALUES (@staffTypeID, 
						@addressesID, 
						@memberTypeID,
						@firstName, 
						@lastName, 
						@staffAltID,
						@deleted,
						@handicapped,
						@ssn,
						@staffStatus,
						@dob)

				SET @staffID = (SELECT staffID FROM Staff Where firstName = @firstName AND
																	lastName = @lastName AND
																	staffAltID = @staffAltID AND
																	ssn = @ssn)

			RETURN @staffID
		END

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
