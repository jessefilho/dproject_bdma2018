-- 1. Number and Average of released songs disaggregating by genre, year , location
and artist .

WITH
SET [~COLUMNS] AS
    {[DimReleaseDateSong.ReleaseMonthYear].[2016], [DimReleaseDateSong.ReleaseMonthYear].[2017], [DimReleaseDateSong.ReleaseMonthYear].[2018]}
MEMBER [Measures].[Avg Songs] AS
    Avg([Measures].[CountSongs]), FORMAT_STRING = "#,##0.00"
SET [~ROWS_DimGenre_DimGenre.Genre] AS
    {[DimGenre.Genre].[genre].Members}
SET [~ROWS_DimSong_DimSong.ReleaseCountry] AS
    Except({[DimSong.ReleaseCountry].[ReleaseCountry].Members}, {[DimSong.ReleaseCountry].[0], [DimSong.ReleaseCountry].[240]})
SET [~ROWS_DimArtist_DimArtist.OriginArtist] AS
    {[DimArtist.OriginArtist].[Artist].Members}
SELECT
NON EMPTY CrossJoin([~COLUMNS], {[Measures].[CountSongs], [Measures].[Avg Songs]}) ON COLUMNS,
NON EMPTY NonEmptyCrossJoin([~ROWS_DimGenre_DimGenre.Genre], NonEmptyCrossJoin([~ROWS_DimSong_DimSong.ReleaseCountry], [~ROWS_DimArtist_DimArtist.OriginArtist])) ON ROWS
FROM [Popularity Song Cube]

 --2. The biggest/ lowest number of released songs by location , genre , year and artist .


 -- 3. Number of artists disaggregating by origins.
WITH SET [~ROWS] AS 'Order(TopCount({[Origins.Locations].[Country].Members}, 10.0), [Measures].[Quantity artist], DESC)' SELECT NON EMPTY {[Measures].[Quantity artist]} ON COLUMNS, NON EMPTY [~ROWS] ON ROWS FROM [Artist Popularity]

-- 4. Number of artists appeared every year in the music industry.

-- by release date song
WITH
SET [~FILTER] AS
    {[DimArtist.OriginArtist].[Artist].Members}
SET [~ROWS] AS
    Order({[DimReleaseDateSong.ReleaseMonthYear].[2016], [DimReleaseDateSong.ReleaseMonthYear].[2017], [DimReleaseDateSong.ReleaseMonthYear].[2018]}, [Measures].[CountSongs], DESC)
SELECT
NON EMPTY {[Measures].[CountSongs]} ON COLUMNS,
NON EMPTY [~ROWS] ON ROWS
FROM [Popularity Song Cube]
WHERE [~FILTER]

-- 5. Number of songs or artists that achieved a certain popularity.
WITH
SET [~ROWS] AS
    Order(Filter({[Artists Groups.Name].[Name].Members}, (([Measures].[Avg Popularity ] >= 65) AND ([Measures].[Avg Popularity ] <= 75))), [Measures].[Max Popularity], DESC)
SELECT
NON EMPTY {[Measures].[Max Popularity], [Measures].[Quantity artist]} ON COLUMNS,
NON EMPTY [~ROWS] ON ROWS
FROM [Artist Popularity]

-- 6. The average popularity of the songs where artists participated to analyze
-- artist's performance.

WITH
SET [~ROWS] AS
    Order({[DimArtist.OriginArtist].[Artist].Members}, [Measures].[MaxPopularity], DESC)
SELECT
NON EMPTY {[Measures].[AvgPopularity]} ON COLUMNS,
NON EMPTY [~ROWS] ON ROWS
FROM [Popularity Song Cube]

-- 7. What is the less popular songs by country and find out why ?
WITH
SET [~DimSong_DimSong.ReleaseCountry_ReleaseCountry] AS
    Except({[DimSong.ReleaseCountry].[ReleaseCountry].Members}, {[DimSong.ReleaseCountry].[0], [DimSong.ReleaseCountry].[240]})
SET [~DimSong_DimSong.ReleaseCountry_SongName] AS
    Exists({[DimSong.ReleaseCountry].[SongName].Members}, [~DimSong_DimSong.ReleaseCountry_ReleaseCountry])
SET [~ROWS] AS
    Order(Hierarchize({[~DimSong_DimSong.ReleaseCountry_ReleaseCountry], [~DimSong_DimSong.ReleaseCountry_SongName]}), [Measures].[MinPopularity], ASC)
SELECT
NON EMPTY {[Measures].[MinPopularity]} ON COLUMNS,
NON EMPTY [~ROWS] ON ROWS
FROM [Popularity Song Cube]

-- 8. What is the impact of cover art on success of an album? Number of recorded
-- covers disaggregating by artist and song .
It is not possible to measure that because of Saiku limitation.

-- 9. The most covered songs by artist and song .
WITH
SET [~ROWS] AS
    Order({[Artists Groups.Name].[Name].Members}, [Measures].[Sum release covered], DESC)
SELECT
NON EMPTY {[Measures].[Sum release covered]} ON COLUMNS,
NON EMPTY [~ROWS] ON ROWS
FROM [Song]

--10. Artists that are most engaged in the last years.
It is not possible to measure that, because we did not put popularity artist/group on Song Cube...

-- 11. What makes a top performer based on songs `s technical features?
It is not possible to measure that, because we did not put popularity artist/group on Song Cube...