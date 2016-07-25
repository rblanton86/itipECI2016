/****************************************************************************
Description: Alters the error logging table.

Author: Jennifer M. Graves

Date: 07/24/2016

Change History:

****************************************************************************/
ALTER TABLE ErrorLog
	ALTER COLUMN errorMessage VARCHAR(500)

ALTER TABLE ErrorLog
	ALTER COLUMN errorProcedure VARCHAR(500)