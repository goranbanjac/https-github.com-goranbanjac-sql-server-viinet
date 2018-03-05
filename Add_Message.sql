
CREATE Procedure [dbo].[Add_Message]
		@Id				Int		= Null	,
		@OrganizationId Int,
		@MessageName	NVarchar (250)	,
		@TitleSubject	NVarchar (100)	,
		@SenderEmail	NVarchar (50)	,
		@SenderTitle    NVarchar (100)   ,
		@Text			NVarchar (4000)	,
		@IsActive		Bit				,
		@NewMessageId	Int	Output		
As
Set Nocount On;
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 6/16/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	Add_Message
*
*	Description:
*	Exec [dbo].[Add_Message]
*		@Id				= null,
*		@OrganizationId = 1,
*		@MessageName	= 'Login Page' ,
*		@TitleSubject	= 'Login Page' ,
*		@SenderEmail	= 'sender@viimed.com' ,
*		@SenderTitle    = 'Viimed Info' ,
*		@Text			= 'Hello %FirstName, You’re getting this message because you forgot your username. Your username is %UserName. View Login Page. If you did not make this request or need assistance, please click here.' ,
*		@IsActive		= 1 ,
*		@NewMessageId	= null
*
*	PARAMETERS: 
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*********************************************************************/
	Begin Try
		Declare @i	Int

			If @Id Is Null And Exists ( Select 1 From dbo.Message Where OrganizationId = @OrganizationId And MessageName = @MessageName )
				Throw 50001, N'This Message Name already exist for given Organization.', 1;

			Merge	dbo.Message p
			Using	(	select	@Id, @OrganizationId, @MessageName, @TitleSubject, @SenderEmail, @SenderTitle, @Text, @IsActive ) s 
					(	Id, OrganizationId, MessageName, TitleSubject, SenderEmail, SenderTitle, Text, IsActive  ) on 
						p.Id = s.Id 
			When Matched 
				Then Update Set p.MessageName	= s.MessageName, 
								p.TitleSubject	= s.TitleSubject, 
								p.SenderEmail	= s.SenderEmail, 
								p.SenderTitle	= s.SenderTitle, 
								P.Text			= s.Text, 
								P.IsActive		= s.IsActive,
								p.EditedOn		= Getdate()	
			When Not Matched 
				Then Insert (  OrganizationId, MessageName, TitleSubject, SenderEmail, SenderTitle, Text, IsActive )
					 Values ( s. OrganizationId, s.MessageName, s.TitleSubject, s.SenderEmail, s.SenderTitle, s.Text, s.IsActive);
				
					Select @NewMessageId = IsNull(@Id,SCOPE_IDENTITY()) 

	End Try  
	Begin Catch
		-- inserting information in the ErrorLog.	
		Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
		-- Call procedure to print error information.
		Throw;
		Return @i
	End Catch


	

