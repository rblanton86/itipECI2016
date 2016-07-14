﻿/***********************************************************************************************************
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
				ISNULL(fm.firstName, ' '),
				ISNULL(fm.lastName, ' '),
				ISNULL(fm.isGuardian, 1),
				fm.additionalContactInfoID,
				fm.sexID,
				fm.deleted,
				fm.raceID,
				ISNULL(fm.occupation, ' '),
				ISNULL(fm.employer, ' '),
				ISNULL(fm.dob, ' '),
				ISNULL(fmt.familyMemberType, ' ')

		FROM LnkClientFamily lcf
			LEFT JOIN FamilyMember fm
				ON fm.familyMemberID = lcf.familyID
			LEFT JOIN FamilyMemberType fmt
				ON fmt.familyMemberTypeID = fm.FamilyMemberTypeID

		WHERE lcf.clientID = @clientID AND fm.deleted <> 1

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