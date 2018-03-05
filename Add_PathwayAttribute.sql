
CREATE Procedure [dbo].[Add_PathwayAttribute]
		 @Id					Int	= null
		,@OrganizationId		Int
		,@PathwayId				Int = null
		,@PathwayAttribute		NVarchar (max)	= ''
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 10/15/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	dbo.Add_PathwayAttribute
*
*	Description:
*			
*
*	PARAMETERS: 
*
* Exec [dbo].[Add_OrderSetAttribute]
*		 @Id					Int	= null
*		,@OrganizationId		Int
*		,@PathwayId				Int = null
*		,@PathwayAttribute		NVarchar (max)	= ''
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
* 	Date			Name				Ref: Ticket		Text
*********************************************************************/
	Begin Try
		Declare @i	Int

					Merge	dbo.PathwayAttribute q
					Using	(	select	 @Id, @OrganizationId, @PathwayId, @PathwayAttribute ) s 
							(	Id, OrganizationId, PathwayId, PathwayAttribute  ) on 
								q.Id = s.Id
					When Matched 
						Then Update Set 	
										q.PathwayAttribute	= s.PathwayAttribute,
										q.EditedOn			= getdate()
					When Not Matched 
						Then Insert ( OrganizationId, PathwayId, PathwayAttribute)
							Values ( s.OrganizationId, s.PathwayId, s.PathwayAttribute);

						Select IsNull(@Id, SCOPE_IDENTITY()) PathwayAttributeId
	End Try  
	Begin Catch
		-- Roll back any active or uncommittable transactions before
		--If Xact_State() <> 0
		--	Rollback Transaction;
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		Throw;
			Return @i
	End Catch
