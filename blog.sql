/*
Author: Thomas Jones
Date: 12/02/18
Purpose: Blog database
*/

/* Question 1 */
/* START */
DROP DATABASE IF EXISTS blog;
CREATE DATABASE blog;
USE blog;

DROP TABLE IF EXISTS user;
CREATE TABLE user
(
	user_id INT AUTO_INCREMENT,
	user_email VARCHAR(254) NOT NULL,
	user_display_name VARCHAR(254) NOT NULL,
	datetime_created DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(user_id)
);

DROP TABLE IF EXISTS template;
CREATE TABLE template
(
	template_name VARCHAR(254), 
	template_description VARCHAR(254),
	template_url VARCHAR(254) UNIQUE NOT NULL,
	PRIMARY KEY(template_name)
);


DROP TABLE IF EXISTS blog;
CREATE TABLE blog
(
	blog_id INT AUTO_INCREMENT,
	blog_url VARCHAR(254) UNIQUE NOT NULL,
	blog_title VARCHAR(254) NOT NULL,
	blog_description VARCHAR(254),
	blog_template_name VARCHAR(254) NOT NULL,
	user_id INT NOT NULL,
	PRIMARY KEY(blog_id),
	CONSTRAINT blog_fk_user FOREIGN KEY (user_id) REFERENCES user(user_id),
	CONSTRAINT blog_fk_template FOREIGN KEY (blog_template_name) REFERENCES template(template_name)
);

DROP TABLE IF EXISTS post;
CREATE TABLE post
(
	post_id INT AUTO_INCREMENT,
	post_title VARCHAR(254) NOT NULL,
	post_content TEXT NOT NULL, /* Set to TEXT to hold up to 65,535 characters instead of varchar's 255 max*/
	post_comments_allowed ENUM('Y','N') DEFAULT 'Y' NOT NULL,
	post_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
	blog_id INT NOT NULL,
	PRIMARY KEY(post_id),
	CONSTRAINT post_fk_blog FOREIGN KEY (blog_id) REFERENCES blog(blog_id)
);

DROP TABLE IF EXISTS comment;
CREATE TABLE comment
(
	comment_id INT AUTO_INCREMENT,
	comment_text VARCHAR(254) NOT NULL,
	comment_timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
	user_id INT NOT NULL,
	post_id INT NOT NULL,
	PRIMARY KEY(comment_id),
	CONSTRAINT comment_fk_user FOREIGN KEY (user_id) REFERENCES user(user_id),
	CONSTRAINT comment_fk_post FOREIGN KEY (post_id) REFERENCES post(post_id)
);

DROP TABLE IF EXISTS blog_keyword;
CREATE TABLE blog_keyword
(
	blog_id INT,
	keyword VARCHAR(254) NOT NULL,
	PRIMARY KEY(blog_id,keyword),
	CONSTRAINT keyword_fk_blog FOREIGN KEY (blog_id) REFERENCES blog(blog_id)
);

DROP TABLE IF EXISTS post_keyword;
CREATE TABLE post_keyword
(
	post_id INT,
	keyword VARCHAR(254) NOT NULL,
	PRIMARY KEY(post_id,keyword),
	CONSTRAINT keyword_fk_post FOREIGN KEY (post_id) REFERENCES post(post_id)
);

/* END */

/* QUESTION 2 */
/* START */
/* using default values for id, and timestamp. ID is auto_increment and starts at 1. Timestamp has default current_timestamp */
INSERT INTO user (user_email,user_display_name) VALUES
("joe@gmail.com","Joey"),
("steve@gmail.com","Steve"),
("jane@gmail.com","Jane"),
("lisa@gmail.com","Lisa"),
("mary@gmail.com","Mary"),
("tom@gmail.com","Tom");
/* END */

