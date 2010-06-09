Sanitize::Config::CUSTOM = {
:attributes =>
{ "colgroup"=>["span", "width"],
  "col"=>["span", "width"],
  "ul"=>["type"],
  "a"=>["href", "title "],
  "img"=>["align", "alt", "height", "src", "title", "width"],
  "blockquote"=>["cite"],
  "td"=>["abbr", "axis", "colspan", "rowspan", "width"],
  "table"=>["summary", "width"],
  "q"=>["cite"],
  "ol"=>["start", "type"],
  "th"=>["abbr", "axis", "colspan", "rowspan", "scope", "width"],
  "object" => ["width", "height"],
  "param" => ["name", "value"],
  "embed" => ["src", "allowscriptaccess", "allowfullscreen", "width", "height"]
},
  :protocols=>{"a"=>{"href"=>["ftp", "http", "https", "mailto", :relative]}, "img"=>{"src"=>["http", "https", :relative]}, "blockquote"=>{"cite"=>["http", "https", :relative]}, "q"=>{"cite"=>["http", "https", :relative]}},

:elements=>["a", "b", "blockquote", "br", "caption", "cite", "code", "col", "colgroup", "dd", "dl", "dt", "em", "i", "img", "li", "ol", "p", "pre", "q", "small", "strike", "strong", "sub", "sup", "table", "tbody", "td", "tfoot", "th", "thead", "tr", "u", "ul" , "embed", "object", "param"]}
