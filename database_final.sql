-- ΠΡΟΠΑΡΑΣΚΕΥΑΣΤΙΚΟ ΣΤΑΔΙΟ-ΕΡΩΤΗΜΑ 3.1.1 --
DROP DATABASE if exists erecruit2023;
CREATE DATABASE erecruit2023;
USE erecruit2023;

CREATE TABLE IF NOT EXISTS etaireia (
    AFM CHAR(9) DEFAULT 'unknown' NOT NULL,
    DOY VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    name VARCHAR(35) DEFAULT 'unknown' NOT NULL,
    tel VARCHAR(10) DEFAULT '0' NOT NULL,
    street VARCHAR(15) DEFAULT 'unknown' NOT NULL,
    num INT(11) DEFAULT '0' NOT NULL,
    city VARCHAR(45) DEFAULT 'unknown' NOT NULL,
    country VARCHAR(15) DEFAULT 'unknown' NOT NULL,
    PRIMARY KEY (AFM)
); 

CREATE TABLE IF NOT EXISTS user(
	username VARCHAR(30) DEFAULT 'unknown' NOT NULL,
	password VARCHAR(20) DEFAULT 'unknown' NOT NULL,
	name VARCHAR(25) DEFAULT 'unknown' NOT NULL,
	lastname VARCHAR(35) DEFAULT 'unknown' NOT NULL,
	reg_date DATETIME DEFAULT CURRENT_TIMESTAMP,
	email VARCHAR(30) DEFAULT 'unknown' NOT NULL,
	PRIMARY KEY(username)
);  
	
