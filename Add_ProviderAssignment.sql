
CREATE Procedure [dbo].[Add_ProviderAssignment]
		 @PersonId				Int	
		,@PersonAssignmentId	Int	
		,@PersonAttribute		NVarchar(1000) = ''
		,@RiskLevel				Int = null
		,@ActivityStatus		NVarchar(1000) = ''
		,@Notes					NVarchar(max)  = ''
		,@ProviderActivity		NVarchar( max ) = ''
		
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 11/07/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_ProviderAssignment
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		 @PersonId				Int	
*		,@PersonAssignmentId	Int	
*		,@PersonAttribute		NVarchar(1000) = ''
*		,@RiskLevel				NVarchar(1000) = ''
*		,@ActivityStatus		NVarchar(1000) = ''
*		,@Notes					NVarchar(max)  = ''
*		,@ToDoList				NVarchar( 1000 ) = ''
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

				merge	dbo.ProviderAssignment p
				using	(	select	@PersonId, @PersonAssignmentId, @PersonAttribute, @RiskLevel, @ActivityStatus, @Notes, @ProviderActivity ) s 
						(	PersonId, PersonAssignmentId, PersonAttribute, RiskLevel, ActivityStatus, Notes, ProviderActivity ) on 
							p.PersonId				= s.PersonId
						And	p.PersonAssignmentId	= s.PersonAssignmentId
				when matched 
					then update set 
									 p.PersonAttribute	= IsNull(s.PersonAttribute, p.PersonAttribute),
									 p.RiskLevel		= IsNull(s.RiskLevel, p.RiskLevel ),
									 p.ActivityStatus	= IsNull(s.ActivityStatus,  p.ActivityStatus ),
									 p.Notes			= IsNull(s.Notes, p.Notes),
									 p.ProviderActivity	= IsNull(s.ProviderActivity, p.ProviderActivity),
									 p.EditedOn			= getdate()
				when not matched 
					then insert (PersonId, PersonAssignmentId, PersonAttribute, RiskLevel, ActivityStatus, Notes, ProviderActivity )
						values (s.PersonId, s.PersonAssignmentId, s.PersonAttribute, s.RiskLevel, s.ActivityStatus, s.Notes, s.ProviderActivity);

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
