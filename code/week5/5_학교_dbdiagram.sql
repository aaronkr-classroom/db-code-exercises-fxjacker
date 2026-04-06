-- dbdiagram.id를 위해 수정하기
TABLE Professor{
	Professor_id int [PK]
	Professor_name varchar
	department varchar
	salary numeric
	salary_level numeric
	hire_date date
}
TABLE Student{
	student_id int [PK]
	studnet_name varchar
	major varchar
}

TABLE Course{
	course_id int
	section_id int
	professor_id int
	course_name varchar
	indexes{
		(course_id,section_id)[PK]
	}	
}

TABLE Enrollment{
	student_id int
	course_id int
	grade varchar
	points numeric
	enrolled_at date
	indexes{
		(student_id,course_id)[PK]
	}
}

Ref: Enrollment.student_id > Student.Student_id
Ref: Course.professor_id > Professor.professor_id