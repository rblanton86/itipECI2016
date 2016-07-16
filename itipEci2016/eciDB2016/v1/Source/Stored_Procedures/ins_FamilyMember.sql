/***********************************************************************************************************
Description: Stored Procedure that inserts family information into the Family Member Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[ins_FamilyMember]
	@familyMemberTypeID int,
	@firstName varchar (25),
	@lastName varchar (25),
	@isGuardian bit,
	@additionalContactInfoID int,
	@sexID int,
	@deleted bit,
	@raceID bit,
	@occupation varchar(50),
	@employer varchar(50),
	@dob DATE,
	@success bit OUTPUT


AS
	BEGIN
		BEGIN TRY

			IF EXISTS (SELECT * FROM FamilyMember WHERE (firstName <> @firstName AND lastName <> @lastName AND dob <> @dob))
			BEGIN

				SET @success = 1

				INSERT FamilyMember (familyMemberTypeID,
										additionalContactInfoID,
										firstName,
										lastName,
										isGuardian,
										sexID,
										deleted,
										raceID,
										occupation,
										employer,
										dob
										)
									
				VALUES (@familyMemberTypeID,
						@additionalContactInfoID,
						@firstName,
						@lastName,
						@isGuardian,
						@sexID,
						@deleted,
						@raceID,
						@occupation,
						@employer,
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
				@errorMessage VARCHAR(255),
				@errorProcedure VARCHAR(100)	

			SELECT @timeStamp = GETDATE(),
					@errorMessage = ERROR_MESSAGE(),
					@errorProcedure = ERROR_PROCEDURE()
			
			EXECUTE dbo.log_ErrorTimeStamp @timeStamp, @errorMessage, @errorProcedure

		END CATCH
	END



