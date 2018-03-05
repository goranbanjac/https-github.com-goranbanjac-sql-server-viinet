
CREATE PROCEDURE [dbo].[Get_PathwayActionTime]
				@ActionDateTime DateTime
As
Set NoCount On
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/30/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_PathwayActionTime
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		@ActionDateTime DateTime
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
Begin Try
	Declare @i  Int;

		Declare @cte Table ( 
							PersonAssignmentId	Int,
							ActionDateTime		DateTime,
							ActivityJson		Varchar (1000),
							TriggerTypeId		Int
							);

			;with cte as 
					(
					select PersonAssignmentId, ActionDateTime, ActivityJson, TriggerTypeId
					from dbo.PathwayActionTime where ActionDateTime < @ActionDateTime
					)
					delete from cte
					output deleted.PersonAssignmentId,
						   deleted.ActionDateTime,
						   deleted.ActivityJson,
						   deleted.TriggerTypeId
					into @cte;

					select * from @cte

					Insert dbo.PathwayActionTimeHistory
							( 
								PersonAssignmentId, ActionDateTime, ActivityJson, TriggerTypeId, IsProcessed, ServiceTime 
							)
					Select 
								PersonAssignmentId, ActionDateTime, ActivityJson, TriggerTypeId, 1, GetDate ()
					From
							@cte
End Try
Begin Catch
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	-- Call procedure to print error information.
	Throw;
	Return @i
End Catch
RETURN 0
