CREATE DATABASE IF NOT EXISTS Messages;

USE Messages;

CREATE TABLE IF NOT EXISTS Messages(
    id int not null auto_increment,
    title varchar(255),
    content varchar(255),
    date varchar(30),
    PRIMARY KEY(id)
);

INSERT INTO Messages (title, content, `date`) VALUES ("Test title", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin quis dui in erat porttitor rutrum nec eget metus.", "12/11/2024");