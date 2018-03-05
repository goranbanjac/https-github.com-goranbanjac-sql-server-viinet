
CREATE Procedure [dbo].[Add_OrderAction]
		 @OrganizationId	Int	
		,@PathwayId			Int	
		,@StrEventCodeId	NVarchar ( 1000 )
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/03/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_OrderAction
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		 @OrganizationId	Int	
*		,@PathwayId			Int	
*		,@StrEventCode		NVarchar ( 5000 )
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

		Insert dbo.PathwayToEventCode ( OrganizationId, PathwayId, EventCode )
		Select @OrganizationId, @PathwayId, s.Value
		From  dbo.SplitStrings_Native (@StrEventCodeId, ',' ) s

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch

