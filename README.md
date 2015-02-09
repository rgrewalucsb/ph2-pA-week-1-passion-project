##Passion Project A

The first passion project should include technologies and competencies discussed in p1-p5

Portfolio 1: Sinatra RESTful CRUD
Portfolio 2: Active Record
Portfolio 3: Authentication And Authorization
Portfolio 4: HTML and CSS
Portfolio 5: Validations and Errors

## BART Station ETA - Passion Project A

1. git clone repository

2. rake db:drop && rake db:create && rake db:migrate && rake db:seed
		-Just to make sure my file is being migrated and seeded correctly.

3. shotgun config.ru

4. open browser and go nuts!


## P1 - P5 Technology Implimented

P1 - All my CRUD routes are pretty damn RESTful
P2 - Built the Users and Stations using Active Record, the actual eta data is from the BART API, which by the way has horrible documentation.
P3 - A user can register and login in order to save their favorite station and destination.
P4 - Used a wide array of HTML/ CSS to get the page looking nice. Using conditionals in erb to only show divs when they have data is an awesome tool.
P5 - Created validations for user registration and login; seperate error messages are displayed to the user depending on the validation. Also modified the show_exception error, in order to tell the user if there are no matching trains headed in his direction.