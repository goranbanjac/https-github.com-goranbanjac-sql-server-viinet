 
Create Procedure [dbo].[Get_EventCodes]
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/26/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_EventCode
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

		Select eg.Id EventGroupId, eg.EventGroupName, esg.Id EventSubGroupId, esg.EventSubGroupName, ec.Id EventCodeId, ec.EventName, ec.EventCode
		From dbo.EventGroup eg
		Inner Join dbo.EventSubGroup esg On
			eg.Id = esg.EventGroupId
		Inner join dbo.EventCode ec On
			esg.Id = ec.EventSubGroupId

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch

