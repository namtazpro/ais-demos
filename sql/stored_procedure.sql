/****** Object:  StoredProcedure [dbo].[Checkpayload]    Script Date: 22/03/2022 17:58:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[Checkpayload]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    -- Insert statements for procedure here
    SELECT * from Table_1
END
GO


/****** Object:  StoredProcedure [dbo].[CountRows]    Script Date: 22/03/2022 17:58:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[CountRows]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

    -- Insert statements for procedure here
    SELECT Count(*) as Nbofrows from DetailData
END
GO

/****** Object:  StoredProcedure [dbo].[ProcessReport]    Script Date: 22/03/2022 17:58:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[ProcessReport]
(
@filename varchar(200)
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON
	--set @file = 'error_ReportData - v3.xlsx'
	--DECLARE @file varchar(50)
	DECLARE @response int

	IF SUBSTRING(@filename, 1, 5) = 'error'
		SET @response = 0
	else
		SET @response = 1

    -- Insert statements for procedure here
    RETURN @response
END
GO



