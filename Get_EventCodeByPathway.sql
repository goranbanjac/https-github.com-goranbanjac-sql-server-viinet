 
CREATE Procedure [dbo].[Get_EventCodeByPathway]
				@PathwayId		Int,
				@OrganizationId Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/26/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_PathwayByEventCode
*
*	Description:
*			
*
*	PARAMETERS: 
*			
*		@PathwayId		Int,
*		@OrganizationId Int
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int;

			with cte as 
				(
					Select EventCode From dbo.PathwayToEventCode Where OrganizationId = @OrganizationId And PathwayId = @PathwayId
				)
					Select Id EventCodeId From dbo.EventCode ec
					Inner Join cte cte On
						ec.EventCode = cte.EventCode
	
	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
