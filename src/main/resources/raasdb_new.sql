/*
SQLyog Community v11.51 (64 bit)
MySQL - 5.6.27-log : Database - ad_2c6b60203891d7f
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ad_2c6b60203891d7f` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ad_2c6b60203891d7f`;

/*Table structure for table `raas_group_map` */

DROP TABLE IF EXISTS `raas_group_map`;

CREATE TABLE `raas_group_map` (
  `parent_group_name` varchar(100) DEFAULT NULL,
  `child_group_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `raas_group_map` */

/*Table structure for table `raas_group_user_map` */

DROP TABLE IF EXISTS `raas_group_user_map`;

CREATE TABLE `raas_group_user_map` (
  `group_name` varchar(100) DEFAULT NULL,
  `user_name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `raas_group_user_map` */

insert  into `raas_group_user_map`(`group_name`,`user_name`) values ('CPNI','Prakash'),('CPNI','Venkat'),('CPNI','Krishna'),('CMC','Christopher'),('ST','Thasneem');

/*Table structure for table `raas_groups` */

DROP TABLE IF EXISTS `raas_groups`;

CREATE TABLE `raas_groups` (
  `name` varchar(100) DEFAULT NULL,
  `manager` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `raas_groups` */

insert  into `raas_groups`(`name`,`manager`) values ('CPNI','Krishna'),('CMC','Manoj'),('ST','Praveen'),('WG','Prakash'),('CMC','Prakash'),('CPNI','Prakash');

/*Table structure for table `raas_tasks` */

DROP TABLE IF EXISTS `raas_tasks`;

CREATE TABLE `raas_tasks` (
  `task_oid` int(11) NOT NULL AUTO_INCREMENT,
  `task_key` varchar(100) DEFAULT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `status` varchar(100) NOT NULL DEFAULT 'UNASSIGNED',
  `group_name` varchar(100) DEFAULT NULL,
  `created_timestamp` timestamp NULL DEFAULT NULL,
  `work_start_timestamp` timestamp NULL DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `internal_sla` int(11) DEFAULT NULL,
  `external_sla` int(11) DEFAULT NULL,
  PRIMARY KEY (`task_oid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `raas_tasks` */

insert  into `raas_tasks`(`task_oid`,`task_key`,`user_name`,`status`,`group_name`,`created_timestamp`,`work_start_timestamp`,`priority`,`internal_sla`,`external_sla`) values (1,'Task-1','Prakash','ASSIGNED','CPNI','2015-10-29 22:44:41',NULL,10,8,16),(2,'Task-2',NULL,'UNASSIGNED','CPNI','2015-10-29 22:44:41',NULL,5,4,40),(3,'Task-3',NULL,'UNASSIGNED','CMC','2015-10-29 22:44:41',NULL,7,7,21),(4,'Task-4',NULL,'UNASSIGNED','ST','2015-10-29 22:44:41',NULL,3,2,40),(5,'Task-5',NULL,'UNASSIGNED','CMC','2015-10-29 22:44:41',NULL,10,3,6),(6,'Task-6',NULL,'UNASSIGNED','CPNI','2015-10-29 22:44:41',NULL,8,9,18),(7,'Task-7',NULL,'UNASSIGNED','CPNI','2015-10-28 22:44:41',NULL,4,10,48),(8,'Task-8','Venkat','ASSIGNED','CPNI','2015-10-29 22:44:41',NULL,4,3,36),(9,'Task-9',NULL,'UNASSIGNED','CPNI','2015-10-29 22:44:41',NULL,10,5,10);

/*Table structure for table `raas_users` */

DROP TABLE IF EXISTS `raas_users`;

CREATE TABLE `raas_users` (
  `login_id` varchar(100) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `user_role` varchar(100) DEFAULT NULL,
  `lower_bound` int(11) DEFAULT NULL,
  `user_bound` int(11) DEFAULT NULL,
  `max_bound` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `raas_users` */

insert  into `raas_users`(`login_id`,`first_name`,`last_name`,`user_role`,`lower_bound`,`user_bound`,`max_bound`) values ('Prakash','Prakash','MohanKumar','Analyst',2,5,10),('Krishna','KrishnaKumar','Sivasankaran','Admin',2,5,10),('Venkat','Venkat','Mathan','Analyst',2,5,10),('Manoj','Manoj','Mohan','Admin',2,6,10),('Praveen','Praveen','Gopinath','Admin',2,6,10),('Thasneem','Thasneem','Thasneem','Analyst',2,6,10),('Christopher','Christopher','Rajesh','Analyst',2,6,10),('1','11','111','Analyst',2,6,10);

/* Procedure structure for procedure `assign_task` */

/*!50003 DROP PROCEDURE IF EXISTS  `assign_task` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `assign_task`(IN v_login_id VARCHAR(100),IN v_task_key VARCHAR(100),IN v_task_status VARCHAR(100))
BEGIN
	    DECLARE v_group_name VARCHAR(100);
        select group_name into v_group_name from raas_group_user_map where user_name=v_login_id;
        
		UPDATE `raas_tasks` SET user_name=v_login_id,group_name=v_group_name,status=v_task_status 
	    where task_key=v_task_key;
END */$$
DELIMITER ;

/* Procedure structure for procedure `shuffle_priorities_on_sla` */

/*!50003 DROP PROCEDURE IF EXISTS  `shuffle_priorities_on_sla` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `shuffle_priorities_on_sla`()
BEGIN


    declare v_task_oid INT;
    declare v_priority INT;
    declare b_priority INT;
    declare a_priority INT;
    declare f_float	   FLOAT;
    declare v_external_sla,elapsed_time FLOAT;
DECLARE finished INTEGER DEFAULT 0;
	DECLARE cur1 cursor FOR SELECT 
        task_oid,
            priority,
            external_sla,
            elapsed_time
    FROM
        (SELECT 
        `raas_tasks`.`task_oid`,
            `raas_tasks`.`task_key`,
            `raas_tasks`.`user_name`,
            `raas_tasks`.`status`,
            `raas_tasks`.`group_name`,
            `raas_tasks`.`created_timestamp`,
            `raas_tasks`.`work_start_timestamp`,
            `raas_tasks`.`priority`,
            `raas_tasks`.`internal_sla`,
            `raas_tasks`.`external_sla`,
            ((UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP(created_timestamp)) / 3600) 'elapsed_time'
    FROM
        `raas_tasks`
    WHERE
        user_name IS NULL
            AND group_name = 'CPNI'
    ORDER BY priority DESC , (NOW() - created_timestamp) DESC) inner_derived_tbl
    ORDER BY priority DESC , (external_sla - elapsed_time) DESC;

DECLARE CONTINUE HANDLER 
FOR NOT FOUND SET finished = 1;

    
    open cur1;
    
    
	read_loop: LOOP
    FETCH cur1 INTO v_task_oid, v_priority,v_external_sla,elapsed_time;
    IF finished=1 THEN
      LEAVE read_loop;
	END IF;
    
    SET b_priority = v_priority;
    
    set f_float = (v_external_sla/elapsed_time);
	IF  f_float >= 3 THEN
    set v_priority = v_priority * 4;    
   	ELSEIF f_float >= 2 THEN
    set v_priority = v_priority + 3;    
	ELSEIF f_float >= 1 THEN
    set v_priority = v_priority + 1 ;
	END IF;
    
    IF v_priority >= 10 THEN
    SET v_priority = 10;
    END IF;
    
    SET a_priority = v_priority;
    
    IF (a_priority = b_priority)
    THEN
		select concat(concat(v_task_oid,' Task has different priorities '),f_float) oids;
	ELSE
		select concat('Task has same priorities ',v_task_oid) oids;
    END IF;
	UPDATE raas_tasks 
SET 
    priority = v_priority
WHERE
    task_oid = v_task_oid;


    
  END LOOP read_loop;
    
COMMIT;    
    
    
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
