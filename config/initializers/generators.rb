Rails.application.config.generators do |generate|
  generate.helper false
  generate.javascript_engine false
  generate.stylesheets false
  generate.test_framework :rspec,
    fixtures: true,
    view_specs: false,
    helper_specs: false,
    routing_specs: false,
    controller_specs: true,
    request_specs: false
  generate.fixture_replacement :factory_girl, dir: "spec/factories"
end