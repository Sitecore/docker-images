/* Rebuild Descendants Commerce SIF task. Query taken from the Sitecore.Data.SqlServer.SqlServerDataProvider.RebuildDescendants() method. */
DECLARE @descendants TABLE (
  [Ancestor] [uniqueidentifier] NOT NULL,
  [Descendant] [uniqueidentifier] NOT NULL,
  PRIMARY KEY([Ancestor], [Descendant])
);

WITH TempSet([Ancestor], [Descendant]) AS
(
  SELECT
    [Items].[ParentID],
    [Items].[ID]
  FROM
    [Items]
  UNION ALL
  SELECT
    [Items].[ParentID],
    [TempSet].[Descendant]
  FROM
    [Items] JOIN [TempSet]
      ON [TempSet].[Ancestor] = [Items].[ID]
)
INSERT INTO @descendants([Ancestor], [Descendant])
SELECT
  [TempSet].[Ancestor],
  [TempSet].[Descendant]
FROM
  [TempSet]
OPTION (MAXRECURSION 32767)
MERGE [Descendants] AS [Target]
USING @descendants AS [Source]
ON (
  [Target].[Ancestor] = [Source].[Ancestor]
  AND [Target].[Descendant] = [Source].[Descendant]
)
WHEN NOT MATCHED BY TARGET THEN
  INSERT ([ID], [Ancestor], [Descendant])
  VALUES (NEWID(), [Source].[Ancestor], [Source].[Descendant])
WHEN NOT MATCHED BY SOURCE THEN
  DELETE;