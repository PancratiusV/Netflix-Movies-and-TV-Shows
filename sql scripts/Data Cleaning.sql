update netflix_movies_tvshows  set show_id = cast(substring(show_id from 2) as integer);

alter table netflix_movies_tvshows alter column show_id type integer using show_id::integer;

update netflix_movies_tvshows  set date_added = null where date_added = '';

alter table netflix_movies_tvshows  alter column date_added type date using date_added::date;

alter table netflix_movies_tvshows 
drop column column13,
drop column column14,
drop column column15,
drop column column16,
drop column column17,
drop column column18,
drop column column19,
drop column column20,
drop column column21,
drop column column22,
drop column column23,
drop column column24,
drop column column25,
drop column column26;