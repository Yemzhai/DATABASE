create table Movie(
  mid serial primary key ,
  title varchar(50),
  year int,
  director varchar(50)
);

create table reviewer(
  rid serial primary key ,
  name varchar(50)
);

create table rating(
  rid int references reviewer(rid),
  mid int references Movie(mid),
  stars int,
  ratingDate date
);

insert into Movie values
                         (101, 'Gone with the Wind', 1939, 'Victor Fleming'),
                         (102, 'Star Wars', 1977, 'George Lucas'),
                         (103, 'The Sound of Music', 1965, 'RObert Wise'),
                         (104, 'E.T.', 1982, 'Steven Spielberg'),
                         (105, 'Titanic', 1997, 'James Cameron'),
                         (106, 'Snow White', 1937, null),
                         (107, 'Avatar', 2009, 'James Cameron'),
                         (108, 'Raiders of tje Lost Ark', 1981, 'Steven Spielberg');

insert into reviewer values
                            (201, 'Sarah Martinez'),
                            (202, 'Daniel Lewis'),
                            (203, 'Brittany Harris'),
                            (204, 'Mike Anderson'),
                            (205, 'Chris Jackson'),
                            (206, 'Elizabeth Thomas'),
                            (207, 'James Cameron'),
                            (208, 'Ashley White');

insert into rating values
                          (201, 101, 2, '2011-01-22'),
                          (201, 101, 4, '2011-01-27'),
                          (202, 106, 4, null ),
                          (203, 103, 2, '2011-01-20'),
                          (203, 108, 4, '2011-01-12'),
                          (203, 108, 2, '2011-01-30'),
                          (204, 101, 3, '2011-01-09'),
                          (205, 103, 3, '2011-01-27'),
                          (205, 104, 2, '2011-01-22');
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
create view SS_V as
select title from Movie
  where director = 'Steven Spielberg';






