
Create Procedure [dbo].[Add_OrganizationSpecialtiesUser]
		 @Id						int	= null
		,@OrganizationSpecialtieId	int
		,@SECU_User_ID				int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 5/25/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_OrganizationSpecialtiesUser
*
*	Description:
*			
*
*	PARAMETERS: 
*		@Id					int	= null
*		,@OrganizationId	int
*		,@Specialties		Varchar(100)
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i						Int		
	
			If Exists ( Select 1 From dbo.OrganizationSpecialtiesUser Where OrganizationSpecialtieId = @OrganizationSpecialtieId And SECU_User_ID = @SECU_User_ID)
				Throw 50001, N'This relationship already exist', 1

					Merge	dbo.OrganizationSpecialtiesUser q
					Using	(	select	@Id, @OrganizationSpecialtieId, @SECU_User_ID ) s 
							(	Id, OrganizationSpecialtieId, SECU_User_ID ) on 
								q.Id = s.Id
					When Matched 
						Then Update Set q.OrganizationSpecialtieId	= s.OrganizationSpecialtieId,
										q.SECU_User_ID	   = s.SECU_User_ID
					When Not Matched 
						Then Insert ( OrganizationSpecialtieId, SECU_User_ID )
							Values (s.OrganizationSpecialtieId, s.SECU_User_ID );	

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
