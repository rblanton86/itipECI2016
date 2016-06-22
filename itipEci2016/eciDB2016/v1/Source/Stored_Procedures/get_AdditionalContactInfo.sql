/***********************************************************************************************************
Description: Stored Procedure to pull information from additionalContactInfo
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.21.16
Change History:
	
************************************************************************************************************/
CREATE PROCEDURE [dbo].[get_AdditionalContactInfo]
	@additionalContactInfoID int
	
AS
	BEGIN
		BEGIN TRY

			SELECT aci.*, mbt.memberType, acit.additionalContacatInfoType
			FROM AdditionalContactInfo aci
				LEFT JOIN MemberType mbt ON
				aci.memberTypeID = mbt.memberTypeID
				LEFT JOIN AdditionalContactInfoType acit ON
				aci.additionalContactInfoTypeID = acit.additionalContactInfoID
			WHERE @additionalContactInfoID = additonalContactInfoID

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