CREATE TABLE IF NOT EXISTS evaluator(
	username VARCHAR(30) DEFAULT 'unknown' NOT NULL,
	exp_years TINYINT(4) DEFAULT '0' NOT NULL,
	firm CHAR(9) DEFAULT 'unknown' NOT NULL,
	PRIMARY KEY(username),
	CONSTRAINT eval_etaireia FOREIGN KEY (firm) REFERENCES etaireia(AFM)
	ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT eval_username FOREIGN KEY (username) REFERENCES user(username)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS subject(
    title VARCHAR(36) DEFAULT 'unknown' NOT NULL,
    descr TINYTEXT NOT NULL,
    belongs_to VARCHAR(36) DEFAULT NULL,
    PRIMARY KEY(title),
	CONSTRAINT subjbelongs FOREIGN KEY (belongs_to) REFERENCES subject(title)
	ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS job (
    id INT(11) AUTO_INCREMENT NOT NULL,
    start_date DATE NOT NULL,
    salary FLOAT DEFAULT 0 NOT NULL,
    position VARCHAR(60) DEFAULT 'unknown' NOT NULL,
    edra VARCHAR(60) DEFAULT 'unknown' NOT NULL,
    evaluator VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    announce_date DATETIME DEFAULT current_timestamp(),
    submission_date DATE NOT NULL ,
    PRIMARY KEY(id),
    CONSTRAINT eval_job FOREIGN KEY (evaluator) REFERENCES evaluator(username)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS requires (
    job_id INT(11) DEFAULT '0' NOT NULL,
    subject_title VARCHAR(36) DEFAULT 'unknown' NOT NULL,
    PRIMARY KEY (job_id, subject_title),
    CONSTRAINT requires_job FOREIGN KEY (job_id) REFERENCES job(id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS employee(
	username VARCHAR(30) DEFAULT 'unknown' NOT NULL,
	bio TEXT NOT NULL,
	sistatikes VARCHAR(35) DEFAULT 'unknown' NOT NULL,
	certificates VARCHAR(35) DEFAULT 'unknown' NOT NULL,
	PRIMARY KEY(username),
    CONSTRAINT empl_username FOREIGN KEY (username) REFERENCES user(username)
    ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS languages(
	candid VARCHAR(30) DEFAULT 'unknown' NOT NULL,
	lang SET ('EN', 'FR', 'SP', 'GE', 'CH', 'GR'),	
	PRIMARY KEY(candid,lang),
	CONSTRAINT candid_languages FOREIGN KEY (candid) REFERENCES employee(username)
	ON DELETE CASCADE ON UPDATE CASCADE
); 

CREATE TABLE IF NOT EXISTS project(
	candid VARCHAR(30) DEFAULT 'unknown' NOT NULL,
	num TINYINT(4) DEFAULT '0' NOT NULL,
	descr TEXT NOT NULL,
	url VARCHAR(60) DEFAULT 'unknown' NOT NULL,
	PRIMARY KEY(candid,num),
	CONSTRAINT candid_project FOREIGN KEY (candid) REFERENCES employee(username)
    ON DELETE CASCADE ON UPDATE CASCADE
); 



CREATE TABLE IF NOT EXISTS degree (
    titlos VARCHAR(150) DEFAULT 'unknown' NOT NULL,
    idryma VARCHAR(140) DEFAULT 'unknown' NOT NULL,
    bathmida ENUM('BSc','MSc','PhD'),
    PRIMARY KEY(titlos, idryma)
);

CREATE TABLE IF NOT EXISTS has_degree(
    degr_title VARCHAR(150) DEFAULT 'unknown' NOT NULL,
    degr_idryma VARCHAR(140) DEFAULT 'unknown' NOT NULL,
    cand_usrname VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    etos YEAR(4) DEFAULT '0' NOT NULL,
    grade FLOAT DEFAULT '0' NOT NULL,
    PRIMARY KEY(degr_title, degr_idryma, cand_usrname),
    CONSTRAINT has_degree_usrname FOREIGN KEY (degr_title, degr_idryma) REFERENCES degree(titlos, idryma)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT has_degree1_usrname FOREIGN KEY (cand_usrname) REFERENCES employee(username)
        ON DELETE CASCADE ON UPDATE CASCADE
);
 
CREATE TABLE IF NOT EXISTS applies (
    cand_usrname VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    job_id INT(11) DEFAULT '0' NOT NULL,
    PRIMARY KEY (cand_usrname, job_id),
    CONSTRAINT applies_usrname FOREIGN KEY (cand_usrname) REFERENCES employee(username)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT applies_job FOREIGN KEY (job_id) REFERENCES job(id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO etaireia (AFM, DOY, name, tel, street, num, city, country) VALUES
	('265032148','Patrwn', 'Nikolaou', '2610486522' , 'Mezonos', '59', 'Patras', 'Greece'),
	('623946215', 'Patrwn', 'Papadopoylos kai sia', '2103625577', 'Ermou', '150',  'Athens', 'Greece'),
	('203492781', 'Patrwn', 'Balafouths AE', '2610885423', 'Agiou Nikolaou',  '23', 'Patras', 'Greece');

INSERT INTO user (username, password, name, lastname, reg_date, email) VALUES
	('Douvris', 'Jdjoswkds', 'Fotis', 'Douvris', '2009-12-14', 'douvrisf@yahoo.com'),
	('Georgiou', '15121996', 'Aggelikh', 'Georgiou', '2004-06-06', 'aggelikhgeorgiou@gmail.com'),
	('Androutsos' , 'Kddkdekl', 'Thodorhs', 'Androutsos', '2010-01-09', 'thodandrou@gmail.com'),
	('Dhmhtriou', 'Panagiota29', 'Panagiota', 'Dhmhtriou', '2018-05-25', 'panagiotadhmhtriou@gmail.com'),
	('Andrikopoulos', 'Lakksood', 'Dhmhtrhs', 'Andrikopoulos', '2022-02-22', 'megalosdhmhtrhs@yahoo.com'),
	('Katsaros' , '20202020', 'Alejandros', 'Katsaros', '2007-11-07', 'alejandroskats@gmail.com'),
	('Xristopoulos', 'Xmlmjkdl', 'Nikolas', 'Xristopoulos', '2022-01-01', 'nikolasxrist@gmail.com'),
	('Lious', 'Fr@nk1i0us', 'Frank', 'Lious','2023-02-01', 'liousfrank@gmail.com'),
	('Papanikolaou', 'Nt1n@26', 'Konstantina', 'Papanikolaou','2022-03-01', 'ntinapapa@yahoo@gmail.com'),
	('Nikolakopoulou', 'Anna1985', 'Marianna', 'Nikolakopoulou','2022-04-01', 'Marianna1985@yahoo.com'),
	('Ioannidh', '56426348', 'Hlianna', 'Ioannidh','2022-05-01', 'ioannidhhl@yahoo.com'),
	('Papapaulou', 'Mariamaria', 'Maria' , 'Papapaulou','2022-06-01', 'Mariapapa@gmail.com');
    
INSERT INTO employee (username, bio, sistatikes, certificates) VALUES
	('Xristopoulos', 'XristopoulosN.docx', 'sistatikhXRIST.docx', 'pistXristopoulos.docx'),
	('Lious', 'Lious.docx', 'sistatikhLious.docx', 'LiousCertificates.docx'),
	('Papanikolaou', 'Papanikolaou.docx', 'sistatikhPapanikolaou.docx', 'certPapanikolaou.docx'),
	('Nikolakopoulou', 'Nikolakopoulou.pdf', 'sistatikhMarianna.pdf', 'DEFAULT'),
	('Ioannidh', 'Ioannidh.pdf', 'DEFAULT', 'IoannidhCertificates.pdf'),
	('Papapaulou', 'PapapaulouBio.pdf', 'PapapaulouSist.pdf', 'DEFAULT');
    
INSERT INTO evaluator (username, exp_years, firm) VALUES
	('Douvris', '15', '265032148'),
	('Georgiou', '20', '623946215'),
	('Androutsos', '14', '203492781'),
	('Dhmhtriou', '6', '265032148'),
	('Andrikopoulos', '2', '203492781'),
	('Katsaros', '17', '623946215');
    
INSERT INTO degree (titlos, idryma, bathmida) VALUES
	('Computer Engineering and Informatics', 'Panepisthmio Patrwn', 'BSc'),
	('Electrical Engineering', 'Panepisthmio Patrwn', 'MSc'),
	('Mathematics', 'Panepisthmio Patrwn', 'BSc'),
	('Logistics', 'Panepisthmio Patrwn', 'BSc'),
	('Architecture', 'Panepisthmio Patrwn', 'PhD'),
	('Economics', 'Panepisthmio Patrwn', 'MSc');
    
INSERT INTO job (start_date, salary, position, edra, evaluator, announce_date, submission_date) VALUES
	('2022-01-01', '67000', 'Ypeuthinos C', 'Patra', 'Androutsos', '2022-01-01', '2024-12-31' ),
	('2022-02-01', '40000', 'Ypeuthinos G', 'Patra', 'Georgiou', '2022-02-01', '2024-12-31' ),
	('2022-03-01', '102000', 'Ypeuthinos A', 'Patra', 'Douvris', '2022-03-01', '2024-12-31' ),
	('2022-04-01', '54000', 'Ypeuthinos F' , 'Patra', 'Androutsos', '2022-04-01', '2024-12-31'),
	('2022-05-01', '65000', 'Ypeuthinos D', 'Patra', 'Dhmhtriou', '2022-05-01', '2024-12-31' ),
	('2022-06-01', '58000', 'Ypeuthinos E', 'Patra', 'Andrikopoulos', '2022-06-01', '2024-12-31' ),
	('2022-07-01', '92000', 'Ypeuthinos B', 'Patra', 'Katsaros', '2022-07-01', '2024-12-31' ),
	('2022-08-01', '58000', 'Υpeuthinos E', 'Patra', 'Katsaros', '2022-08-01', '2024-12-31' );

INSERT INTO has_degree (degr_title, degr_idryma, cand_usrname, etos, grade) VALUE
	('Computer Engineering and Informatics', 'Panepisthmio Patrwn', 'Xristopoulos', '2023', '8'),
	('Economics', 'Panepisthmio Patrwn', 'Lious', '2022', '9'),
	('Architecture', 'Panepisthmio Patrwn', 'Nikolakopoulou', '2023', '8.6'),
	('Electrical Engineering', 'Panepisthmio Patrwn', 'Papapaulou', '2023', '6');
    
INSERT INTO languages (candid, lang) VALUES
	('Xristopoulos', 'EN'),
	('Lious', 'GR'),
	('Nikolakopoulou', 'SP'),
	('Papapaulou', 'CH');
    
INSERT INTO project (candid, num, descr, url) VALUES
	('Xristopoulos', '1', 'xristopoulos.pdf', 'https://XRproject.com' ),
	('Lious', '2', 'lious1.pdf', 'https://LI1project.com' ),
	('Lious', '3', 'lious2.pdf', 'https://LI2project.com' ),
	('Papanikolaou', '4', 'papanikolaou.pdf', 'https://PAPAproject.com' ),
	('Nikolakopoulou', '5', 'nikolakopoulou.pdf', 'https://NIKOLproject.com' ),
	('Ioannidh', '6', 'ioannidh.pdf', 'https://IOANproject.com' ),
	('Papapaulou', '7', 'papapaulou.pdf', 'https://PAPAPAproject.com' );
    

INSERT INTO subject (title, descr, belongs_to) VALUES
	('Web Developer', 'This job requires experience in designing, developing, and maintaining web applications.', null),
	('Product Manager', 'This job requires experience in defining, prioritizing, and launching new products.', null),
	('Marketing Specialist', 'This job requires experience in creating and executing marketing campaigns to promote products and services.', null),
	('Customer Support Specialist', 'This job requires experience in providing technical and customer support to resolve issues and answer questions.', null),
	('Accountant', 'This job requires experience in managing financial records, preparing reports, and ensuring financial compliance.', null),
	('Human Resources Manager', 'This job requires experience in recruiting, onboarding, and managing employees.', null);

INSERT INTO requires (job_id , subject_title) VALUES
	('1','Web Development'),
	('2','Marketing Specialist'),
	('3','Human Resources Manager'),
	('4','Web Development'),
	('5','Accountant'),
	('6','Customer Support Specialist'),
	('7','Product Manager'),
	('8','Web Development');


INSERT INTO applies (cand_usrname, job_id) VALUES
	('Xristopoulos', '3'),
	('Lious', '1'),
	('Papanikolaou', '3'),
	('Nikolakopoulou', '5'),
	('Ioannidh', '3'),	
	('Papapaulou', '8');



-- 3.1.2 ΝΕΕΣ ΑΠΑΙΤΗΣΕΙΣ

-- ΕΡΩΤΗΜΑ 3.1.2.1 --
-- Drop foreign key constraints
ALTER TABLE applies
DROP FOREIGN KEY applies_usrname,
DROP FOREIGN KEY applies_job;

-- Drop the existing primary key
ALTER TABLE applies
DROP PRIMARY KEY;

-- Add a new column 'id' with AUTO_INCREMENT and make it the new primary key
ALTER TABLE applies
ADD COLUMN id INT(11) AUTO_INCREMENT PRIMARY KEY FIRST;

-- Add new columns 'status' and 'application_date'
ALTER TABLE applies
ADD COLUMN status ENUM('active', 'completed', 'cancelled') DEFAULT 'active' NOT NULL AFTER job_id,
ADD COLUMN application_date DATETIME DEFAULT CURRENT_TIMESTAMP AFTER status;

-- Rename the table to 'application_details'
RENAME TABLE applies TO application_details;


/* The new applies table
CREATE TABLE IF NOT EXISTS application_details (
    id INT(11) AUTO_INCREMENT NOT NULL,
    cand_usrname VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    job_id INT(11) DEFAULT '0' NOT NULL,
    status ENUM('active', 'completed', 'cancelled') DEFAULT 'active' NOT NULL,
    application_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT app_details_usrname FOREIGN KEY (cand_usrname) REFERENCES employee(username)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT app_details_job FOREIGN KEY (job_id) REFERENCES job(id)
    ON DELETE CASCADE ON UPDATE CASCADE
);
*/

DELIMITER // 
CREATE TRIGGER before_insert_application
BEFORE INSERT ON application_details
FOR EACH ROW
BEGIN
    DECLARE active_applications_count INT;
    DECLARE job_start_date DATETIME;

    -- Count the number of active applications for the employee
    SELECT COUNT(*)
    INTO active_applications_count
    FROM application_details
    WHERE cand_usrname = NEW.cand_usrname
        AND status = 'active';

    -- Check if the employee already has three active applications
    IF active_applications_count >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'An employee cannot have more than three active applications.';
    END IF;

    -- Check if the application date is less than 15 days before the job start date
    SELECT start_date
    INTO job_start_date
    FROM job
    WHERE id = NEW.job_id;
    
    IF NEW.application_date > DATE_SUB(job_start_date, INTERVAL 15 DAY) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'New applications must be submitted at least 15 days before the job start date.';
    END IF;

END//

DELIMITER ; 

DELIMITER // 
CREATE TRIGGER before_update_application
BEFORE UPDATE ON application_details
FOR EACH ROW
BEGIN
    DECLARE active_applications_count INT;
    DECLARE job_start_date DATETIME;

    -- Count the number of active applications for the employee
    SELECT COUNT(*)
    INTO active_applications_count
    FROM application_details
    WHERE cand_usrname = NEW.cand_usrname
        AND status = 'active';

    -- Check if the employee already has three active applications
    IF active_applications_count >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'An employee cannot have more than three active applications.';
    END IF;

    -- Check if the application is being canceled
    IF NEW.status = 'cancelled' THEN
        -- Check if the cancellation date is less than 10 days before the job start date
        SELECT start_date
        INTO job_start_date
        FROM job
        WHERE id = NEW.job_id;
        
        IF NEW.application_date > DATE_SUB(job_start_date, INTERVAL 10 DAY) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'An application cannot be canceled within 10 days before the job start date.';
        END IF;
    END IF;

    -- Check if the canceled application is being reactivated and the user has less than 3 active applications
    IF NEW.status = 'active' AND active_applications_count >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'An employee cannot have more than three active applications.';
    END IF;

END//

DELIMITER ; 

-- ΕΡΩΤΗΜΑ 3.1.2.2

CREATE TABLE IF NOT EXISTS evaluation_assignments (
    id INT(11) AUTO_INCREMENT NOT NULL,
    job_id INT(11) NOT NULL,
    evaluator1_username VARCHAR(30) NOT NULL,
    evaluator2_username VARCHAR(30) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT eval_assign_job FOREIGN KEY (job_id) REFERENCES job(id) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Inserting evaluators for a specific job ID 
INSERT INTO evaluation_assignments (job_id, evaluator1_username, evaluator2_username)
VALUES
    (1 ,'Andrikopoulos', 'Androutsos'),
    (2, 'Dhmhtriou', 'Douvris'),
    (3 ,'Georgiou', 'Katsaros'),
    (4, 'Douvris', 'Georgiou'),
    (5, 'Katsaros', 'Androutsos'),
    (6, 'Dhmhtriou', 'Andrikopoulos');


CREATE TABLE IF NOT EXISTS historical_applications (
    id INT(11) AUTO_INCREMENT NOT NULL,
    evaluator1_username VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    evaluator2_username VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    cand_usrname VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    job_id INT(11) DEFAULT '0' NOT NULL,
    status ENUM('active', 'completed', 'canceled') DEFAULT 'completed' NOT NULL,
    application_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    final_rating INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT hist_app_usrname FOREIGN KEY (cand_usrname) REFERENCES employee(username)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT hist_app_job FOREIGN KEY (job_id) REFERENCES job(id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

DELIMITER //

CREATE PROCEDURE check_application_status(IN candidate_username VARCHAR(30), IN job_id INT, OUT app_status VARCHAR(20))
BEGIN
    -- Get the status of the application
    SELECT COALESCE(status, 'not_found')
    INTO app_status
    FROM application_details
    WHERE cand_usrname = candidate_username AND job_id = job_id
    LIMIT 1;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE evaluate_promotion(
    IN candidate_username VARCHAR(30),
    IN job_id INT
)
BEGIN
    DECLARE evaluator1_username VARCHAR(30);
    DECLARE evaluator2_username VARCHAR(30);
    DECLARE rating1 INT;
    DECLARE rating2 INT;
    DECLARE final_rating INT;
    DECLARE app_status VARCHAR(20);
    DECLARE job_exists INT;

    -- Check if the job_id exists in the applications
    SELECT COUNT(*)
    INTO job_exists
    FROM application_details
    WHERE job_id = job_id;

    -- If the job_id does not exist, print an error message and exit the procedure
    IF job_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Job does not exist in applications. Skipping evaluation.';
    END IF;

    -- Check if evaluators are assigned for the given job_id
    SELECT ea.evaluator1_username, ea.evaluator2_username
    INTO evaluator1_username, evaluator2_username
    FROM evaluation_assignments ea
    WHERE ea.job_id = job_id
    LIMIT 1;

    -- If evaluators are not assigned, print an error message and exit the procedure
    IF evaluator1_username IS NULL OR evaluator2_username IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Evaluators are not assigned for the given job_id. Skipping evaluation.';
    END IF;

    -- Call the procedure to check the application status
    CALL check_application_status(candidate_username, job_id, app_status);

    -- Check if the application is cancelled or completed
    IF TRIM(app_status) = 'cancelled' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Application is cancelled. Skipping evaluation.';
    ELSEIF TRIM(app_status) = 'completed' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Application is already completed. Skipping evaluation.';
    ELSE
        -- Generate random ratings between 1 and 20 for both evaluators, with a possibility of NULL
        SET rating1 = (CASE WHEN RAND() < 0.8 THEN FLOOR(1 + RAND() * 20) ELSE NULL END);
        SET rating2 = (CASE WHEN RAND() < 0.8 THEN FLOOR(1 + RAND() * 20) ELSE NULL END);

        -- Calculate the final rating based on qualifications
        SELECT (SUM(IF(dg.bathmida = 'BSc', 1, IF(dg.bathmida = 'MSc', 2, IF(dg.bathmida = 'PhD', 3, 0)))) +
                (SELECT COUNT(*) FROM languages l WHERE l.candid = candidate_username) +
                (SELECT COUNT(*) FROM project p WHERE p.candid = candidate_username)) 
        INTO final_rating
        FROM has_degree hd
        JOIN degree dg ON hd.degr_title = dg.titlos AND hd.degr_idryma = dg.idryma
        WHERE hd.cand_usrname = candidate_username;

        -- If one rating is missing, fill in based on qualifications
        IF rating1 IS NULL AND rating2 IS NOT NULL THEN
            SET rating1 = ((SUM(IF(dg.bathmida = 'BSc', 1, IF(dg.bathmida = 'MSc', 2, IF(dg.bathmida = 'PhD', 3, 0)))) +
                            (SELECT COUNT(*) FROM languages l WHERE l.candid = candidate_username) +
                            (SELECT COUNT(*) FROM project p WHERE p.candid = candidate_username)));
        END IF;
        IF rating2 IS NULL AND rating1 IS NOT NULL THEN
            SET rating2 = ((SUM(IF(dg.bathmida = 'BSc', 1, IF(dg.bathmida = 'MSc', 2, IF(dg.bathmida = 'PhD', 3, 0)))) +
                            (SELECT COUNT(*) FROM languages l WHERE l.candid = candidate_username) +
                            (SELECT COUNT(*) FROM project p WHERE p.candid = candidate_username)));
        END IF;
        IF rating1 IS NULL AND rating2 IS NULL THEN
            -- Calculate the default rating based on qualifications
            SET final_rating = ((SUM(IF(dg.bathmida = 'BSc', 1, IF(dg.bathmida = 'MSc', 2, IF(dg.bathmida = 'PhD', 3, 0)))) +
                                (SELECT COUNT(*) FROM languages l WHERE l.candid = candidate_username) +
                                (SELECT COUNT(*) FROM project p WHERE p.candid = candidate_username)));
        ELSE
            -- Use the provided ratings if available
            SET final_rating = ((COALESCE(rating1, 0) + COALESCE(rating2, 0)) / 2);
        END IF;

        -- Set session variables for the ratings and final rating
        SET @rating1 = rating1;
        SET @rating2 = rating2;
        SET @final_rating = final_rating;

        -- Print the ratings and final rating, including the candidate's username
        SELECT candidate_username AS 'Candidate Username', @rating1 AS 'Evaluator 1 Rating', @rating2 AS 'Evaluator 2 Rating', @final_rating AS 'Final Rating';
    END IF;
END //

DELIMITER; 

DELIMITER //

CREATE PROCEDURE move_completed_applications()
BEGIN
    -- Move completed applications to historical_applications table
    INSERT INTO historical_applications (cand_usrname, job_id, status, application_date)
    SELECT cand_usrname, job_id, status, application_date
    FROM application_details
    WHERE status = 'completed';

    -- Get IDs of completed applications
    SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
    SET @completed_ids = (SELECT GROUP_CONCAT(id) FROM application_details WHERE status = 'completed');
    SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

    -- Delete completed applications from application_details table
    IF @completed_ids IS NOT NULL THEN
        SET @delete_query = CONCAT('DELETE FROM application_details WHERE id IN (', @completed_ids, ')');

        -- Execute the delete query
        PREPARE stmt FROM @delete_query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    END IF;
END //

DELIMITER ;


-- Call the procedure to move completed applications
CALL move_completed_applications();

INSERT INTO application_details (cand_usrname, job_id, status, application_date) 
VALUES 
    ('Lious', 1, 'active', '2021-01-01'),
    ('Ioannidh', 2, 'cancelled', '2021-01-02'),
    ('Papapaulou', 4, 'active', '2021-01-03');

/* 
CALL evaluate_promotion('Lious', 1);
CALL evaluate_promotion('Ioannidh', 3);
CALL evaluate_promotion('Papapaulou', 5);
*/

-- ΕΡΩΤΗΜΑ 3.1.2.3
-- The following table has already been created but will also be placed here just for reference
CREATE TABLE IF NOT EXISTS historical_applications (
    id INT(11) AUTO_INCREMENT NOT NULL,
    evaluator1_username VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    evaluator2_username VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    cand_usrname VARCHAR(30) DEFAULT 'unknown' NOT NULL,
    job_id INT(11) DEFAULT '0' NOT NULL,
    status ENUM('active', 'completed', 'canceled') DEFAULT 'completed' NOT NULL,
    application_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    final_rating INT NOT NULL DEFAULT 0,
    PRIMARY KEY (id),
    CONSTRAINT hist_app_usrname FOREIGN KEY (cand_usrname) REFERENCES employee(username)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT hist_app_job FOREIGN KEY (job_id) REFERENCES job(id)
    ON DELETE CASCADE ON UPDATE CASCADE
);

DELIMITER //

DELIMITER //
CREATE PROCEDURE generate_historical_applications()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE batch_size INT DEFAULT 500;

    WHILE i <= 60000 DO
        START TRANSACTION;

        -- Insert into historical_applications with both evaluators
        INSERT INTO historical_applications (evaluator1_username, evaluator2_username, cand_usrname, job_id, status, final_rating)
        SELECT 
            (SELECT evaluator1_username FROM evaluation_assignments ORDER BY RAND() LIMIT 1) AS evaluator1_username,
            (SELECT evaluator2_username FROM evaluation_assignments WHERE evaluator2_username <> evaluator1_username ORDER BY RAND() LIMIT 1) AS evaluator2_username,
            (SELECT username FROM employee ORDER BY RAND() LIMIT 1) AS cand_usrname,
            (SELECT id FROM job ORDER BY RAND() LIMIT 1) AS job_id,
            'completed' AS status,
            FLOOR(1 + RAND() * 20) AS final_rating
        FROM information_schema.tables ORDER BY RAND() LIMIT batch_size;

        COMMIT;

        SET i = i + batch_size;
    END WHILE;
END //

DELIMITER ;



-- Call the procedure to generate historical applications
/* CALL generate_historical_applications();
SELECT * FROM historical_applications;
*/
-- ΕΡΩΤΗΜΑ 3.1.2.4

CREATE TABLE IF NOT EXISTS dba (
    id INT(11) AUTO_INCREMENT NOT NULL,
    username VARCHAR(30) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    PRIMARY KEY (id),
    UNIQUE KEY (username)
);

INSERT INTO dba (username, start_date) VALUES ('theokatsa', '2024-01-10');
INSERT INTO dba (username, start_date) VALUES ('aggidouvri', '2024-01-10');


-- 3.1.3 Stored Procedures

-- 3.1.3.1

DELIMITER //

CREATE PROCEDURE CheckEvaluation(
    IN p_evaluator_username VARCHAR(255), 
    IN p_employee_username VARCHAR(255), 
    IN p_job_id INT,
    OUT p_result INT
)
BEGIN
    DECLARE message_text VARCHAR(255);  -- Declare a variable to hold the message

    -- Check if the evaluator exists for the specified job_id in evaluation_assignments
SELECT COUNT(*)
INTO p_result
FROM evaluation_assignments
WHERE evaluator1_username = p_evaluator_username OR evaluator2_username = p_evaluator_username 
  AND job_id = p_job_id;


    -- If the evaluator does not exist for the specified job_id, set the result to 0
    IF p_result = 0 THEN
        SET p_result = 0;
        SIGNAL SQLSTATE '45000'
        SET message_text = 'Evaluator not assigned to the specified job.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = message_text;
    
    ELSE
        -- Check if the employee exists
        SELECT COUNT(*)
        INTO p_result
        FROM employee
        WHERE username = p_employee_username;

        -- If the employee does not exist, raise an error
        IF p_result = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET message_text = 'Invalid employee username.';
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = message_text;
        
        ELSE
            -- Check if the evaluation exists for the specified evaluator, employee, and job
            SELECT final_rating
            INTO p_result
            FROM historical_applications
            WHERE (evaluator1_username = p_evaluator_username OR evaluator2_username = p_evaluator_username)
              AND cand_usrname = p_employee_username
              AND job_id = p_job_id
            LIMIT 1;

            -- If an evaluation exists, print a message and return the rating
            IF p_result IS NOT NULL THEN
                SET message_text = CONCAT('Evaluation already exists. Rating: ', p_result);
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = message_text;
            ELSE
                -- Calculate the rating using evaluate_promotion procedure
                CALL evaluate_promotion(p_evaluator_username, p_employee_username, p_job_id, p_result);
				-- Print a message indicating that the evaluation was calculated
			SELECT 'Evaluation calculated using evaluate_promotion' AS message;
            END IF;
        END IF;
    END IF;
END //

DELIMITER ;

-- ΕΡΩΤΗΜΑ 3.1.3.2

DELIMITER //

CREATE PROCEDURE ManageApplication(
    IN p_employee_username VARCHAR(30),
    IN p_job_id INT,
    IN p_action CHAR(1)
)
BEGIN
    DECLARE v_evaluator1_username VARCHAR(30);
    DECLARE v_evaluator2_username VARCHAR(30);
    DECLARE v_application_status VARCHAR(20);

    -- Check if the action is valid ('i', 'c', or 'a')
    IF NOT (p_action IN ('i', 'c', 'a')) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid action. Use ''i'' for insert, ''c'' for cancel, or ''a'' for activate.';
    END IF;

    -- Check if the employee exists
    IF NOT EXISTS (SELECT 1 FROM employee WHERE username = p_employee_username) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid employee username.';
    END IF;

    -- Check if the job exists
    IF NOT EXISTS (SELECT 1 FROM job WHERE id = p_job_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid job ID.';
    END IF;

    -- Get the evaluators for the job
    SELECT evaluator1_username, evaluator2_username
    INTO v_evaluator1_username, v_evaluator2_username
    FROM evaluation_assignments
    WHERE job_id = p_job_id
    LIMIT 1;

    -- If evaluators are not assigned, fill them in from the same company
    IF v_evaluator1_username IS NULL THEN
        SELECT username
        INTO v_evaluator1_username
        FROM evaluator
        WHERE firm = (SELECT firm FROM evaluator WHERE username = p_employee_username)
        AND username <> p_employee_username
        LIMIT 1;
    END IF;

    IF v_evaluator2_username IS NULL THEN
        SELECT username
        INTO v_evaluator2_username
        FROM evaluator
        WHERE firm = (SELECT firm FROM evaluator WHERE username = p_employee_username)
        AND username <> p_employee_username
        AND username <> v_evaluator1_username
        LIMIT 1;
    END IF;

    -- Call the procedure to check the application status
    CALL check_application_status(p_employee_username, p_job_id, v_application_status);

    -- Perform actions based on the specified action
    CASE v_application_status
        WHEN 'not_found' THEN
            -- Insert an application
            IF p_action = 'i' THEN
                -- Start a transaction if necessary
                INSERT INTO application_details (cand_usrname, job_id, status, application_date)
                VALUES (p_employee_username, p_job_id, 'active', CURRENT_TIMESTAMP);
                -- Commit the transaction if necessary
                COMMIT;
            END IF;
        WHEN 'active' THEN
            -- Cancel an application
            IF p_action = 'c' THEN
                UPDATE application_details
                SET status = 'cancelled'
                WHERE cand_usrname = p_employee_username AND job_id = p_job_id;
                COMMIT;
            END IF;
        WHEN 'cancelled' THEN
            -- Activate a canceled application
            IF p_action = 'a' THEN
                UPDATE application_details
                SET status = 'active'
                WHERE cand_usrname = p_employee_username AND job_id = p_job_id;
                COMMIT;
            END IF;
    END CASE;
END //

DELIMITER ;

-- 3.1.3.3

CREATE TABLE IF NOT EXISTS employee_jobs (
    id INT(11) AUTO_INCREMENT NOT NULL,
    job_id INT(11) NOT NULL,
    employee_username VARCHAR(30) NOT NULL,
    rating DECIMAL(5, 2) NOT NULL,
    selection_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT emp_jobs_job FOREIGN KEY (job_id) REFERENCES job(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT emp_jobs_employee FOREIGN KEY (employee_username) REFERENCES employee(username) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS job_positions (
    job_id INT(11) AUTO_INCREMENT NOT NULL,
    job_title VARCHAR(255) NOT NULL,
    status VARCHAR(20) DEFAULT 'open',
    PRIMARY KEY (job_id)
);

DELIMITER //

CREATE PROCEDURE fill_job_position(
    IN p_job_id INT
)
BEGIN
    DECLARE candidate_username VARCHAR(30);
    DECLARE app_status VARCHAR(20);
    DECLARE evaluator1_username VARCHAR(30);
    DECLARE evaluator2_username VARCHAR(30);
    DECLARE evaluation_result INT;

    -- Check if the job_id exists in the applications
    DECLARE job_exists INT;
    SELECT COUNT(*) INTO job_exists
    FROM application_details
    WHERE job_id = p_job_id;

    -- If the job_id does not exist, print an error message and exit the procedure
    IF job_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Job does not exist in applications. Cannot fill position.';
    ELSE
        -- Check if the job is already occupied
        SELECT COUNT(*) INTO @job_occupied
        FROM employee_jobs
        WHERE job_id = p_job_id;

        IF @job_occupied > 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Job is already occupied. Cannot fill position.';
        ELSE
            -- Get the candidate's username from historical_applications
            SELECT cand_usrname INTO candidate_username
            FROM historical_applications
            WHERE job_id = p_job_id
            ORDER BY final_rating DESC
            LIMIT 1;

            -- Call the procedure to check the application status
            CALL check_application_status(candidate_username, p_job_id, app_status);

            -- Check if the application is cancelled or completed
            IF TRIM(app_status) = 'cancelled' THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Selected candidate has cancelled application. Cannot fill position.';
            ELSEIF TRIM(app_status) = 'completed' THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Selected candidate has already completed the application. Cannot fill position.';
            ELSE
                -- Check if evaluators are assigned for the given job_id
                SELECT ea.evaluator1_username, ea.evaluator2_username
                INTO evaluator1_username, evaluator2_username
                FROM evaluation_assignments ea
                WHERE ea.job_id = p_job_id
                LIMIT 1;

                -- If evaluators are not assigned, print an error message and exit the procedure
                IF evaluator1_username IS NULL OR evaluator2_username IS NULL THEN
                    SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Evaluators are not assigned for the given job_id. Cannot fill position.';
                END IF;

                -- Check if the evaluation exists for the specified evaluator, employee, and job
                SELECT COALESCE(final_rating, 0)
                INTO evaluation_result
                FROM historical_applications
                WHERE (evaluator1_username = evaluator1_username OR evaluator2_username = evaluator2_username)
                  AND cand_usrname = candidate_username
                  AND job_id = p_job_id
                LIMIT 1;

                -- If the evaluation does not exist, print an error message and exit the procedure
                IF evaluation_result = 0 THEN
                    SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Evaluation does not exist. Cannot fill position.';
                ELSE
                    -- Call the procedure to evaluate promotion
                    CALL evaluate_promotion(candidate_username, p_job_id);

                    -- Update the job status as filled
                    UPDATE job_positions
                    SET status = 'filled'
                    WHERE job_id = p_job_id;

                    -- Insert the job assignment into the employee_jobs table
INSERT INTO employee_jobs (job_id, employee_username, rating)
SELECT p_job_id, cand_usrname, final_rating
FROM historical_applications
WHERE job_id = p_job_id
ORDER BY final_rating DESC
LIMIT 1;

-- Get the ratings for the selected candidate
SELECT final_rating, final_rating AS 'Evaluator 1 Rating', final_rating AS 'Evaluator 2 Rating'
INTO @final_rating, @rating1, @rating2
FROM historical_applications
WHERE job_id = p_job_id
ORDER BY final_rating DESC
LIMIT 1;

-- Print a success message with ratings and final evaluation
SELECT CONCAT(
    'Job position filled for job_id: ', p_job_id, 
    ' with candidate: ', candidate_username,
    '. Evaluator 1 Rating: ', @rating1,
    '. Evaluator 2 Rating: ', @rating2,
    '. Final Rating: ', @final_rating
) AS 'Success Message';
                END IF;
            END IF;
        END IF;
    END IF;
END //

DELIMITER ;

-- ΕΡΩΤΗΜΑ 3.1.3.4

-- Create the index on final_rating column
CREATE INDEX idx_final_rating ON historical_applications (final_rating);
CREATE INDEX idx_evaluator_filter ON historical_applications (evaluator1_username, evaluator2_username);
 -- a)
DELIMITER //

CREATE PROCEDURE filter_applications_by_ratings(IN min_rating INT, IN max_rating INT)
BEGIN
    -- Select cand_usrname, job_id, and final_rating based on the rating range
    SELECT cand_usrname AS employee_username, job_id, final_rating
    FROM historical_applications USE INDEX (idx_final_rating)
    WHERE final_rating BETWEEN min_rating AND max_rating
    ORDER BY final_rating; -- Optional: Add ORDER BY if needed
END //

DELIMITER ;



-- b)
DELIMITER //

CREATE PROCEDURE filter_applications_by_evaluator(IN evaluator_username VARCHAR(30))
BEGIN
    -- Select cand_usrname (employee username) and job_id for applications evaluated by the specified evaluator
    SELECT cand_usrname AS employee_username, job_id
    FROM historical_applications USE INDEX (idx_evaluator_filter)
    WHERE evaluator1_username = evaluator_username OR evaluator2_username = evaluator_username;
END //

DELIMITER ;


-- ΕΡΩΤΗΜΑ 3.1.4. 

-- 3.1.4.1


SET @current_admin = 'theokatsa';
SET @current_admin_id = '1';
-- SET @current_admin = 'douvriaggi';
-- SET @current_admin_id = '2';

CREATE TABLE IF NOT EXISTS dba_log (
    log_id INT(11) AUTO_INCREMENT NOT NULL,
    dba_id INT(11) NOT NULL,
    username VARCHAR(30) NOT NULL,
    table_name VARCHAR(30) NOT NULL,
    action_description VARCHAR(255) NOT NULL,
    action_date DATETIME NOT NULL,
    PRIMARY KEY (log_id),
    FOREIGN KEY (dba_id) REFERENCES dba(id) ON DELETE CASCADE ON UPDATE CASCADE
);

DELIMITER //

CREATE TRIGGER job_after_insert
AFTER INSERT ON job
FOR EACH ROW
BEGIN
    INSERT INTO dba_log (dba_id, username, action_description, table_name, action_date)
    VALUES (@current_admin_id, @current_admin, 'insert', 'job', NOW());
END;
//

CREATE TRIGGER job_after_update
AFTER UPDATE ON job
FOR EACH ROW
BEGIN
    INSERT INTO dba_log (dba_id, username, action_description, table_name, action_date)
    VALUES (@current_admin_id, @current_admin, 'update', 'job', NOW());
END;
//

CREATE TRIGGER job_after_delete
AFTER DELETE ON job
FOR EACH ROW
BEGIN
    INSERT INTO dba_log (dba_id, username, action_description, table_name, action_date)
    VALUES (@current_admin_id, @current_admin, 'delete', 'job', NOW());
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER user_after_insert
AFTER INSERT ON user
FOR EACH ROW
BEGIN
    INSERT INTO dba_log (dba_id, username, action_description, table_name, action_date)
    VALUES (@current_admin_id, @current_admin, 'insert', 'user', NOW());
END;
//

CREATE TRIGGER user_after_update
AFTER UPDATE ON user
FOR EACH ROW
BEGIN
    INSERT INTO dba_log (dba_id, username, action_description, table_name, action_date)
    VALUES (@current_admin_id, @current_admin, 'update', 'user', NOW());
END;
//

CREATE TRIGGER user_after_delete
AFTER DELETE ON user
FOR EACH ROW
BEGIN
    INSERT INTO dba_log (dba_id, username, action_description, table_name, action_date)
    VALUES (@current_admin_id, @current_admin, 'delete', 'user', NOW());
END;
//

DELIMITER ;

DELIMITER //

CREATE TRIGGER degree_after_insert
AFTER INSERT ON degree
FOR EACH ROW
BEGIN
    INSERT INTO dba_log (dba_id, username, action_description, table_name, action_date)
    VALUES (@current_admin_id, @current_admin, 'insert', 'degree', NOW());
END;
//

CREATE TRIGGER degree_after_update
AFTER UPDATE ON degree
FOR EACH ROW
BEGIN
    INSERT INTO dba_log (dba_id, username, action_description, table_name, action_date)
    VALUES (@current_admin_id, @current_admin, 'update', 'degree', NOW());
END;
//

CREATE TRIGGER degree_after_delete
AFTER DELETE ON degree
FOR EACH ROW
BEGIN
    INSERT INTO dba_log (dba_id, username, action_description, table_name, action_date)
    VALUES (@current_admin_id, @current_admin, 'delete', 'degree', NOW());
END;
//

DELIMITER ;

-- ΕΡΩΤΗΜΑ 3.1.4.2 


DELIMITER // 
CREATE TRIGGER before_insert_application
BEFORE INSERT ON application_details
FOR EACH ROW
BEGIN
    DECLARE active_applications_count INT;
    DECLARE job_start_date DATETIME;

    -- Count the number of active applications for the employee
    SELECT COUNT(*)
    INTO active_applications_count
    FROM application_details
    WHERE cand_usrname = NEW.cand_usrname
        AND status = 'active';

    -- Check if the employee already has three active applications
    IF active_applications_count >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'An employee cannot have more than three active applications.';
    END IF;

    -- Check if the application date is less than 15 days before the job start date
    SELECT start_date
    INTO job_start_date
    FROM job
    WHERE id = NEW.job_id;
    
    IF NEW.application_date > DATE_SUB(job_start_date, INTERVAL 15 DAY) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'New applications must be submitted at least 15 days before the job start date.';
    END IF;

END//

DELIMITER ; 


-- ΕΡΩΤΗΜΑ 3.1.4.3

DELIMITER // 
CREATE TRIGGER before_update_application
BEFORE UPDATE ON application_details
FOR EACH ROW
BEGIN
    DECLARE active_applications_count INT;
    DECLARE job_start_date DATETIME;

    -- Count the number of active applications for the employee
    SELECT COUNT(*)
    INTO active_applications_count
    FROM application_details
    WHERE cand_usrname = NEW.cand_usrname
        AND status = 'active';

    -- Check if the employee already has three active applications
    IF active_applications_count >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'An employee cannot have more than three active applications.';
    END IF;

    -- Check if the application is being canceled
    IF NEW.status = 'cancelled' THEN
        -- Check if the cancellation date is less than 10 days before the job start date
        SELECT start_date
        INTO job_start_date
        FROM job
        WHERE id = NEW.job_id;
        
        IF NEW.application_date > DATE_SUB(job_start_date, INTERVAL 10 DAY) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'An application cannot be canceled within 10 days before the job start date.';
        END IF;
    END IF;

    -- Check if the canceled application is being reactivated and the user has less than 3 active applications
    IF NEW.status = 'active' AND active_applications_count >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'An employee cannot have more than three active applications.';
    END IF;

END//

DELIMITER ; 


