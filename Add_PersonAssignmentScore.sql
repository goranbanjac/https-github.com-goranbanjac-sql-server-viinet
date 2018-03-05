
CREATE Procedure [dbo].[Add_PersonAssignmentScore]
		 @PersonAssignmentId	BigInt	= null
		,@ActivityId			Int	
		,@OrderSetId			BigInt
		,@Section				NVarchar(50)
		,@OutcomeScore			Decimal(10,2)
		,@OrderSetName			NVarchar (500)	
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/03/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_PersonAssignmentScore
*
*	Description:
*			
*
*	PARAMETERS: 
*
*			 @Id					Int = Null
*			,@PersonAssignmentId		Int	
*			,@ActivityId			Int	
*			,@OrderSetId			BigInt
*			,@Section				Varchar(50)
*			,@OutcomeScore			decimal(10,2)
*			,@OrderSetName			Varchar (500)
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int
 
				merge	dbo.PersonAssignmentScore p
				using	(	select	@PersonAssignmentId,@ActivityId,@OrderSetId,@Section,@OutcomeScore, @OrderSetName  ) s 
						(	PersonAssignmentId, ActivityId, OrderSetId, Section, OutcomeScore, OrderSetName ) on 
							p.PersonAssignmentId = s.PersonAssignmentId 
				when matched 
					then update set 
									 p.OutcomeScore		= s.OutcomeScore
									,p.OrderSetName		= s.OrderSetName
									,p.EditedOn			= getdate()
				when not matched 
					then insert ( PersonAssignmentId, ActivityId, OrderSetId, Section, OutcomeScore, OrderSetName  )
						values ( s.PersonAssignmentId, s.ActivityId, s.OrderSetId, s.Section, s.OutcomeScore, s.OrderSetName );

			--	Select IsNull(@Id,SCOPE_IDENTITY()) PersonAssignmentScoreId

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
