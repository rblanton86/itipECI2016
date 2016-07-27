/***********************************************************************************************************
Description: Stored Procedure to pull information from additionalContactInfo
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	7.16.16 -JMG- Added ability to get by memberyID
	7.26.16 -TPC- Restored to previous version
************************************************************************************************************/
ALTER PROCEDURE [dbo].[get_AdditionalContactInfo]
	@additionalContactInfoID int
	
AS
	BEGIN
		BEGIN TRY

			SELECT aci.additionalContactInfoID,
					ISNULL(aci.memberTypeID, 1) AS memberTypeID,
					ISNULL(aci.additionalContactInfoTypeID, 1) AS additionalContactInfoTypeID,
					ISNULL(aci.additionalContactInfo, ' ') AS additionalContactInfo,
					aci.deleted,
					ISNULL(mbt.memberType,' ') AS memberType,
					ISNULL(acit.additionalContactInfoType, ' ') AS additionalContactInfoType

			FROM AdditionalContactInfo aci
					LEFT JOIN MemberType mbt ON
					aci.memberTypeID = mbt.memberTypeID
					LEFT JOIN AdditionalContactInfoType acit ON
					acit.additionalContactInfoTypeID = aci.additionalContactInfoID
			WHERE additionalContactInfoID = @additionalContactInfoID AND aci.deleted <> 1

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