
 
CREATE Procedure [dbo].[Get_Actions]
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/03/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_Actions
*
*	Description:
*			
*
*	PARAMETERS: 
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

		Select * From dbo.ActionTypes

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch