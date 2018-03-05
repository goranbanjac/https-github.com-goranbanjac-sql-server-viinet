
CREATE Procedure [dbo].[Add_StakeHolderGroup]
		 @Id					Int = null,
		 @OrganizationId		Int,
		 @GroupName				NVarchar(50),
		 @StakeHoldersTypeId	Int

As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/03/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_StakeHolderGroup
*
*	Description:
*			
*
*	PARAMETERS: 
*
*		 @Id					Int = null,
*		 @OrganizationId		Int,
*		 @GroupName				NVarchar(50),
*		 @StakeHoldersTypeId	Int
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

		merge	dbo.StakeHolderGroup p
				using	(	select	@Id,  @OrganizationId, @GroupName, @StakeHoldersTypeId ) s 
						(	Id, OrganizationId, GroupName, StakeHoldersTypeId ) on 
							p.Id = s.Id 
				when matched 
					then update set 
									 p.GroupName			= s.GroupName
									,p.StakeHoldersTypeId	= s.StakeHoldersTypeId
									,p.EditedOn				= getdate()
				when not matched 
					then insert ( OrganizationId, GroupName, StakeHoldersTypeId )
						values ( s.OrganizationId, s.GroupName, s.StakeHoldersTypeId );

		Select IsNull(@Id,SCOPE_IDENTITY()) StakeHolderGroupId 

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
