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
	blog_description VARCHAR(254) NOT NULL,
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
	post_content VARCHAR(254) NOT NULL,
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
	blog_id INT AUTO_INCREMENT,
	keyword VARCHAR(254) NOT NULL,
	PRIMARY KEY(blog_id,keyword),
	CONSTRAINT keyword_fk_blog FOREIGN KEY (blog_id) REFERENCES blog(blog_id)
);

DROP TABLE IF EXISTS post_keyword;
CREATE TABLE post_keyword
(
	post_id INT AUTO_INCREMENT,
	keyword VARCHAR(254) NOT NULL,
	PRIMARY KEY(post_id,keyword),
	CONSTRAINT keyword_fk_post FOREIGN KEY (post_id) REFERENCES post(post_id)
);

/* END */

/* QUESTION 2 */
/* START */
/* using default values for id, and timestamp. ID is auto_increment and starts at 0. Timestamp has default current_timestamp */
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