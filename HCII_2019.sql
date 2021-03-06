select PostId, count(PostId) Count_PostId,
posts.creationdate, posts.creationdate + 365 OneYearPostCreationDate, DATEDIFF(day,posts.creationdate,posts.closeddate) as dayscount,
posts.acceptedanswerid as AnsweredById,
posts.score, posts.viewcount, posts.answercount, posts.favoritecount, votetypeid
into #temp
from votes join postsÊ
on votes.postid = posts.id
where votetypeid = 2
and votes.creationdate <= posts.creationdate + 365
and posts.tags like '%try-catch%'
and posts.posttypeid='1'
and posts.closeddate<>''
and posts.acceptedanswerid<>''
and posts.score>0
and posts.favoritecount<>''
and DATEDIFF(day,posts.creationdate,posts.closeddate)<8
group by PostId, posts.creationdate, posts.closeddate, acceptedanswerid, posts.Score, posts.viewcount,
posts.AnswerCount, posts.FavoriteCount, posts.id, votetypeid
order by posts.creationdate


update #temp
set favoritecount = 0


update #temp
set favoritecount = c.countt
from
(select postid, count(PostId) as countt from votes tt inner join posts
on tt.postid = posts.id
where tt.votetypeid = 5Ê
and tt.creationdate <= posts.creationdate + 365Ê
and posts.tags like '%try-catch%'
and posts.posttypeid='1'
and posts.closeddate<>''
and posts.acceptedanswerid<>''
and posts.score>0
and posts.favoritecount<>''
and DATEDIFF(day,posts.creationdate,posts.closeddate)<8
group byÊ postid) c
where #temp.postid = c.postid


select * from #temp

