
Create Procedure [dbo].[Delete_PathwayToEventCode]
		 @OrganizationId Int
		,@PathwayId Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/03/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Delete_PathwayToEventCode
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		 @OrganizationId Int
*		,@PathwayId Int
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

		Delete dbo.PathwayToEventCode where OrganizationId = @OrganizationId And PathwayId = @PathwayId

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
