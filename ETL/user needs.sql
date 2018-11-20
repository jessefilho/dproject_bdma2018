SELECT  count (distinct datamarts.dim_artistgroup.artistgroup), cityoriginartist, countryoriginartist, typegroup, datamarts.fct_popularityartist.popularityartist
FROM datamarts.dim_artistgroup, datamarts.fct_popularityartist
where datamarts.dim_artistgroup.id_artistgroup =  datamarts.fct_popularityartist.id_artistgroup AND datamarts.fct_popularityartist.popularityartist  > 80
order by datamarts.fct_popularityartist.popularityartist desc;




-- Number of songs that achieved a certain popularity.

SELECT  count (distinct datamarts.dim_artistgroup.id_artistgroup)
FROM datamarts.dim_artistgroup, datamarts.fct_popularityartist
where datamarts.dim_artistgroup.id_artistgroup =  datamarts.fct_popularityartist.id_artistgroup 
AND datamarts.fct_popularityartist.popularityartist  > 60

-- What makes a top performer based on songs `s technical features?



