CREATE DEFINER=`root`@`%` PROCEDURE `sp_users_add`(account_name varchar(30),
first_name varchar(30),
middle_name varchar(30),
last_name varchar(30),
email varchar(30),
phone_number varchar(30),
industry_id int(11),
subindustry_id int(11),
profession_id int(11),
subprofession_id int(11)
)
BEGIN

/*
set account_name = JSON_UNQUOTE(JSON_EXTRACT(params,'$.user_name'));
set first_name = JSON_UNQUOTE(JSON_EXTRACT(params,'$.first_name'));
set middle_name = JSON_UNQUOTE(JSON_EXTRACT(params,'$.middle_name'));
set last_name = JSON_UNQUOTE(JSON_EXTRACT(params,'$.last_name'));
set email = JSON_UNQUOTE(JSON_EXTRACT(params,'$.email'));
set phone_number = JSON_UNQUOTE(JSON_EXTRACT(params,'$.phone_number'));

set industry_id = JSON_EXTRACT(params,'$.industry_id');
set subindustry_id = JSON_EXTRACT(params,'$.subindustry_id');
set profession_id = JSON_EXTRACT(params,'$.profession_id');
set subprofession_id = JSON_EXTRACT(params,'$.subprofession_id');
*/
DECLARE `_rollback` BOOL DEFAULT 0;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET `_rollback` = 1;

START TRANSACTION;

INSERT candidates (account_name, first_name, middle_name, last_name, email, phone_number, industry_id, subindustry_id, profession_id, subprofession_id)
	SELECT	account_name,
			first_name,
			middle_name,
			last_name,
			email,
			phone_number,
			industry_id,
			subindustry_id,
			profession_id,
			subprofession_id;

    IF `_rollback` THEN
        ROLLBACK;
        RESIGNAL;
    ELSE
        COMMIT;

		SELECT	c.candidate_id,
				c.account_name,
				c.first_name,
				c.middle_name,
				c.last_name,
				c.email,
				c.phone_number,
				c.industry_id,
				c.subindustry_id,
				c.profession_id,
				c.subprofession_id
		FROM	candidates c
		WHERE	c.account_name = account_name;

    END IF;


END
