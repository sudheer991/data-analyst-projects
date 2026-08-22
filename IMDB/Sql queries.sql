use project_movie_database;
#a.Can you get all data about movies? 
select*from directors;        

#b.How do you get all data about directors?
select*from movies;					

#c.Check how many movies are present in IMDB.
select count(id) from movies;		

#d.Find these 3 directors: James Cameron ; Luc Besson ; John Woo
select id,`name` from directors 
where `name` in ('james cameron','Luc besson','John woo');			

#e.Find all directors with name starting with S.
select id,`name` from directors where `name` like "s%";				

#f.Count female directors.
select count(gender) from directors where gender=1;					

#g.Find the name of the 10th first women directors?
select `name` from directors where gender=1 order by `name` desc limit 1 offset 9;
		
#h.What are the 3 most popular movies?
select original_title, popularity from movies order by popularity desc limit 3;		

#i.What are the 3 most bankable movies?
select original_title,sum(revenue)/sum(budget) as bankable 
from movies group by id order by bankable desc limit 3;	
			
#j.	What is the most awarded average vote since the January 1st, 2000?
select * from movies where release_date>'2000-01-01' 
order by vote_average desc limit 1;						

#k.	Which movie(s) were directed by Brenda Chapman?
select	d.`name`,d.id,m.original_title from directors as d
left join movies as m on d.id=m.director_id
where d.`name`='Brenda Chapman';								

#L.	Which director made the most movies?
select	d.id,d.`name`,count(m.id) as movie_count from directors as d
join movies as m on d.id=m.director_id
group by d.id order by movie_count desc limit 1;			

#m.	Which director is the most bankable?
select d.id,d.`name`,(sum(m.revenue)/sum(m.budget)) as profit_ratio from directors as d
join movies as m on d.id=m.director_id 
group by d.id order by profit_ratio desc limit 1; 

		


