CREATE Procedure [dbo].[Add_AnswerVersionChoice]
		@Id						Int	= null,
		@AnswerVersionGroupId	Int,
		@VersionChoiceName		NVarchar(150),
		@SortOrder				int = null
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 3/20/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_AnswerVersionChoice
*
*	Description:
*			
*
*	PARAMETERS: 
*		@Id						Int	= null,
*		@AnswerVersionGroupId	Int,
*		@VersionChoiceName		NVarchar(150),
*		@SortOrder				int = null
*
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

			Select @Id = Id From dbo.AnswerVersionChoice Where AnswerVersionGroupId = @AnswerVersionGroupId and VersionChoicesName = @VersionChoiceName

				Merge	dbo.AnswerVersionChoice q
				Using	(	select	@Id, @AnswerVersionGroupId, @VersionChoiceName, @SortOrder ) s 
						(	Id, AnswerVersionGroupId, VersionChoicesName, SortOrder ) on 
							q.Id = s.Id
				When Matched 
					Then Update Set q.AnswerVersionGroupId	= s.AnswerVersionGroupId,
									q.VersionChoicesName	= s.VersionChoicesName,
									q.SortOrder				= s.SortOrder
				When Not Matched 
					Then Insert ( AnswerVersionGroupId, VersionChoicesName, SortOrder )
						Values (s.AnswerVersionGroupId, s.VersionChoicesName, s.SortOrder );
						Select SCOPE_IDENTITY() -- ONLY FOR DEV NOT FOR QA AND PROD
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
RETURN 0

