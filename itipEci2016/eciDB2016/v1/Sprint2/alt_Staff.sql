/***********************************************************************************************************
Description: Alters the Staff Table
	 
Author: 
	Tyrell Powers-Crane 
Date: 
	6.22.16
Change History:
	6.22.16 - tpc - Added Column 'Handicapped'
************************************************************************************************************/

DECLARE @Staff int = 0
	
	SELECT @Staff = (
		SELECT object_id
		FROM sys.tables
		WHERE name = 'Staff' )

	SELECT @Staff	

IF EXISTS (SELECT 'handicapped' FROM sys.columns WHERE OBJECT_ID = @Staff)
	BEGIN
		RETURN
	END
ELSE
	BEGIN

		ALTER TABLE Staff
			ADD handicapped bit

	END
