Fabricator(:page_speed_result) do
  address { "http://tamars.co.uk" }
  strategy { "mobile" }
  rule_groups { {"SPEED": {"score": 77}, "USABILITY": {"score": 100}} }
  stats { {"numberHosts": 13, "numberResources": 76, "cssResponseBytes": "726299", "htmlResponseBytes": "46373", "numberJsResources": 32, "totalRequestBytes": "8778", "imageResponseBytes": "197115", "numberCssResources": 19, "otherResponseBytes": "434270", "numberStaticResources": 62, "javascriptResponseBytes": "1754503"} }
  insights { {"MinifyCss": {"groups": ["SPEED"], "summary": {"args": [{"key": "LINK", "type": "HYPERLINK", "value": "https://developers.google.com/speed/docs/insights/MinifyResources"}], "format": "Your CSS is minified. Learn more about {{BEGIN_LINK}}minifying CSS{{END_LINK}}."}, "ruleImpact": 0.0, "localizedRuleName": "Minify CSS"} } }
  problems { {"major": 1, "minor": 15} }
end