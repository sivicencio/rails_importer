# Rails Importer
[![Build Status](https://travis-ci.org/sivicencio/rails_importer.svg?branch=master)](https://travis-ci.org/sivicencio/rails_importer)

Rails Importer is an engine where importer classes can be defined for massive spreadsheet/csv load of data, based on your needs.

It allows you to load a spreadsheet using the browser and process it, but you can also use the import logic in a browser-less way. Spreadsheets are loaded and processed using your own **custom rules**. It is flexible enough to let you do things like creating an ActiveRecord model, call third-party services, or anything you wish to do with each row of data.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_importer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rails_importer

## Getting Started

First you need to install gem

```ruby
rails generate rails_importer:install
```

This will add basic setup and an initializer at `config/initializers/rails_importer.rb`

Here you can basically add new generated importer classes (check  [this](#importers) for more details).

```ruby
# config/initializers/rails_importer.rb

RailsImporter.setup do |config|
  config.importers << ExampleImporter
end
```

## Importers
An importer can be defined as a class inheriting from `RailsImporter::Base`, and has to at least implement the `load_data` method.

You can generate an importer class as shown below:

```ruby
rails generate rails_importer:importer Example
```

This will do the following:

- Create new *importer* file at `lib/rails_importer/example_importer.rb`
- Update *importers* list inside the initializer

Importer behavior must be defined in order to correctly import spreadsheet rows. You must implement the `load_data` method, which receives a `row` array, with each element containing the associated column.

```ruby
# lib/rails_importer/example_importer.rb

class ExampleImporter < RailsImporter::Base
  # Load a file and the get data from each file row
  #
  # @params
  #   row   => A row to be processed
  def load_data(row:)
    # Implement this with custom logic. Otherwise, it will raise an exception
  end
end
```

Note: you can give the importer any name you want, but it is highly recommended to use one that describes its purpose.

## Routes

You can mount the engine routes inside your routes file:

```ruby
# config/routes.rb

mount RailsImporter::Engine, at: '/'

# If you need to mount it as a nested resource
resources :resource do
  mount RailsImporter::Engine, at: '/'
end
```

You'll have basically two routes:

 - `GET importers/:importer_key/new` which defaults to a form with a file field
 - `POST importers/:importer_key` which tries to process the spreadsheet

The `importer_key` param is used to determine which importer class must be used.


## Controller

Routes described above are handled by the `RailsImporter::ImportsController` controller. If you need custom logic, you can override it.

Besides that, the `after_import_path` controller method is used to redirect after successful imports. It defaults to `root_path`, but you can override it if you wish a custom path:

```ruby
# app/controllers/application_controller.rb

def after_import_path
  # Change this if you wish to set a different path
  context.root_path
end
```
The `context` variable used above contains the app routes, so don't forget to use it.

## Sample files
You can add a sample file for each importer if you wish to communicate the spreadsheet structure your importer follows.

The sample file must be located inside the `lib/rails_importer/templates/` folder and have the same name as your importer key. For the `ExampleImporter` used above, the path would be: `lib/rails_importer/templates/example.xslx`

The import form has a link to the sample file. If you do not declare the file, then this link will redirect to `after_import_path`.

Note: `.xlsx` sample files are the only ones currently supported (for now).

## Import Job
When processing an import file, an ActiveJob instance is used. If you're deploying to production, you will want to use some active job adapter, such as [Sidekiq](https://github.com/mperham/sidekiq).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sivicencio/rails_importer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
