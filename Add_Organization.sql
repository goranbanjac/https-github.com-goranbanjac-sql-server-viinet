

CREATE Procedure [dbo].[Add_Organization]  
							 @Id						Int				= Null
							,@OrganizationTypeId		Int 
							,@OrganizationName			NVarchar(150)
							,@OrganizationIdentifier	NVarchar(50)		= ''
							,@Address1					NVarchar(250)	= ''
							,@Address2					NVarchar(250)	= ''
							,@City						NVarchar(50)		= ''
							,@State						NVarchar(5)		= ''
							,@ZipCode					NVarchar(5)		= ''
							,@OfficePhone				NVarchar(15)		= ''
							,@OfficeEmail				NVarchar(50)		= ''
							,@ParentOrganizationId		Int				= Null
							,@OwnedOrAffiliated			tinyint	
As
Set NoCount On;
/*********************************************************************
--* ======================================================================
--*  Author: Goran Banjac 
--*  Date Created: 05/11/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_OrganizationRules
*
*	Description:
*			
*
*	PARAMETERS: 
*				@Id						Int	= Null,
*				@OrganizationTypeId		Int ,
*				@OrganizationName		NVarchar(150),
*				@OrganizationIdentifier	NVarchar(50) = '',
*				@Address1				NVarchar(250) = '',
*				@City					NVarchar(50) = '',
*				@State					NVarchar(5) = '',
*				@ZipCode				NVarchar(5) = '',
*				@OfficePhone			NVarchar(15) = '',
*				@OfficeEmail			NVarchar(50) = '',
*				@ParentOrganizationId	Int
*				@OwnedAffiliated			tinyint	
*				
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text													
*********************************************************************/
	Declare @i Int

	Begin Try
			If @OwnedOrAffiliated not in (1,2)
					Throw 50001, N'@OwnedAffiliated parameter has to have value of 1 or 2.', 1;

			Merge dbo.Organization o 
			Using  (Select @Id, @OrganizationTypeId, @OrganizationName, @OrganizationIdentifier, @Address1, @Address2, @City, @State, @ZipCode, @OfficePhone, @OfficeEmail, @ParentOrganizationId, @OwnedOrAffiliated) s 
				   (Id, OrganizationTypeId, OrganizationName, OrganizationIdentifier, Address1, Address2, City, State, ZipCode, OfficePhone, OfficeEmail, ParentOrganizationId, OwnedOrAffiliated ) 
				On o.Id = s.Id 
			When Matched Then 
				Update Set o.OrganizationTypeId		= s.OrganizationTypeId,
						   o.OrganizationName		= s.OrganizationName,
						   o.OrganizationIdentifier	= s.OrganizationIdentifier,
						   o.Address1				= s.Address1,
						   o.Address2				= s.Address2,
						   o.City					= s.City,
						   o.State					= s.State,
						   o.ZipCode				= s.ZipCode,
						   o.OfficePhone			= s.OfficePhone,
						   o.OfficeEmail			= s.OfficeEmail,
						   o.ParentOrganizationId	= s.ParentOrganizationId,
						   o.OwnedOrAffiliated		= s.OwnedOrAffiliated,						
						   o.EditedOn				= GetDate()
			When Not Matched Then
				Insert (OrganizationTypeId, OrganizationName, OrganizationIdentifier, Address1, Address2, City, State, ZipCode, OfficePhone, OfficeEmail, ParentOrganizationId, OwnedOrAffiliated)
				Values (s.OrganizationTypeId, s.OrganizationName, s.OrganizationIdentifier, s.Address1, s.Address2, s.City, s.State, s.ZipCode, s.OfficePhone, s.OfficeEmail, s.ParentOrganizationId, OwnedOrAffiliated);

				Select IsNull(@Id,SCOPE_IDENTITY()) As Id

	End Try 
	Begin Catch
		-- Roll back any active or uncommittable transactions before
		--If Xact_State() <> 0
		--	Rollback Transaction;
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch
RETURN 0

