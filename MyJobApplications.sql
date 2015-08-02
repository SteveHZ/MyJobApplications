
CREATE TABLE JobApplications (
		JobNo		INTEGER PRIMARY KEY,
        JobTitle    VARCHAR (64),
        Company     VARCHAR (64),
		Applied		DATE,
        Website    	TEXT ,
        Notes      	VARCHAR (256)
);

---
--- Load some sample data
---
INSERT INTO JobApplications VALUES (1, 'Saving Services', 'Co-op', '2014-06-27', 'http://www.fc-music.com/live-dates','Leek');
INSERT INTO JobApplications VALUES (2, 'Library Assistant','Hanley Library', '2014-07-16', 'http://www.fc-music.com/live-dates','see John');
INSERT INTO JobApplications VALUES (3, 'Administrator', 'Somewhere','2014-08-25','http://www.fc-music.com/live-dates','crap job');
