CREATE Procedure [dbo].[Add_AnswerVersionGroup]
		@Id					Int	= null,
		@AnswerVersionGroup	NVarchar(255),
		@LanguageId			Int
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 3/20/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_AnswerVersionGroup
*
*	Description:
*			
*
*	PARAMETERS: 
*		@Id					Int				= null,
*		@AnswerVersionGroup	NVarchar(255),
*		@LanguageId			Int
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

			Merge	dbo.AnswerOptionGroup q
			Using	(	select	@Id, @AnswerVersionGroup, @LanguageId ) s 
					(	Id, AnswerVersionGroup, LanguageId ) on 
						q.Id = s.Id
			When Matched 
				Then Update Set q.AnswerVersionGroup	= s.AnswerVersionGroup,
								q.LanguageId		= s.LanguageId
			When Not Matched 
				Then Insert (AnswerVersionGroup, LanguageId )
					Values (s.AnswerVersionGroup, s.LanguageId );
					Select IsNull(@Id,SCOPE_IDENTITY())  AnswerOptionGroupId
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




