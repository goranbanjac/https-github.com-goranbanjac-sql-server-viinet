 
CREATE  Procedure [dbo].[Get_PersonPathwayDevice]
		@PersonId BigInt
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 1/16/2018
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_PersonPathwayDevice
*
*	Description:
*			
*
*	PARAMETERS: 
*			@PersonId BigInt
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare  @i	Int;

		With cte as
		(
			Select
				  PersonAssignmentId, 
				  DeviceActivitiesMap
			From 
				dbo.PersonPathwayDevice
			Where 
				PersonId = @PersonId
		)
			Select 
				   PersonAssignmentId, 
				   DeviceActivitiesMap, 
				   Results
			From 
				cte c 
			Inner Join
				dbo.PersonAssignment p On
					c.PersonAssignmentId = p.Id

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
