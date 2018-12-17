-- 6
select name from reviewer
join rating on reviewer.rid = rating.rid
group by reviewer.rid
having count(*) >= 3;

-- 7
select title, max(stars) from Movie
join rating on Movie.mid = rating.mid
group by title
order by title;

-- 8
select name from reviewer
join rating r on reviewer.rid = r.rid
where ratingDate isnull ;

-- 9
create materialized view SS_MV as
select title from movie
  join rating on movie.mid = rating.mid
  where rating isnull ;



