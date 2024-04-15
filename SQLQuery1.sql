select distinct Rooms.Name
from Rooms
join Lectures on Lectures.RoomId = Rooms.ID
join Teachers on Lectures.TeacherId = Teachers.ID
where Teachers.Name = 'Edward' and Teachers.Surname = 'Hopper';

select distinct Teachers.Surname
from Teachers
join Lectures on Lectures.TeacherId = Teachers.ID
join GroupsLectures on Lectures.ID = GroupsLectures.LectureId
join Groups on GroupsLectures.GroupId = Groups.ID
where Groups.Name = 'F505' and Teachers.IsProfessor = 0;

select distinct Subjects.Name
from Subjects
join Lectures on Lectures.SubjectId = Subjects.ID
join Teachers on Lectures.TeacherId = Teachers.ID
join GroupsLectures on Lectures.ID = GroupsLectures.LectureId
join Groups on GroupsLectures.GroupId = Groups.ID
where Teachers.Name = 'Alex' and Teachers.Surname = 'Carmack' and Groups.Year = 5;

from Teachers
where Teachers.ID not in (
    select distinct Lectures.TeacherId
    from Lectures
    where DATEPART(dw, Lectures.Date) = 2
);

select distinct CONCAT('Корпус ', Rooms.Building, ', аудиторія ', Rooms.Name) as Room
from Rooms
where Rooms.ID not in (
    select distinct Lectures.RoomId
    from Lectures
    where DATEPART(dw, Lectures.Date) = 4 and DATEPART(wk, Lectures.Date) = 2 and DATEPART(hh, Lectures.Date) = 3
);

select distinct CONCAT(Teachers.Name, ' ', Teachers.Surname) as FullName
from Teachers
join Departments on Teachers.DepartmentId = Departments.ID
join Faculties on Departments.FacultyId = Faculties.ID
where Faculties.Name = 'Computer Science' and Teachers.ID not in (
    select distinct CuratorId
    from GroupsCurators
    join Groups on GroupsCurators.GroupId = Groups.ID
    join Departments as Dep on Groups.DepartmentId = Dep.ID
    where Dep.Name = 'Software Development'
);

select distinct Building
from (
    select Building
    from Departments
    union
    select Building
    from Rooms
) as Buildings;

select CONCAT(Name, ' ', Surname) as FullName
from (
    select Name, Surname, 1 as SortOrder
    from Teachers
    where IsDean = 1
    union
    select Name, Surname, 2 as SortOrder
    from Teachers
    where IsHead = 1
    union
    select Name, Surname, 3 as SortOrder
    from Teachers
    where IsProfessor = 1
    union
    select Name, Surname, 4 as SortOrder
    from Teachers
    where IsCurator = 1
    union
    select Name, Surname, 5 as SortOrder
    from Teachers
    where IsAssistant = 1
) as OrderedTeachers
order by SortOrder;

select distinct DATENAME(dw, Lectures.Date) as Weekday
from Lectures
join Rooms on Lectures.RoomId = Rooms.ID
where Rooms.Name in ('A311', 'A104');