/***********************************************************************************************************
Description: Stored Procedure to pull information from additionalContactInfo
	 
Author: 
	Jennifer Graves 
Date: 
	7.21.16
Change History:
	07.21.2016 - Added output parameters and input parameter for memberType. Additional If statments added.
	08.09.2016 - Correction to if statement.
************************************************************************************************************/
ALTER PROCEDURE [dbo].[get_AdditionalContactInfoByMemberID]
	@memberID INT,
	@memberTypeID INT,
	@additionalContactInfoID INT OUTPUT,
	@additionalContactInfo VARCHAR(255) OUTPUT,
	@additionalContactInfoTypeID INT OUTPUT,
	@additionalContactInfoType VARCHAR(25) OUTPUT,
	@memberType VARCHAR(25) OUTPUT,
	@success BIT OUTPUT

	
AS
	BEGIN
		BEGIN TRY

			IF (@memberTypeID <= 6)
				BEGIN
					IF (@memberTypeID = 1) -- Client
						BEGIN

							SELECT ISNULL(aci.additionalContactInfoID, 0) AS additionalContactInfoID,
								ISNULL(aci.memberTypeID, 1) AS memberTypeID,
								ISNULL(mbt.memberType,'') AS memberType,
								ISNULL(aci.additionalContactInfoTypeID, 1) AS additionalContactInfoTypeID,
								ISNULL(acit.additionalContactInfoType, '') AS additionalContactInfoType,
								ISNULL(aci.additionalContactInfo, '') AS additionalContactInfo,
								aci.deleted

							FROM AdditionalContactInfo aci
								LEFT JOIN MemberType mbt ON
									aci.memberTypeID = mbt.memberTypeID
								LEFT JOIN AdditionalContactInfoType acit ON
									acit.additionalContactInfoTypeID = aci.additionalContactInfoID
								LEFT JOIN Clients clnt ON
									clnt.clientID = aci.memberID
					
							WHERE clnt.clientID = @memberID AND aci.deleted <> 1

							UNION all
								SELECT 0,
									1,
									'',
									1,
									'',
									'',
									0
							WHERE NOT EXISTS (SELECT 1 FROM AdditionalContactInfo)

							SET @success = 1

						END

					IF (@memberTypeID = 2) -- Family
						BEGIN

							SELECT ISNULL(aci.additionalContactInfoID, 0) AS additionalContactInfoID,
								ISNULL(aci.memberTypeID, 1) AS memberTypeID,
								ISNULL(mbt.memberType,' ') AS memberType,
								ISNULL(aci.additionalContactInfoTypeID, 1) AS additionalContactInfoTypeID,
								ISNULL(acit.additionalContactInfoType, ' ') AS additionalContactInfoType,
								ISNULL(aci.additionalContactInfo, ' ') AS additionalContactInfo,
								aci.deleted

							FROM AdditionalContactInfo aci
								LEFT JOIN MemberType mbt ON
									aci.memberTypeID = mbt.memberTypeID
								LEFT JOIN AdditionalContactInfoType acit ON
									acit.additionalContactInfoTypeID = aci.additionalContactInfoID
								LEFT JOIN FamilyMember fam ON
									fam.familyMemberID = aci.memberID
					
							WHERE fam.familyMemberID = @memberID AND aci.deleted <> 1

							SET @success = 1

						END

					IF (@memberTypeID = 3) -- Staff
						BEGIN

							SELECT ISNULL(aci.additionalContactInfoID, 0) AS additionalContactInfoID,
								ISNULL(aci.memberTypeID, 1) AS memberTypeID,
								ISNULL(mbt.memberType,' ') AS memberType,
								ISNULL(aci.additionalContactInfoTypeID, 1) AS additionalContactInfoTypeID,
								ISNULL(acit.additionalContactInfoType, ' ') AS additionalContactInfoType,
								ISNULL(aci.additionalContactInfo, ' ') AS additionalContactInfo,
								aci.deleted

							FROM AdditionalContactInfo aci
								LEFT JOIN MemberType mbt ON
									aci.memberTypeID = mbt.memberTypeID
								LEFT JOIN AdditionalContactInfoType acit ON
									acit.additionalContactInfoTypeID = aci.additionalContactInfoID
								LEFT JOIN Staff stf ON
									stf.staffID = aci.memberID
					
							WHERE stf.staffID = @memberID AND aci.deleted <> 1

							SET @success = 1

						END

					IF (@memberTypeID = 4) -- Physician
						BEGIN

							SELECT ISNULL(aci.additionalContactInfoID, 0) AS additionalContactInfoID,
								ISNULL(aci.memberTypeID, 1) AS memberTypeID,
								ISNULL(mbt.memberType,' ') AS memberType,
								ISNULL(aci.additionalContactInfoTypeID, 1) AS additionalContactInfoTypeID,
								ISNULL(acit.additionalContactInfoType, ' ') AS additionalContactInfoType,
								ISNULL(aci.additionalContactInfo, ' ') AS additionalContactInfo,
								aci.deleted

							FROM AdditionalContactInfo aci
								LEFT JOIN MemberType mbt ON
									aci.memberTypeID = mbt.memberTypeID
								LEFT JOIN AdditionalContactInfoType acit ON
									acit.additionalContactInfoTypeID = aci.additionalContactInfoID
								LEFT JOIN Staff stf ON
									stf.staffID = aci.memberID
					
							WHERE stf.staffID = @memberID AND aci.deleted <> 1

							SET @success = 1

						END

					IF (@memberTypeID = 5) -- Referral Source
						BEGIN

							SELECT ISNULL(aci.additionalContactInfoID, 0) AS additionalContactInfoID,
								ISNULL(aci.memberTypeID, 1) AS memberTypeID,
								ISNULL(mbt.memberType,' ') AS memberType,
								ISNULL(aci.additionalContactInfoTypeID, 1) AS additionalContactInfoTypeID,
								ISNULL(acit.additionalContactInfoType, ' ') AS additionalContactInfoType,
								ISNULL(aci.additionalContactInfo, ' ') AS additionalContactInfo,
								aci.deleted

							FROM AdditionalContactInfo aci
								LEFT JOIN MemberType mbt ON
									aci.memberTypeID = mbt.memberTypeID
								LEFT JOIN AdditionalContactInfoType acit ON
									acit.additionalContactInfoTypeID = aci.additionalContactInfoID
								LEFT JOIN ReferralSource rs ON
									rs.referralSourceID = aci.memberID
					
							WHERE rs.referralSourceID = @memberID AND aci.deleted <> 1

							SET @success = 1

						END

					IF (@memberTypeID = 6) -- Insurance
						BEGIN

							SELECT ISNULL(aci.additionalContactInfoID, 0) AS additionalContactInfoID,
								ISNULL(aci.memberTypeID, 1) AS memberTypeID,
								ISNULL(mbt.memberType,' ') AS memberType,
								ISNULL(aci.additionalContactInfoTypeID, 1) AS additionalContactInfoTypeID,
								ISNULL(acit.additionalContactInfoType, ' ') AS additionalContactInfoType,
								ISNULL(aci.additionalContactInfo, ' ') AS additionalContactInfo,
								aci.deleted

							FROM AdditionalContactInfo aci
								LEFT JOIN MemberType mbt ON
									aci.memberTypeID = mbt.memberTypeID
								LEFT JOIN AdditionalContactInfoType acit ON
									acit.additionalContactInfoTypeID = aci.additionalContactInfoID
								LEFT JOIN Insurance ins ON
									ins.insuranceID = aci.memberID
					
							WHERE ins.insuranceID = @memberID AND aci.deleted <> 1

							SET @success = 1

						END

				END

			ELSE
				
				BEGIN
					
					SET @success = 0
				
				END

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

