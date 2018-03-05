
CREATE Procedure [dbo].[Add_PathwayActionTime]
		  @PersonAssignmentId	Int
		 ,@ActivityJson			NVarchar ( 1000 )
		 ,@ActionDateTime		DateTime
		 ,@TriggerTypeId		Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/03/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_PathwayActionTime
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		  @PathwayActionTime Int
*		 ,@StrActionDateTime NVarchar ( 1000 )
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

				insert dbo.PathwayActionTime ( PersonAssignmentId, ActivityJson, ActionDateTime, TriggerTypeId )
				select @PersonAssignmentId, @ActivityJson, @ActionDateTime, @TriggerTypeId

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch

