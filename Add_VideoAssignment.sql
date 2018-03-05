

CREATE Procedure [dbo].[Add_VideoAssignment]
		 @Id				Int = Null
		,@OrganizationId	Int	
		,@PathwayId			Int	
		,@PatientPersonId	bigint 
		,@PhysicianPersonId bigint 
		,@VideoName			NVarchar(250) 
		,@VideoLocation		NVarchar(250) 
		,@VideoAttribute	NVarchar(4000) = ''
		
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 11/07/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_VideoAssignment
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		 @Id				Int = Null
*		,@OrganizationId	Int	
*		,@PathwayId			Int	
*		,@PatientPersonId	bigint 
*		,@PhysicianPersonId bigint 
*		,@VideoName			NVarchar(250) 
*		,@VideoLocation		NVarchar(250) 
*		,@VideoAttribute	NVarchar(4000) = ''
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

				merge	dbo.VideoAssignment p
				using	(	select	@Id, @OrganizationId, @PathwayId, @PatientPersonId, @PhysicianPersonId, @VideoName, @VideoLocation, @VideoAttribute ) s 
						(	Id, OrganizationId, PathwayId, PatientPersonId, PhysicianPersonId, VideoName, VideoLocation, VideoAttribute ) on 
							p.Id = s.Id 
				when matched 
					then update set 
									 p.PathwayId			= s.PathwayId, 
									 p.PatientPersonId		= s.PatientPersonId, 
									 p.PhysicianPersonId	= s.PhysicianPersonId, 
									 p.VideoName			= s.VideoName, 
									 p.VideoLocation		= s.VideoLocation, 
									 p.VideoAttribute		= s.VideoAttribute,
									 p.EditedOn				= getdate()
				when not matched 
					then insert ( OrganizationId, PathwayId, PatientPersonId, PhysicianPersonId, VideoName, VideoLocation, VideoAttribute )
						values (s.OrganizationId, s.PathwayId, s.PatientPersonId, s.PhysicianPersonId, s.VideoName, s.VideoLocation, s.VideoAttribute);

				Select IsNull(@Id,SCOPE_IDENTITY()) VideoAssigmentId

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
