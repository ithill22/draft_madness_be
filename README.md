# Draft Madness - March Madness Draft Game Rails App

Draft Madness is a Rails application that brings the excitement of March Madness to your fingertips. It allows users to participate in a thrilling fantasy game where they draft their own set of teams from the 64-team pool and earn points based on the multiplier of each team's seed. The app provides live score updates, leaderboard rankings, and offers bonus prizes for correctly predicting the championship winner and highest-seed success.

## Features

- User Registration and Authentication: Users can create accounts, log in, and securely authenticate themselves to participate in the game.
- Team Drafting: Participants can select their preferred teams from the 64-team pool and build their roster for the tournament.
- Score Calculation: The app automatically calculates scores based on the multiplier of each winning team's seed, providing real-time updates on user standings.
- Live Score Updates: Users can stay up to date with the latest scores and game progress as the tournament unfolds.
- Leaderboard Rankings: A dynamic leaderboard displays the rankings of participants based on their accumulated points, allowing users to track their progress and compete with others.
- Bonus Prizes: Participants have the opportunity to win bonus prizes by correctly predicting the championship winner and the team with the highest-seed success.
- Admin Dashboard: An admin interface provides administrative capabilities to manage users, teams, and game settings.

## Installation and Setup

1. Clone the repository and navigate to the project directory.
2. Run `bundle install` to install the required dependencies.
3. Configure the database settings in `config/database.yml`.
4. Run `rails db:create` to create the database.
5. Run `rails db:migrate` to run the database migrations.
6. (Optional) Run `rails db:seed` to seed the database with initial data.
7. Start the Rails server with `rails server`.
8. Access the application by visiting `http://localhost:3000` in your web browser.

## Technologies Used

- Ruby on Rails: A powerful web development framework used for building the application's backend and handling server-side logic.
- HTML/CSS: The standard markup language and styling techniques used for creating the application's user interface.
- JavaScript: Used for implementing interactive features and enhancing the user experience.
- PostgreSQL: A robust and reliable relational database management system for storing user and game data.

## Contributions

Contributions to this project are welcome! If you find any issues or have ideas to enhance the app, please feel free to open an issue or submit a pull request. Make sure to follow the project's code of conduct.

## License

This project is licensed under the [MIT License](LICENSE), which allows you to use, modify, and distribute the code for both commercial and non-commercial purposes. See the `LICENSE` file for more details.

## Acknowledgements

We would like to express our gratitude to the creators of Ruby on Rails and all the open-source libraries and frameworks that made this project possible.

Enjoy the excitement of March Madness with Draft Madness!