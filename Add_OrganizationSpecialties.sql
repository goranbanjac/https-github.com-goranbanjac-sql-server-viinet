
CREATE Procedure [dbo].[Add_OrganizationSpecialties]
		 @Id				int	= null
		,@OrganizationId	int
		,@Specialties		NVarchar(100)
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 5/25/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_OrganizationSpecialties
*
*	Description:
*			
*
*	PARAMETERS: 
*		@Id					int	= null
*		,@OrganizationId	int
*		,@Specialties		NVarchar(100)
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i						Int		
	
			If Exists ( Select 1 From dbo.OrganizationSpecialties Where OrganizationId = @OrganizationId And Specialties = @Specialties)
				Throw 50001, N'This Specialties already exist for given Organization', 1

					Merge	dbo.OrganizationSpecialties q
					Using	(	select	@Id, @OrganizationId, @Specialties ) s 
							(	Id, OrganizationId, Specialties ) on 
								q.Id = s.Id
					When Matched 
						Then Update Set q.OrganizationId	= s.OrganizationId,
										q.Specialties	   = s.Specialties
					When Not Matched 
						Then Insert ( OrganizationId, Specialties )
							Values (s.OrganizationId, s.Specialties );	

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
