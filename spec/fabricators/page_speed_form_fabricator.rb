Fabricator(:page_speed_form) do
  site_address { "http://tamars.co.uk" }
  strategy { ["mobile", "desktop"] }
end