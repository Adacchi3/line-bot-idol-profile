class Idol < ApplicationController
  def self.profile(name)
    endpoint = URI.parse('https://sparql.crssnky.xyz/spql/imas/query')
    query = "
      PREFIX imas: <https://sparql.crssnky.xyz/imasrdf/URIs/imas-schema.ttl#>
      PREFIX schema: <http://schema.org/>
      PREFIX foaf: <http://xmlns.com/foaf/0.1/>
      
      SELECT DISTINCT *
      WHERE {
        ?s schema:name '#{name}'@ja .
        OPTIONAL { ?s imas:cv ?cv . FILTER( lang(?cv) = 'ja' ) }
        OPTIONAL { ?s schema:description ?description . }
        OPTIONAL { ?s foaf:age ?age . }
        OPTIONAL { ?s schema:height ?height . }
        OPTIONAL { ?s schema:weight ?weight . }
        OPTIONAL { ?s schema:birthDate ?birthDate }
      }LIMIT 1
    "
    endpoint.query = {
      query: query
    }.to_param

    json = Net::HTTP.get(endpoint)
    result = JSON.parse(json)
    vars = result.dig('head','vars')
    vars.delete('s')
    profiles = result.dig('results','bindings')
    return {
      type: 'text',
      text: name
    } if profiles.size == 0

    contents = []
    profile = profiles[0]
    vars.each { |var|
      value = profile.dig(var, 'value')
      contents << 
      {
        type: "box",
        layout: "baseline",
        spacing: "sm",
        contents: [
          {
            type: "text",
            text: var,
            color: "#aaaaaa",
            size: "sm",
            flex: 1
          },
          {
            type: "text",
            text: value,
            wrap: true,
            color: "#666666",
            size: "sm",
            flex: 5
          }
        ]
      } unless value.nil?
    }

    {
      type: "flex",
      altText: "アイドルのプロフィールを閲覧しました。",
      contents: {
        type: "bubble",
        body: {
          type: "box",
          layout: "vertical",
          contents: [
            {
              type: "text",
              text: name,
              weight: "bold",
              size: "xl"
            },
            {
              type: "box",
              layout: "vertical",
              margin: "lg",
              spacing: "sm",
              contents: contents
            }
          ]
        }
      }
    }
  end
end
