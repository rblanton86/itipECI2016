/***********************************************************************************************************
Description: Stored Procedure that inserts family information into the Family Member Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.23.16
Change History:
	07/22/2016: JMG - Added familyMemberID output. Removed additionalContactInfoID.
	08/10/2016: JMG - Added input parameter for clientID.
************************************************************************************************************/
ALTER PROCEDURE [dbo].[ins_FamilyMember]
	@familyMemberTypeID int,
	@clientID int,
	@firstName varchar (25),
	@lastName varchar (25),
	@isGuardian bit,
	@sexID int,
	@raceID bit,
	@occupation varchar(50),
	@employer varchar(50),
	@dob DATE,
	@success bit OUTPUT,
	@familyMemberID INT OUTPUT


AS
	BEGIN
		BEGIN TRY

			IF EXISTS (SELECT * FROM FamilyMember WHERE (firstName <> @firstName AND lastName <> @lastName AND dob <> @dob))
				BEGIN

					SET @success = 1

					INSERT FamilyMember (familyMemberTypeID,
											firstName,
											lastName,
											isGuardian,
											sexID,
											raceID,
											occupation,
											employer,
											dob
											)
									
					VALUES (@familyMemberTypeID,
							@firstName,
							@lastName,
							@isGuardian,
							@sexID,
							@raceID,
							@occupation,
							@employer,
							@dob)

					SET @familyMemberID = (
						SELECT familyMemberID
							FROM FamilyMember
							WHERE familyMemberTypeID = @familyMemberTypeID AND
											firstName = @firstName AND
											lastName = @lastName AND
											isGuardian = @isGuardian AND
											sexID = @sexID AND
											raceID = @raceID AND
											occupation = @occupation AND
											employer = @employer AND
											dob = @dob
											)
					
					
					INSERT LnkClientFamily (clientID, familyID)
						VALUES(@clientID, @familyMemberID)

					SET @success = 1

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



