/***********************************************************************************************************
Description: Stored Procedure to pull information from Diagnosis table based on the clientID.
Author: Jennifer M Graves
Date: 07-13-2016
Change History:
************************************************************************************************************/
ALTER PROCEDURE [dbo].[get_FamilyByClientID]
	@clientID int

AS
	BEGIN TRY

		SELECT 
				fm.familyMemberID,
				fm.familyMemberTypeID,
				ISNULL(fm.firstName, ' ') AS firstName,
				ISNULL(fm.lastName, ' ') AS lastName,
				ISNULL(fm.isGuardian, 1) AS isGuardian,
				fm.additionalContactInfoID,
				fm.sexID,
				fm.deleted,
				fm.raceID,
				ISNULL(fm.occupation, ' ') AS occupation,
				ISNULL(fm.employer, ' ') AS employer,
				ISNULL(fm.dob, '19000101') AS dob,
				ISNULL(fmt.familyMemberType, ' ') AS familyMemberType

		FROM LnkClientFamily lcf
			LEFT JOIN FamilyMember fm
				ON fm.familyMemberID = lcf.familyID
			LEFT JOIN FamilyMemberType fmt
				ON fmt.familyMemberTypeID = fm.FamilyMemberTypeID

		WHERE lcf.clientID = @clientID

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