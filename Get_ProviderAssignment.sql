
CREATE Procedure [dbo].[Get_ProviderAssignment]
		 @PersonId				Int	
		,@PersonAssignmentId	Int	
		
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 11/07/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Get_ProviderAssignment
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		 @PersonId				Int	
*		,@PersonAssignmentId	Int	
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

				
				Select
				     PersonId                    
					,PersonAssignmentId       
					,PersonAttribute        
					,RiskLevel                
					,ActivityStatus       
					,Notes 
					,ProviderActivity	
				From dbo.ProviderAssignment 
				Where PersonId			 = @PersonId
				And   PersonAssignmentId = @PersonAssignmentId

	End Try  
	Begin Catch
		-- Roll back any active or uncommittable transactions before
		If Xact_State() <> 0
			Rollback Transaction;
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch