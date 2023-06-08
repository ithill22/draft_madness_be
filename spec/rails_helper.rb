# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
require 'simplecov'
SimpleCov.start
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, type: :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://rspec.info/features/6-0/rspec-rails
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.include Capybara::DSL
  config.example_status_persistence_file_path= 'spec/examples.txt'
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('SPORTS_RADAR_API_KEY') { ENV['SPORTS_RADAR_API_KEY'] }
  config.default_cassette_options = { re_record_interval: 7.days }
  config.default_cassette_options = { allow_playback_repeats: true }
  config.configure_rspec_metadata!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

def article_data
  @data = {
    "abstract": "Times sports writer Pete Thamel breaks down the NCAA tournament brackets and highlights the teams to watch. (Producer: Kassie Bracken)",
    "web_url": "https://www.nytimes.com/video/sports/1194817114941/ncaa-tournament-preview.html",
    "snippet": "Times sports writer Pete Thamel breaks down the NCAA tournament brackets and highlights the teams to watch. (Producer: Kassie Bracken)",
    "lead_paragraph": "Times sports writer Pete Thamel breaks down the NCAA tournament brackets and highlights the teams to watch. (Producer: Kassie Bracken)",
    "source": "The New York Times",
    "multimedia": [
        {
            "rank": 0,
            "subtype": "wide",
            "caption": nil,
            "credit": nil,
            "type": "image",
            "url": "images/2006/03/13/sports/Mar13NCAAPREVIEW.190x126.fr.jpg",
            "height": 126,
            "width": 190,
            "legacy": {
                "widewidth": 190,
                "wideheight": 126,
                "wide": "images/2006/03/13/sports/Mar13NCAAPREVIEW.190x126.fr.jpg"
            },
            "subType": "wide",
            "crop_name": "thumbWide"
        },
        {
            "rank": 0,
            "subtype": "videoThumb",
            "caption": nil,
            "credit": nil,
            "type": "image",
            "url": "images/2006/03/13/sports/Mar13NCAAPREVIEW.75x50.fr.jpg",
            "height": 50,
            "width": 75,
            "legacy": {},
            "subType": "videoThumb",
            "crop_name": "videoThumb"
        },
        {
            "rank": 0,
            "subtype": "thumbnail",
            "caption": nil,
            "credit": nil,
            "type": "image",
            "url": "images/2006/03/13/sports/Mar13NCAAPREVIEW.75x75.fr.jpg",
            "height": 75,
            "width": 75,
            "legacy": {
                "thumbnail": "images/2006/03/13/sports/Mar13NCAAPREVIEW.75x75.fr.jpg",
                "thumbnailwidth": 75,
                "thumbnailheight": 75
            },
            "subType": "thumbnail",
            "crop_name": "thumbStandard"
        }
    ],
    "headline": {
        "main": "NCAA Tournament Preview",
        "kicker": nil,
        "content_kicker": nil,
        "print_headline": nil,
        "name": nil,
        "seo": nil,
        "sub": nil
    },
    "keywords": [
        {
            "name": "subject",
            "value": "NCAA BASKETBALL TOURNAMENT",
            "rank": 1,
            "major": "N"
        }
    ],
    "pub_date": "2006-03-13T14:18:19+0000",
    "document_type": "multimedia",
    "news_desk": "",
    "section_name": "Sports",
    "byline": {
        "original": nil,
        "person": [],
        "organization": nil
    },
    "type_of_material": "Video",
    "_id": "nyt://video/cd6682aa-0740-5bdd-9567-faab13866c29",
    "word_count": 0,
    "uri": "nyt://video/cd6682aa-0740-5bdd-9567-faab13866c29"
  }
end