/* QUESTION 3 */
/* START */
INSERT INTO template VALUES
("cool green",DEFAULT,"http://templates/coolgreen"),
("vibrant ink","Based off the theme from notepad++","http://templates/vibrantink"),
("retro terminal",DEFAULT,"http://templates/retroterminal");
/* END */
/* QUESTION 4 */
/* START */
INSERT INTO blog (blog_url,blog_title,blog_template_name,user_id) VALUES
("www.moneyBlog.com","Copy right law","cool green",1),
("www.joeBlog.com","Daily Blog #268","vibrant ink",1),
("www.databse.com","Why MySQL is better than MS Access","retro terminal",1);
/* END */
/* QUESTION 5 */
/* START */
INSERT INTO blog_keyword VALUES
(1,"copyright"),
(1,"law"),
(1,"intellectual property");
/* END */
/* QUESTION 6 */
/* START */
INSERT INTO post VALUES
(DEFAULT,"What is copyright?","Copyright is a legal concept, enacted by most governments, giving the creator of an original work exclusive rights to it, usually for a limited time. Generally, it is 'the right to copy', but also gives the copyright holder the right to be credited for the work, to determine who may adapt the work to other forms, who may perform the work, who may financially benefit from it, and other, related rights. It is an intellectual property form (like the patent, the trademark, and thetrade secret) applicable to any expressible form of an idea or information that is substantive and discrete.(Ref: Wikipedia)","Y",DEFAULT,1);
/* END */
/* QUESTION 7 */
/* START */
INSERT INTO post_keyword VALUES
(1,"Copyright"),
(1,"law"),
(1,"finance");
/* END */
/* QUESTION 8 */
/* START */
INSERT INTO post VALUES
(DEFAULT,"My three yoyos","Today, I learned how to yo-yo. At the start, learning to walk the dog, and broke one of my yo-yos. Then moving onto my second trick, around the world. That yo-yo was faulty and hit a window, now I'm currently on my third yo-yo, learning how to do the cradle","Y",DEFAULT,2);

INSERT INTO post_keyword VALUES
(2,"YoYo"),
(2,"Daily"),
(2,"Money");
/* END */
/* QUESTION 9 */
/* START */
INSERT INTO user (user_email,user_display_name) VALUES
("kate@gmail.com","Kate"),
("thomas@gmail.com","Thomas");

INSERT INTO blog (blog_url,blog_title,blog_template_name,user_id) VALUES
("www.kate.com","Here there be dragons","cool green",7),
("www.thomas.com","Trials and Tribulations","vibrant ink",8);

INSERT INTO blog_keyword VALUES
(4,"rpg"),
(4,"dragons"),
(5,"TaiChi"),
(5,"Karate");

INSERT INTO post VALUES
(DEFAULT,"What is this?","A new type of roleplaying game where people venture forth into the lair of dragons in 1940","Y",DEFAULT,4),
(DEFAULT,"Peaceful? I will when they will.","Peace is an abstract concept of the flight instinct.","N",DEFAULT,5);

INSERT INTO post_keyword VALUES
(3,"RPG"),
(3,"Lair"),
(4,"Peace"),
(4,"War");

/* END */
/* QUESTION 10 */
/* START */
INSERT INTO comment (comment_text,user_id,post_id) VALUES
("That law is sick yo!",7,1),
("Mad Skillz!",7,2),
("I like that idea, can't wait to hear more!",8,3),
("I agree!",7,4),
("I'll send you a yoyo!",8,2);
/* END */
/* QUESTION 11 */
/* START */
ALTER TABLE user
ADD COLUMN first_name VARCHAR(254) NOT NULL;

ALTER TABLE user
ADD COLUMN sur_name VARCHAR(254) NOT NULL;
/* END */
/* QUESTION 12 */
/* START */
ALTER TABLE post
DROP COLUMN post_timestamp;
/* END */
/* QUESTION 13 */
/* START */
ALTER TABLE blog_keyword
CHANGE keyword blg_keyword VARCHAR(254);
/* END */
/* QUESTION 14 */
/* START */
ALTER TABLE user
RENAME blg_user;
/* END */
/* QUESTION 15 */
/* START */
ALTER TABLE blg_user
ADD COLUMN gender ENUM('M','F');
/* END */
/* QUESTION 16 */
/* START */
ALTER TABLE blog
MODIFY COLUMN blog_description TEXT(300);
/* END */
/* QUESTION 17*/
/* START */
DELETE FROM blog WHERE blog_id = 1;
/* Cannot be run. This cannot be deleted as there are foreign keys relating to it in the post, and blog_keyword relations. To maintain referential integrity these are, by default set to fail if the parent key is attempted to be deleted. We can change this while creating the foreign key by adding the ON DELETE CASCADE, ON DELETE SET NULL constraints.*/
/* END */


