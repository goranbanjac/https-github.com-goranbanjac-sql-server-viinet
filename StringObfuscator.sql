CREATE Procedure [dbo].[StringObfuscator] ( @OriginalString NVarchar (50) )
--RETURNS NVarchar(2) 
AS SET NOCOUNT ON
BEGIN
   DECLARE @POS INT;
   DECLARE @NewString NVarchar (50);
   DECLARE @CurChar INT;
   DECLARE @NewChar INT; 

   SELECT @POS = 1;
   SELECT @NewString = '';
 
  WHILE (@POS <= LEN(@OriginalString))
  BEGIN
     SELECT @CurChar = ASCII(SUBSTRING(@OriginalString,@POS,1)); -- Use ORD so we get the UTF-8 Encoding of the char for Multibyte if used
		SELECT 
			@NewChar = 
						CASE 
     						WHEN @CurChar >= 65 AND @CurChar <= 90 THEN -- A-Z
     							FLOOR( 65 + RAND() * (90 - 65 + 1))
     						WHEN @CurChar >= 97 AND @CurChar <= 122 THEN -- a-z
     							FLOOR(97 + RAND() * (122 - 97 + 1))
     						WHEN @CurChar >= 48 AND @CurChar <= 57 THEN -- 0-9
     							FLOOR(48 + RAND() * (57 - 48 + 1))
     						--WHEN @CurChar >= 55424 AND @CurChar <= 56255 THEN -- Arabic Characters (in UTF-8)
     			-- Use Random characters from the Arabic Character Set - U0x600 - U0x6ff
     			-- Math is Funky for this
     						--ASCII(CONVERT(CHAR(FLOOR(1536 + RAND() * (1791 - 1536 + 1)) using 'ucs2') USING 'utf8'));
     					ELSE 
     						@CurChar
						END;

		SET @NewString = CONCAT(@NewString, CHAR(@NewChar));
		SET @POS = @POS + 1;  
   END 

   SELECT @NewString;

END; 
