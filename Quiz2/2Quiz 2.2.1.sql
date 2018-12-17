-- 6
select title, avg(stars) from movie
join rating r on movie.mid = r.mid
group by stars, title
order by stars desc, title asc;

-- 7
select title, min(stars) from movie
join rating r on movie.mid = r.mid
group by title
order by title;

-- 8
select name from reviewer
join rating r on reviewer.rid = r.rid
where stars isnull ;

-- 9
create materialized view R_MV as
select title from movie
  join rating r on movie.mid = r.mid
  where stars isnull ;


