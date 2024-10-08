CREATE DATABASE universidad;

USE universidad;

CREATE TABLE Estudiantes (
    estudiante_id INT PRIMARY KEY,
    nombre_estudiante VARCHAR(100),
    anio_inscripcion INT
);

CREATE TABLE Cursos (
    curso_id INT PRIMARY KEY,
    nombre_curso VARCHAR(100),
    profesor_id INT,
    FOREIGN KEY (profesor_id) REFERENCES Profesores(profesor_id)
);

CREATE TABLE Profesores (
    profesor_id INT PRIMARY KEY,
    nombre_profesor VARCHAR(100),
    departamento VARCHAR(100)
    );
    
CREATE TABLE Calificaciones (
    calificacion_id INT PRIMARY KEY,
    estudiante_id INT,
    curso_id INT,
    calificacion DECIMAL(4,2),
    FOREIGN KEY (estudiante_id) REFERENCES Estudiantes(estudiante_id),
    FOREIGN KEY (curso_id) REFERENCES Cursos(curso_id)
);


INSERT INTO Profesores (profesor_id, nombre_profesor, departamento)
VALUES
(1, 'Dr. Juan Pérez', 'Matemáticas'),
(2, 'Dra. María García', 'Informática'),
(3, 'Dr. Roberto López', 'Física');

INSERT INTO Cursos (curso_id, nombre_curso, profesor_id)
VALUES
(1, 'Cálculo', 1),
(2, 'Estructuras de Datos', 2),
(3, 'Mecánica Cuántica', 3);

INSERT INTO Estudiantes (estudiante_id, nombre_estudiante, anio_inscripcion)
VALUES
(1, 'Ana Fernández', 2022),
(2, 'Luis Rodríguez', 2021),
(3, 'Carlos Gómez', 2020);

INSERT INTO Calificaciones (calificacion_id, estudiante_id, curso_id, calificacion)
VALUES
(1, 1, 1, 90.00),
(2, 2, 2, 85.50),
(3, 3, 3, 88.75),
(4, 1, 2, 92.00),
(5, 2, 3, 78.00);

SELECT Profesores.nombre_profesor, AVG(Calificaciones.calificacion) AS promedio_calificacion
FROM Calificaciones
JOIN Cursos ON Calificaciones.curso_id = Cursos.curso_id
JOIN Profesores ON Cursos.profesor_id = Profesores.profesor_id
GROUP BY Profesores.nombre_profesor;

SELECT Estudiantes.nombre_estudiante, MAX(Calificaciones.calificacion) AS mejor_calificacion
FROM Calificaciones
JOIN Estudiantes ON Calificaciones.estudiante_id = Estudiantes.estudiante_id
GROUP BY Estudiantes.nombre_estudiante;

SELECT Estudiantes.nombre_estudiante, Cursos.nombre_curso
FROM Calificaciones
JOIN Estudiantes ON Calificaciones.estudiante_id = Estudiantes.estudiante_id
JOIN Cursos ON Calificaciones.curso_id = Cursos.curso_id
ORDER BY Cursos.nombre_curso;

SELECT Cursos.nombre_curso, AVG(Calificaciones.calificacion) AS promedio_calificacion
FROM Calificaciones
JOIN Cursos ON Calificaciones.curso_id = Cursos.curso_id
GROUP BY Cursos.nombre_curso
ORDER BY promedio_calificacion ASC;

SELECT Estudiantes.nombre_estudiante, Profesores.nombre_profesor, COUNT(Cursos.curso_id) AS cursos_comunes
FROM Calificaciones
JOIN Cursos ON Calificaciones.curso_id = Cursos.curso_id
JOIN Profesores ON Cursos.profesor_id = Profesores.profesor_id
JOIN Estudiantes ON Calificaciones.estudiante_id = Estudiantes.estudiante_id
GROUP BY Estudiantes.nombre_estudiante, Profesores.nombre_profesor
ORDER BY cursos_comunes DESC
LIMIT 1;
    