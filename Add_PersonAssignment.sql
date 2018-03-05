

CREATE Procedure [dbo].[Add_PersonAssignment]
		 @Id					Int = Null
		,@OrganizationId		Int	
		,@PathwayId				Int	
		,@PersonId				BigInt
		,@EncounterId			NVarchar(50)
		,@Activities			NVarchar(max) = ''
		,@AnswerGroups			NVarchar(max) = ''
		,@Results				NVarchar(max) = ''
		,@IsCompleted			Bit
		,@AssignmentAttributes	NVarchar ( 1000 )
		,@Pathways				NVarchar(max) = ''	
		,@Progress				NVarchar (max)
		,@DeviceActivitiesMap	NVarchar (4000) = null
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/03/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_PersonAssignment
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		 @Id					Int = Null
*		,@OrganizationId		Int	
*		,@PathwayId				Int	
*		,@PersonId				BigInt
*		,@EncounterId			Varchar(50)
*		,@Activities			Varchar(max) = ''
*		,@AnswerGroups			Varchar(max) = ''
*		,@Results				Varchar(max) = ''
*		,@IsCompleted			Bit
*		,@EnrollmentAttributes	Varchar ( 1000 )
*		,@Pathways				Varchar(max) = ''	
*		,@Progress				Varchar (max)
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i					 Int,
				@PersonAssignmentId  Int,
				@PersonAttribute	 NVarchar( 1000 )

					If exists ( Select 1 From dbo.PersonAssignment Where OrganizationId = @OrganizationId And PersonId = @PersonId And PathwayId = @PathwayId )
						Throw 50001, N'Pathway already exist for given Person and Organization', 1; 
 
				merge	dbo.PersonAssignment p
				using	(	select	@Id, @OrganizationId, @PathwayId, @PersonId, @EncounterId, @IsCompleted, @AssignmentAttributes,@Activities,@AnswerGroups,@Results,@Pathways, @Progress  ) s 
						(	Id, OrganizationId, PathwayId, PersonId, EncounterId, IsCompleted, AssignmentAttributes, Activities, AnswerGroups, Results, Pathways, Progress  ) on 
							p.Id = s.Id 
				when matched 
					then update set 
									 p.IsCompleted			= s.IsCompleted
									,p.AssignmentAttributes = s.AssignmentAttributes
									,p.Activities			= s.Activities
									,p.AnswerGroups			= s.AnswerGroups 
									,p.Results				= s.Results 
									,p.Pathways				= s.Pathways
									,p.Progress				= s.Progress
									,p.EditedOn				= getdate()
				when not matched 
					then insert ( OrganizationId, PathwayId, PersonId, EncounterId, IsCompleted, AssignmentAttributes, Activities, AnswerGroups, Results, Pathways, Progress  )
						values (s.OrganizationId, s.PathwayId, s.PersonId, s.EncounterId, s.IsCompleted, s.AssignmentAttributes, s.Activities, s.AnswerGroups, s.Results, s.Pathways, s.Progress );

				Select @PersonAssignmentId = IsNull(@Id,SCOPE_IDENTITY()) 
				Select @PersonAssignmentId PersonAssignmentId

			-- Add data for provider app
			If @Id Is Null
				Begin
					SET @PersonAttribute = ( SELECT FirstName, LastName, Gender, DateOfBirth, PrimaryEmailAddress from dbo.Person Where Id = @PersonId for JSON PATH ) 
					-- select Replace(Replace(@PersonAttribute, '[',''''),']','''')
					Exec[dbo].[Add_ProviderAssignment]
						 @PersonId				= @PersonId	
						,@PersonAssignmentId	= @PersonAssignmentId	
						,@PersonAttribute		= @PersonAttribute
				End

				If @DeviceActivitiesMap Is Not Null
					Begin
						If @Id is Null
							Insert dbo.PersonPathwayDevice ( PersonAssignmentId, PersonId, DeviceActivitiesMap )
							Values ( @PersonAssignmentId, @PersonId, @DeviceActivitiesMap )
						Else
							Update dbo.PersonPathwayDevice
							Set DeviceActivitiesMap = @DeviceActivitiesMap,
								EditedOn			= GetDate()
							Where PersonAssignmentId = @Id
					End


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
