CREATE Procedure [dbo].[GetUserFromEmailToken]
	 @EmailToken NVarchar(50)
AS
SET NOCOUNT ON
/*********************************************************************
--* ======================================================================
--*  Author: Gran Banjac 
--*  Date Created: 4/20/2017
--*  VSS: 
--*=======================================================================
*
*	File Name:	GetUserFromEmailToken
*
*	Description:
*			
*
*	PARAMETERS: 
*			
*	Change Log (Date, Name and Ddescription)
*	--------------------------------------------------------
*	Modification History:
*  
*********************************************************************/
BEGIN TRY
DECLARE @i INT

		SELECT  u.[SECU_User_ID] AS userId,
				[User_Login_ID] AS loginId,
				[User_Pwd_Hash] AS pwdHash,
				[User_Pwd_Salt] AS pwdSalt,
				[Pwd_Expiration_Date] AS pwdExp,
				[First_Name] AS firstName,
				[Last_Name] AS lastName,
				[Email] AS email,
				[Alt_Email] AS altEmail,
				[Is_Sys_Admin] AS isAdmin,
				[Is_Locked] AS isLocked,
				[Must_Change_Pwd] AS changePwd,
				u.[Created_Date] AS createdDate,
				u.[Valid_Date] AS validDate,
				u.[End_Date] AS endDate,
				[Home_Org_ID] AS homeorgId,
				[Home_Page] as homePage,
				u.NPI,
				u.User_Attributes,
				u.Gender,
				@EmailToken Email_Token,
				ou.UserTypeId
		FROM	[SECU_User] u 
		left join [SECU_Organization_User] ou on ou.[SECU_User_ID] = u.[SECU_User_ID]
		WHERE [Email_Token] = @EmailToken

END TRY
BEGIN CATCH
	-- inserting information in the ErrorLog.	
	Exec @i = dbo.usp_LogError; --@ErrorLogID = @ErrorLogID OUTPUT;
	Throw;
	Return @i
END CATCH
RETURN 0
